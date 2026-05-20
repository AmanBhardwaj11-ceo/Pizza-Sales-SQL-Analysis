 
 --(Advanced Analysis)-
--======================--

/*
 Weekly Analysis
 ====================================================
 Purpose:
  -Identify the busiest days of the week to optimize 
   shift scheduling, kitchen staffing, and preparation
======================================================
*/
--Find the Total Quantity,Total Orders and Total Revenue by weekly
-------------------------------------------------------------------
SELECT 
DATEPART(WEEKDAY,order_date) AS Weekly_orders,
DATENAME(WEEKDAY,order_date) AS Weekly_names,
SUM(quantity) AS Total_quantity,
COUNT(DISTINCT order_id) as Total_orders,
SUM(total_price) AS Total_revenue
FROM pizza_sales_final
GROUP BY DATEPART(WEEKDAY,order_date),DATENAME(WEEKDAY,order_date);

--Find out which Pizza Size dominates each day of the week?
---------------------------------------------------------------
WITH Rank_sizes AS (
    SELECT 
        DATENAME(WEEKDAY, order_date) AS Week_names,
        Pizza_size,
        SUM(quantity) AS Total_quantity,
        CAST(SUM(total_price) AS DECIMAL(10,2)) AS Revenue,
        -- Rank sizes within each day based on quantity sold
        DENSE_RANK() OVER (
            PARTITION BY DATENAME(WEEKDAY, order_date) 
            ORDER BY SUM(quantity) DESC
        ) AS Size_rank,
        DATEPART(WEEKDAY, order_date) AS Day_number -- Kept for sorting the final output
    FROM pizza_sales_final
    GROUP BY 
        DATENAME(WEEKDAY, order_date), 
        DATEPART(WEEKDAY, order_date), 
        Pizza_size
)
SELECT 
    Week_names,
    Pizza_size AS Best_selling_size,
    Total_quantity,
    Revenue AS Size_revenue
FROM Rank_sizes
WHERE Size_rank = 1 -- Filters to show only the top-selling size for every day
ORDER BY Day_number;


--Find the Total quantity,Total revenue and Revenue percentage for different Pizzas category in different Time slots?
----------------------------------------------------------------------------------------------------------------------
WITH slot_time AS(
SELECT 
 pizza_category AS Pizza_category,
 DATEPART(HOUR,order_time)AS Hour_,
 SUM(total_price) AS Total_revenue,
 SUM(quantity) AS Total_quantity
 FROM pizza_sales_final
 GROUP BY DATEPART(HOUR,order_time),pizza_category
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
Pizza_category,
Total_revenue,
Total_quantity
FROM slot_time 
)
SELECT 
Time_name AS Time_Name,
pizza_category AS Pizza_Category,
SUM(Total_quantity) AS Total_Quantity,
SUM(Total_revenue) AS Total_Revenue,
CAST(CAST((SUM(Total_revenue)*100.0/SUM(SUM(Total_revenue)) OVER()) AS DECIMAL(10,2)) AS VARCHAR)+'%' AS  '%byRevenue'
from slot_time_2
group by Time_name,pizza_category
Order by SUM(Total_revenue) DESC;
 
/*
Ingredient Frequency Analysis
===================================
Find the most Ingredient Used in pizza
--------------------------------------
*/
WITH SplitIngredients AS (
 SELECT RTRIM(LTRIM(value)) AS Ingredient
 From pizza_sales
 Cross Apply STRING_SPLIT(pizza_ingredients,',')
 )
 SELECT Ingredient,COUNT(*) AS Time_Ordered
 From SplitIngredients
 Group by Ingredient
 order by Time_Ordered DESC;

