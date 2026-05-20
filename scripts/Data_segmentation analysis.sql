/*
========================================================================
Part-to-Whole Analysis
Purpose:
 -To group data into meaningful categories for targeted insights.
 -To compare performace or metrics across dimensions or time periods.
 -To evaluate difference between categories.
 -Useful for A/B testing or regional comparisons.

Functions Used:
 -CASE: Defins custom segmentation logic.
 -DATEPART(),SUM(),CAST()
 -Window Functions: SUM() OVER() for Percentage calculations.
========================================================================
*/


--Find the Total Revenue and Total Quantity by Time Slots: Morning,Afternoon,Evening and Night?
--Find the Total Revenue Percentage sharing between Time slots?
----------------------------------------------------------------------------------------------------
WITH slot_time AS(
SELECT 
 DATEPART(HOUR,order_time)AS Hour_,
 SUM(total_price) AS Total_revenue,
 SUM(quantity) AS Total_quantity
 FROM pizza_sales_final
 GROUP BY DATEPART(HOUR,order_time)
),
slot_time_2 AS(
SELECT 
CASE
 WHEN Hour_ <=12 AND Hour_!=0 THEN 'Morning'
 WHEN Hour_ >12 AND Hour_<=15 THEN 'Afternoon'
 WHEN Hour_>=16 AND Hour_<=19  THEN 'Evening'
 WHEN Hour_>19 AND Hour_<=24 THEN 'Night'
 ELSE 'n/a'
END  AS Time_name,
Total_revenue,
Total_quantity
FROM slot_time 
)
SELECT 
Time_name AS Time_Name,
SUM(Total_revenue) AS Total_Revenue,
CAST(CAST((SUM(Total_revenue)*100.0/SUM(SUM(Total_revenue)) OVER()) AS DECIMAL(10,2)) AS VARCHAR)+'%' AS  '%byRevenue',
SUM(Total_quantity) AS Total_Quantity
FROM slot_time_2
GROUP BY Time_name
ORDER BY SUM(Total_revenue) DESC;


--Find the Total Revenue Percentage sharing between Pizza's Category?
-----------------------------------------------------------------------
WITH Category AS (
 SELECT 
 pizza_category,
 total_price
 FROM pizza_sales_final
 ) 
SELECT 
pizza_category AS Pizza_category,
SUM(total_price) AS Total_revenue ,
CAST(CAST((SUM(total_price)*100.0/SUM(SUM(total_price)) OVER()) AS DECIMAL(10,2)) AS VARCHAR)+'%' AS  '%byRevenue'
FROM Category
GROUP BY pizza_category
ORDER BY SUM(total_price) DESC

/* 
Group quantity into three segments(Quantity Demands) based on their selling behaviour:
 -HIGH: quantity with at least 2000 and more than.
 -MEDIUM: quantity with more than and equal to 1000 but less than 2000. 
 -LOW: quantity with more than and equal to 0 but less than 1000. 

And Categories the Pizza Name and Total Quantity with Quantity Demands. 
----------------------------------------------------------------------
*/

WITH quantity_name AS(
 SELECT 
 pizza_name AS Pizza_name,
 SUM(quantity) AS Total_quantity
 FROM pizza_sales_final
 GROUP BY pizza_name
 ),
 quantity_name_2 AS(
 SELECT 
 Pizza_name,
 Total_quantity,
 CASE 
  WHEN Total_quantity>=2000 THEN 'HIGH'
  WHEN Total_quantity>=1000 THEN 'MEDIUM'
  WHEN Total_quantity>=0 THEN 'LOW'
  ELSE 'n/a'
END Quantity_demand
FROM quantity_name
)
SELECT 
Pizza_name AS Pizza_Name,
Total_quantity,
Quantity_demand
FROM quantity_name_2

