-- Categories
INSERT INTO Category (categoty_id, category_name) VALUES 
(1, 'Electronics'),
(2, 'Home Appliances'),
(3, 'Stationery');

-- Customers (Using simulated password hashes)
INSERT INTO customer (customer_id, first_name, last_name, email, password) VALUES 
(10, 'Omar', 'Zaid', 'omar@email.com', '$2b$12$K9...hashed'),
(11, 'Laila', 'Nour', 'laila@email.com', '$2b$12$P1...hashed');

INSERT INTO Product (product_id, name, description, price, category_id) VALUES 
(201, 'Smartphone X', 'Latest model with 128GB storage', 850.00, 1),
(202, 'Laptop Pro', 'High performance for developers', 1500.00, 1),
(203, 'Air Fryer', 'Healthy cooking with less oil', 120.00, 2),
(204, 'Notebook', 'A5 size, 100 pages', 5.50, 3);

INSERT INTO order_products (order_id, total_amount, order_date, customer_id) VALUES 
-- March Orders (Last Month)
(601, 1700.00, '2026-03-02 14:20:00', 10),
(602, 45.50,   '2026-03-05 09:15:00', 11),
(603, 850.00,  '2026-03-12 18:45:00', 10),
(604, 120.00,  '2026-03-20 11:00:00', 11),
(605, 2350.00, '2026-03-28 16:30:00', 10),

-- April Orders (This Month)
(606, 11.00,   '2026-04-02 10:00:00', 11),
(607, 1500.00, '2026-04-05 13:00:00', 10),
(608, 250.00,  '2026-04-10 15:20:00', 11),
(609, 855.50,  '2026-04-15 09:45:00', 10),
(610, 5.50,    '2026-04-17 17:00:00', 11);

INSERT INTO order_detials (order_detials_id, order_id, product_id, quantity, unit_price) VALUES 
-- Details for Order 601 (Total 1700)
(7001, 601, 202, 1, 1500.00), 
(7002, 601, 203, 1, 120.00), 
(7003, 601, 201, 1, 80.00), -- Discounted/Partial price

-- Details for Order 602 (Total 45.50)
(7004, 602, 204, 5, 5.50),
(7005, 602, 203, 1, 18.00), -- Small accessory version

-- Details for Order 603 (Total 850)
(7006, 603, 201, 1, 850.00),

-- Details for Order 605 (Total 2350)
(7007, 605, 202, 1, 1500.00),
(7008, 605, 201, 1, 850.00),

-- Details for Order 607 (Total 1500)
(7009, 607, 202, 1, 1500.00),

-- Details for Order 609 (Total 855.50)
(7010, 609, 201, 1, 850.00),
(7011, 609, 204, 1, 5.50);