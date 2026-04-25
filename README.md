# e-commerce
## Diagram
<img width="971" height="851" alt="Schema Diagram drawio" src="https://github.com/user-attachments/assets/973f7320-edeb-48ea-9f65-cec4b9530eaf" />

# How can we apply a denormalization mechanism on customer and order entities

 We can add to the order table with customer-name, as if the customer gets the reports,  we can improve speed instead of joining 3 tables to speed up reports

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
