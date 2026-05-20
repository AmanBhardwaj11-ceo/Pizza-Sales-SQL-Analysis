/* 
=================================================================================
Measures Exploration(Key Metrics)
Purpose: 
 - To calculate aggregated metrics(e.g, Total's, Averages ) for quick insights.
 - To idetify overall trends or spot anomalies. 
Function used: 
 -SUM(),AVG(),COUNT(),CAST(),ROUND(),DISTINCT()
 =================================================================================
*/

--Find  the Total Revenue 
SELECT 
SUM(total_price) AS Total_revenue 
FROM pizza_sales_final 

--Find the Average Pizza Sales
SELECT CAST(ROUND(AVG(total_price),2) AS DECIMAL(10,2)) AS Avg_sales
FROM pizza_sales_final

--Find the Total Quantity 
SELECT SUM(quantity) AS Total_quantity
FROM pizza_sales_final

--Find the Total Orders 
SELECT COUNT(order_id) AS Total_orders FROM pizza_sales_final

SELECT COUNT(DISTINCT order_id ) AS Unique_orders FROM pizza_sales_final

--Find Average Order Values 
SELECT 
CAST(ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS DECIMAL(10,2)) AS Avg_order_values
FROM pizza_sales_final

--Find the Total Count of Pizza Names
SELECT count(distinct(pizza_name)) AS Pizza_names FROM pizza_sales_final

SELECT pizza_name AS Pizza_names FROM pizza_sales_final--Count with Pizza Names
GROUP BY pizza_name

--Generate all key metrics 
SELECT 'Total Revenue ' AS measure_name ,SUM(total_price) AS total_values FROM pizza_sales_final
UNION ALL
SELECT'Avg Revenue',CAST(ROUND(AVG(total_price),2) AS DECIMAL(10,2))FROM pizza_sales_final
UNION ALL
SELECT'Total Orders',COUNT(order_id) FROM pizza_sales_final
UNION ALL
SELECT'Total Unique Orders',COUNT(DISTINCT order_id) FROM pizza_sales_final
UNION ALL
SELECT'Avg Order Values',CAST(ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS DECIMAL(10,2))
FROM pizza_sales_final
UNION ALL
SELECT 'Total Quantity',SUM(quantity) FROM pizza_sales_final
UNION ALL
SELECT'Total Pizza Names',COUNT(distinct(pizza_name)) FROM pizza_sales_final








