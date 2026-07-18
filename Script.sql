SELECT *
FROM Product
WHERE name LIKE '%camera%' OR  description LIKE '%camera%';

ALTER TABLE Product
ADD FULLTEXT (name, description);

SELECT
product_id,
name,
description,
price
FROM Product
WHERE MATCH(name, description)
AGAINST ('camera' IN NATURAL LANGUAGE MODE);


SELECT
    p.product_id,
    p.name,
    p.price,
    SUM(od.quantity) AS total_sales
FROM Product p
JOIN order_detials od
    ON od.product_id = p.product_id
WHERE p.category_id = (
        SELECT category_id
        FROM Product
        WHERE product_id = :purchased_product_id
)
AND p.author_id = (
        SELECT author_id
        FROM Product
        WHERE product_id = :purchased_product_id
)
AND p.product_id <> :purchased_product_id
GROUP BY
    p.product_id,
    p.name,
    p.price
ORDER BY total_sales DESC
LIMIT 5;



CREATE TABLE SalesHistory (
    history_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    order_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (order_id) REFERENCES order_detials(order_detials_id)
);


DELIMITER $$

CREATE TRIGGER after_order_detail_insert
AFTER INSERT ON order_detials -- نفس الاسم المكتوب بالخطأ الإملائي في الصورة
FOR EACH ROW
BEGIN
    DECLARE var_customer_id INT;

    SELECT customer_id INTO var_customer_id
    FROM order_products 
    WHERE order_id = NEW.order_id;

    -- 2. إدخال البيانات كاملة في جدول سجل المبيعات
    INSERT INTO SalesHistory (customer_id, product_id, order_id, quantity, unit_price)
    VALUES (var_customer_id, NEW.product_id, NEW.order_id, NEW.quantity, NEW.unit_price);
END$$

DELIMITER ;

-- بدء المعاملة
START TRANSACTION;

-- جلب الحقل وقفل الصف بأكمله لمنع التحديث من أي مكان آخر
SELECT * 
FROM Product 
WHERE product_id = 211 
FOR UPDATE;

-- هنا تضع عملياتك البرمجية...

-- إنهاء المعاملة وفك القفل
COMMIT;
