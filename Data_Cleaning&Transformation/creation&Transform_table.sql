
IF OBJECT_ID('pizza_sales_final','U') IS NOT NULL 
DROP TABLE pizza_sales_final;
--Creation of the new table--
CREATE TABLE  pizza_sales_final
( pizza_id FLOAT,
order_id FLOAT,
pizza_name_id NVARCHAR(50),
quantity FLOAT,
order_date DATE,
order_time TIME,
unit_price DECIMAL,
total_price DECIMAL,
pizza_size NVARCHAR(50),
pizza_category NVARCHAR(50),
pizza_ingredients NVARCHAR(100),
pizza_name NVARCHAR(50)
)
--deleting data if exists any pervious data
TRUNCATE TABLE pizza_sales_final
--('inserting data into [pizza_sales_final] from [pizza_sales] )
INSERT INTO  pizza_sales_final(
pizza_id,
order_id,
pizza_name_id,
quantity,
order_date,
order_time,
unit_price,
total_price,
pizza_size,
pizza_category,
pizza_ingredients,
pizza_name)

SELECT 
pizza_id,
order_id,
pizza_name_id,
quantity,
order_date,
order_time,
CAST(ROUND(unit_price,2)AS DECIMAL(10,2)),
CAST(ROUND(total_price,2)AS DECIMAL(10,2)),
CASE 
WHEN upper(trim(pizza_size))='M' THEN 'Medium' 
WHEN upper(trim(pizza_size))='S' THEN 'Small'
WHEN upper(trim(pizza_size))='L' THEN 'Large'
WHEN upper(trim(pizza_size))='XL' THEN 'Extra_Large'
WHEN upper(trim(pizza_size))='XXL' THEN 'Extra Extra Large'
ELSE 'n/a'
END pizza_size,
pizza_category,
pizza_ingredients,
pizza_name
FROM pizza_sales



