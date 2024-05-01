-- pizza project---

 * FROM project.domino_pizza_sales;
select * from project.domino_pizza_sales order by 7 desc limit 5;

--total revenue
SELECT sum(total_price) FROM project.domino_pizza_sales;
--817860.049999993

--average order value
SELECT sum(total_price)/count(Distinct order_id) as average_order_value FROM project.domino_pizza_sales;
--38.307262295081635

--Total Pizza sold
select sum(quantity) as total_pizza_sold from project.domino_pizza_sales;
--49574

--total order
select count(distinct order_id) as total_orders from project.domino_pizza_sales;
--21350

--Average pizzas per order
select round(sum(quantity)/count(distinct order_id),2) as average_pizza_per_order  from project.domino_pizza_sales;
--2.32

--Chart Requirement

--daily trends for total order

-- select DATENAME(WD,order_date) as order_day,count(distinct order_id) as total_order from project.domino_pizza_sales
group by DATENAME(WD,order_date) -- MS SQL SERVER SYNTAX


use project;
select * from project.domino_pizza_sales;


select order_date from project.domino_pizza_sales;

select replace(order_date,'-','/') from project.domino_pizza_sales;
SET SQL_SAFE_UPDATES=0;

update project.domino_pizza_sales
set order_date = replace(order_date,'-','/');

update project.domino_pizza_sales
set order_date = str_to_date(order_date,'%dd/%mm/%YYYY');

desc project.domino_pizza_sales;

ALTER TABLE project.domino_pizza_sales
MODIFY COLUMN order_date  Date;

update project.domino_pizza_sales
set order_date = replace(order_date,'-','/');


select order_time from project.domino_pizza_sales;

update project.domino_pizza_sales
set order_time = str_to_date(order_time,'%h,%m,%s');

ALTER TABLE project.domino_pizza_sales
MODIFY COLUMN order_time  time;




select dayname(ORDER_DATE)  as order_day,count(distinct order_id) as total_order from project.domino_pizza_sales
group by dayname(ORDER_DATE);


---monthly trend for order

select MONTHNAME(order_date) as order_day,count(distinct order_id) as total_order from project.domino_pizza_sales
group by MONTHNAME(order_date);


--% SALES BY PIZZA CATEGORY

select pizza_category,round(sum(total_price),2) as total_revenue,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from project.domino_pizza_sales) AS DECIMAL(10,2)) AS PCT
from project.domino_pizza_sales
group by pizza_category;

--% SALES BY PIZZA SIZE

select pizza_size,round(sum(total_price),2) as total_revenue,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from project.domino_pizza_sales) AS DECIMAL(10,2)) AS PCT
from project.domino_pizza_sales
group by pizza_size;

--total pizza sold bypizza category

select pizza_category, sum(quantity) 
from project.domino_pizza_sales
group by pizza_category
order by sum(quantity) desc;

--op 5 pizza by total price
SELECT  pizza_name, SUM(total_price) AS Total_Revenue
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
limit 5;

--bottom 5 pizza by total price

SELECT  pizza_name, SUM(total_price) AS Total_Revenue
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue
limit 5;
--top 5 pizza by quantity
SELECT  pizza_name, SUM(quantity) as Total_Pizza_Sold
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold desc
limit 5;

--bottom 5 pizza by quantity
SELECT  pizza_name, SUM(quantity) as Total_Pizza_Sold
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold
limit 5;

--top 5 pizza by total_order

SELECT  pizza_name, count(distinct order_id) as Total_order
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_order desc
limit 5;

--bottom 5 pizza by total_order
SELECT  pizza_name, count(distinct order_id) as Total_order
FROM project.domino_pizza_sales
GROUP BY pizza_name
ORDER BY Total_order
limit 5;









