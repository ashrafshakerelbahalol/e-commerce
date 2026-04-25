# e-commerce
## Diagram
<img width="971" height="851" alt="Schema Diagram drawio" src="https://github.com/user-attachments/assets/973f7320-edeb-48ea-9f65-cec4b9530eaf" />

# How can we apply a denormalization mechanism on customer and order entities

 We can add to the order table with customer-name, as if the customer gets the reports,  we can improve speed instead of joining 3 tables to speed up reports

## schema
``` SQL
create table Category (
category_name varchar(255) unique not null ,
categoty_id  int Primary key
);
create table Product (
product_id Bigint Primary key,
price float not null ,
description  varchar(255) not null,
name varchar(50) not null,
category_id int not null,
Foreign key (category_id) references Category(categoty_id)
);
create table customer (
customer_id bigint primary key,
first_name varchar(50) not null,
last_name varchar (50) not null,
password  varchar (255)not null,
email varchar(100) unique not null
);
create table order_products (
order_id bigint primary key,
total_amount double ,
order_date timestamp default current_timestamp ,
customer_id bigint not null ,
foreign key (customer_id) references customer(customer_id)
);
create table order_detials(
order_id bigint not null,
product_id Bigint not null,
order_detials_id bigint primary key,
quantity int not null ,
unit_price double not null,
Foreign key (order_id) references order_products(order_id),
Foreign key (product_id) references Product(product_id)
);
```
 
## Queries
```SQL
-- Write an SQL query to generate a daily report of the total revenue for a specific date.
select count(*) as count , sum(total_amount) As 'total amount', Date(order_date) As date_of_day 
from order_products
WHERE Date(order_date) = '2026-04-10'
group by date_of_day ;

-- * Write an SQL query to generate a monthly report of the top-selling products in a given month.
select sum(d.quantity) as count , p.name ,  p.product_id ,sum((d.quantity)*d.unit_price) AS 'total price'
from order_detials d inner join product p
on d.product_id= p.product_id
inner join order_products o 
on d.order_id = o.order_id
WHERE o.order_date >= '2026-03-01' AND o.order_date < '2026-04-01'
group by product_id,name
order by count desc ;

-- Write a SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month. 
-- Include customer names and their total order amounts.
select first_name,last_name,sum(total_amount)
from customer c inner join order_products o
on o.customer_id= c.customer_id
where YEAR(order_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) 
and month(order_date) = month(CURRENT_DATE - INTERVAL 1 MONTH)
group by c.customer_id, c.first_name, c.last_name
having sum(total_amount) >500;
```