/*
 Cumulative Analysis
=====================================================================
 Purpose:
  -To track performance over time cumulatively.
  -Useful for growth analysis or identifying long-term trends.
 Functions Used:
  -Window Functions :SUM() OVER(),AVG() OVER()
  -LAG(),DATEPART(),DATENAME(),CAST()

=====================================================================

 Calculate:
    -Find the total revenue by Months
    -Find the Running revenue,Running Average and Moving Average by Months
*/
------------------------------------------------------------------------------
  WITH Monthly_sales AS (
  SELECT 
   DATEPART(MONTH,order_date) AS Order_months,
   DATENAME(MONTH,order_date) AS Monthly_name,
   SUM(total_price) AS Monthly_revenue ,
   AVG(total_price) AS Avg_price,
   CAST(
   SUM(SUM(Total_price))OVER(ORDER BY MONTH(order_date))*100/SUM(SUM(Total_price))OVER() 
   AS DECIMAL(10,2)) AS Moving_percentage
   FROM pizza_sales_final
   GROUP BY  DATEPART(MONTH,order_date),DATENAME(MONTH,order_date)
   )
   SELECT 
    Monthly_name,
    CAST(Monthly_revenue AS DECIMAL(10,2)) AS Monthly_Revenue,
    CAST(LAG(Monthly_revenue) OVER(ORDER BY Order_months) AS DECIMAL(10,2)) AS Previous_Month_Revenue,
    CAST(SUM(Monthly_revenue) OVER(ORDER BY Order_months) AS DECIMAL(10,2)) AS Running_Month_Revenue,
    CAST(Moving_percentage AS varchar)+'%' AS Moving_percenatge,
    AVG(Avg_price) OVER(ORDER BY order_months) AS Moving_average
    FROM Monthly_sales
    ORDER BY Order_months;



--Find the Monthly orders and revenue by pizza category?
---------------------------------------------------------
   SELECT
   MONTH(order_date) AS Monthly_Orders,
   pizza_category AS Pizza_category,
   SUM(total_price)AS Total_sales
   FROM pizza_sales_final
   GROUP BY MONTH(order_date),pizza_category
   ORDER BY MONTH(order_date),pizza_category;

/*
   Performance Analysis(Month-over-Month)
=================================================================
  purpose: 
     -For benchmarking and identifying high-performing entities.
     -To track monthly trends and growth.
  Functions Used:
     -LAG():Accesses data from previous rows.
     -AVG() OVER(): Computes average values within partitions.
     -CASE: Defines conditional logic for trend analysis.
==================================================================

 # Analyze the monthly performance of pizzas category by comparing their revenue to both the average 
   sales performance of pizza's category and previous month's revenue*/
-----------------------------------------------------------------------------------------------------------

   WITH monthly_pizza_sales AS (
   SELECT
   pizza_category,
   MONTH(order_date) AS Monthly_order,
   SUM(total_price) AS Total_revenue
   FROM pizza_sales_final
   GROUP BY 
    MONTH(order_date),
    pizza_category 
   )
   SELECT 
   Monthly_order,
   pizza_category,
   Total_revenue,
   AVG(Total_revenue) OVER(Partition by pizza_category) AS avg_sales,
   Total_revenue - AVG(Total_revenue) OVER(Partition by pizza_category) AS diff_avg,
   CASE 
    WHEN Total_revenue - AVG(Total_revenue) OVER(Partition by pizza_category)>0 THEN 'Above avg'
    WHEN Total_revenue - AVG(Total_revenue) OVER(Partition by pizza_category)<0 THEN 'Below avg'
    ElSE 'Avg'
   END AS Avg_change,

  ---Month-over-Month Analysis
   LAG(Total_revenue) OVER(Partition by pizza_category ORDER BY Monthly_order) AS Previous_sales,
   Total_revenue - LAG(Total_revenue) OVER(Partition by pizza_category ORDER BY Monthly_order) AS Diff_sales,
   CASE 
    WHEN Total_revenue - LAG(Total_revenue) OVER(Partition by pizza_category ORDER BY Monthly_order)>0 THEN 'Increase'
    WHEN Total_revenue - LAG(Total_revenue) OVER(Partition by pizza_category ORDER BY Monthly_order)<0 THEN 'Decrease'
    ELSE 'No_change'
   END AS Previous_change 
   FROM monthly_pizza_sales
   ORDER BY pizza_category,Monthly_order;
