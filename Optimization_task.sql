use ecommerece


-- 6.Write SQL Query to Retrieve the total number of products in each category.


EXPLAIN ANALYZE
SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM Category c
LEFT JOIN Product p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name

 -- The optimized query  
    
    
 Explain analyze SELECT 
    c.category_id, 
    c.category_name, 
    COALESCE(p.total_products, 0) AS total_products
FROM Category c
LEFT JOIN (
    SELECT category_id, COUNT(*) AS total_products
    FROM Product
    GROUP BY category_id
) p ON c.category_id = p.category_id;



-- 6.Write SQL Query to Find the top customers by total spending.
Explain analyze SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(op.total_amount), 0) AS total_spent
FROM ecommerece.customer AS c
LEFT JOIN ecommerece.order_products AS op
    ON c.customer_id = op.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_spent DESC;

-- adding covering index

CREATE INDEX idx_order_products_customer_amount
ON ecommerece.order_products (customer_id, total_amount);

-- the optimization query 

Explain analyze SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    op.total_spent
FROM (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM ecommerece.order_products
    GROUP BY customer_id
) AS op
JOIN ecommerece.customer AS c
    ON c.customer_id = op.customer_id
ORDER BY op.total_spent DESC; 

-- 7. Write SQL Query to Retrieve the most recent orders with customer information with 1000 orders.

Explain analyze 
SELECT
    op.order_id,
    op.customer_id,
    c.first_name,
    c.last_name,
    op.order_date
FROM ecommerece.customer c
INNER JOIN ecommerece.order_products op
    ON c.customer_id = op.customer_id
ORDER BY op.order_date DESC
LIMIT 1000;

CREATE INDEX idx_order_date_customer
ON ecommerece.order_products(order_date, customer_id);

-- 8. Write SQL Query to List products that have low stock quantities of less than 10 quantities.

Explain analyze SELECT p.product_id, p.name ,p.description ,p.price 
From ecommerece.Product p 
where p.Quantity_Stock <10

CREATE INDEX idx_Product_Quantity_Stock
ON ecommerece.Product(Quantity_Stock);

UPDATE Product
SET quantity_stock = FLOOR(RAND() * 1000) + 1;

UPDATE Product
SET quantity_stock = FLOOR(RAND() * quantity_stock) + 1;

select p.Quantity_Stock , count(Quantity_Stock)
from ecommerece.Product p group by p.Quantity_Stock 


-- 9. Write SQL Query to Calculate the revenue generated from each product category.
explain analyze
select c.category_name -- ,count(p.product_id),  
COALESCE(SUM(od.quantity * od.unit_price),0) AS total_sales
from ecommerece.Category c 
left join ecommerece.Product p on c.category_id =p.category_id 
left join ecommerece.order_detials od on od.product_id =p.product_id 
group by  c.category_name 

EXPLAIN Analyze 
SELECT
    c.category_id,
    c.category_name,
    COALESCE(
        SUM(od.quantity * od.unit_price),
        0
    ) AS total_sales
FROM ecommerece.Category AS c
LEFT JOIN ecommerece.Product AS p
    ON p.category_id = c.category_id
LEFT JOIN ecommerece.order_detials AS od
    ON od.product_id = p.product_id
GROUP BY
    c.category_id,
    c.category_name;

CREATE INDEX idx_order_details_product_sales
ON ecommerece.order_detials(product_id, quantity, unit_price);

CREATE INDEX idx_product_category_product
ON ecommerece.Product (
    category_id,
    product_id
);


CREATE INDEX idx_order_details_product_id
ON ecommerece.order_detials (product_id);

