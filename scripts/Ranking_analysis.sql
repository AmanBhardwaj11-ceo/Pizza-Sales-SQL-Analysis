/* 
==================================================================
Ranking Analysis
Purpose:
 -To Rank items based on performance or other metrics.
 - To identify top performance or laggards.

SQL Functions Used:
 -Window Ranking Functions: RANK(),DENSE_RANK(),ROW_NUMBER(),TOP
 -Clauses: GROUP BY,ORDER BY 
==================================================================
*/

--Which 5 pizza_name's Generating the Highest Revenue?
--Simple (using top function)
-------------------------------------------------------
SELECT TOP 5 
pizza_name AS Pizza_name,
SUM(total_price) AS Total_revenue
FROM pizza_sales_final
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC;

--Using window function
SELECT *
FROM (SELECT 
pizza_name AS Pizza_name,
SUM(total_price) AS Total_revenue,
RANK() OVER(ORDER BY SUM(total_price)DESC) AS Rank_pizza
FROM pizza_sales_final
GROUP BY pizza_name) AS rnk
WHERE rank_pizza<=5;

--Which 5 pizza_name's Generating the Lowest Revenue?
------------------------------------------------------
SELECT *
FROM (SELECT 
pizza_name AS Pizza_name,
SUM(total_price) AS Total_revenue,
RANK() OVER(ORDER BY SUM(total_price)ASC) AS Rank_pizza
FROM pizza_sales_final
GROUP BY pizza_name) AS rnk
WHERE rank_pizza<=5


--Which 5 pizza_name's Generating the Highest Quantity?
--------------------------------------------------------
SELECT *
FROM (SELECT 
pizza_name AS Pizza_name,
COUNT(quantity) AS Total_quantity,
RANK() OVER(ORDER BY SUM(quantity)DESC) AS Rank_pizza
FROM pizza_sales_final
GROUP BY pizza_name) AS rnk
WHERE rank_pizza<=5


--Which 5 pizza_name's Generating the Lowest Quantity?
--------------------------------------------------------
SELECT *
FROM (SELECT 
pizza_name AS Pizza_name,
COUNT(quantity) AS Total_quantity,
RANK() OVER(ORDER BY SUM(quantity)ASC) AS Rank_pizza
FROM pizza_sales_final
GROUP BY pizza_name) AS rnk
WHERE rank_pizza<=5

--Which 10 Order ID has High Revenue and High Quantity orders?
---------------------------------------------------------------
SELECT*
FROM
(SELECT 
order_id AS Order_id,
SUM(total_price) AS Total_revenue,
COUNT(quantity) AS Total_quantity,
ROW_NUMBER() OVER(ORDER BY SUM(total_price) DESC) AS Rank_orders
FROM pizza_sales_final
GROUP BY order_id) AS Rnk
WHERE Rank_orders <=10

--Which 10 Order ID has Low Revenue and Low Quantity orders?
--------------------------------------------------------------
SELECT*
FROM
(SELECT 
order_id AS Order_id,
SUM(total_price) AS Total_revenue,
COUNT(quantity) AS Total_quantity,
ROW_NUMBER() OVER(ORDER BY SUM(total_price) ASC) AS Rank_orders
FROM pizza_sales_final
GROUP BY order_id) AS Rnk
WHERE Rank_orders <=10


