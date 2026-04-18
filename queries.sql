-- Write an SQL query to generate a daily report of the total revenue for a specific date.
select count(*) as count , sum(total_amount) As 'total amount', Date(order_date) As date_of_day 
from order_products
group by date(order_date);

-- * Write an SQL query to generate a monthly report of the top-selling products in a given month.
select count(*) as count , sum(total_amount) As 'total amount',  DATE_FORMAT(order_date, '%M %Y') AS 'month' 
from order_products
group by DATE_FORMAT(order_date, '%M %Y');

-- Write a SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month. 
-- Include customer names and their total order amounts.
select first_name,last_name,sum(total_amount)
from customer c inner join order_products o
on o.customer_id= c.customer_id
where YEAR(order_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) 
and month(order_date) = month(CURRENT_DATE - INTERVAL 1 MONTH)
group by c.customer_id, c.first_name, c.last_name
having sum(total_amount) >500;



