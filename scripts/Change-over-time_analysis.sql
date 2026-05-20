
/* 
Change Over Time Analysis
================================================================
Purpose:
 -To track trends, growth and changes in key metrics over time.
 -For time-series analysis and identifying seasonality.
 -To measure growth or decline over specific periods.

Functions used:
 -Data Functions:DATEPART(),DATETRUNC(),FORMAT()
 -Aggregate Functions: SUM(),COUNT(),AVG()
 -Window Functions:RANK(),ROW_NUMBER()
=================================================================
*/


--Find the Total Orders ,Total Revenue and Total Quantity by Months?
---------------------------------------------------------------------
SELECT
DATEPART(MONTH,order_date) AS Months,
FORMAT(order_date,'MMM') AS Months_name,
COUNT(DISTINCT order_id) AS Total_orders,
SUM(total_price) AS Total_revenue,
COUNT(quantity) AS Total_quantity
FROM pizza_sales_final
GROUP BY DATEPART(MONTH,order_date),FORMAT(order_date,'MMM')
ORDER BY DATEPART(MONTH,order_date)ASC

--Find the Total Orders ,Total Revenue and Total Quantity by Hours? 
--------------------------------------------------------------------
SELECT 
DATEPART(HOUR,order_time) AS Day_hours,
COUNT(DISTINCT order_id) AS Orders,
SUM(quantity) AS Total_quantity,
SUM(total_price) AS Total_revenue
FROM pizza_sales_final
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)

--Which of the 3 Months has the highest Revenue?
------------------------------------------------
SELECT * FROM
(SELECT 
FORMAT(order_date,' MMM') AS Months,
SUM(total_price) AS Total_revenue,
COUNT(quantity) AS Total_quantity,
RANK() OVER(ORDER BY SUM(total_price) DESC ) AS Rank
FROM pizza_sales_final
group by FORMAT(order_date,' MMM')) AS rnk
WHERE Rank<=3

--Which of the 3 Months has the lowest Revenue?
-------------------------------------------------
SELECT * FROM
(SELECT 
FORMAT(order_date,' MMM') AS Months,
SUM(total_price) AS Total_revenue,
COUNT(quantity) AS Total_quantity,
RANK() OVER(ORDER BY SUM(total_price) ASC ) AS Rank
FROM pizza_sales_final
group by FORMAT(order_date,' MMM')) AS rnk
WHERE Rank<=3








