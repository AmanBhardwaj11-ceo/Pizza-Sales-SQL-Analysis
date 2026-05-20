/* 
===================================================================
Magnitude Analysis
Purpose:
 -To quantify data and group result by specific dimensions.
 -For understanding data distribution across categories.
Funtions used:
 -SUM(),COUNT()
===================================================================
*/

----Find the Total Revenue and Total Quantity by pizza_category
---------------------------------------------------------------
SELECT pizza_category,
SUM(quantity) AS quantity_by_category,
SUM(total_price) AS total_revenue
FROM pizza_sales_final
GROUP BY pizza_category
ORDER BY SUM(total_price) DESC;


--Find the Total Revenue and Total Quantity by pizza size 
-----------------------------------------------------------
SELECT pizza_size,
SUM(quantity) AS quantity_by_category,
SUM(total_price) AS total_revenue
FROM pizza_sales_final
GROUP BY pizza_size
ORDER BY SUM(total_price) DESC;

--Find the Total Revenue and Total Quantity by pizza_name 
-----------------------------------------------------------
SELECT pizza_name,
SUM(quantity) AS quantity_by_category,
SUM(total_price) AS total_revenue
FROM pizza_sales_final
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC;

--Find the Total pizza_name_id by category
-------------------------------------------
select 
pizza_category,
count(pizza_name_id)
from pizza_sales_final
group by pizza_category 
--Find the Total pizza_name_id by pizza_size
---------------------------------------------
select 
pizza_size,
count(pizza_name_id)
from pizza_sales_final
group by pizza_size;