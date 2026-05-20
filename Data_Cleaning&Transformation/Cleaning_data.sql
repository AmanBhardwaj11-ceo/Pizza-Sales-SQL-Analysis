--(Checking For Null Values And Empty String)--
SELECT
*
FROM pizza_sales
WHERE pizza_id IS NULL OR  pizza_id='' 
OR order_id IS NULL OR  order_id=''
OR quantity IS NULL OR  quantity =''
OR unit_price IS NULL OR unit_price=''
OR total_price IS NULL OR total_price=''
OR order_date IS NULL OR order_date=''
OR order_time IS NULL OR order_time=''
OR pizza_name_id IS NULL OR pizza_name_id=''
OR pizza_size IS NULL OR pizza_size=''
OR pizza_category IS NULL OR pizza_category=''
OR pizza_ingredients IS NULL OR pizza_ingredients=''
OR pizza_name IS NULL OR pizza_name='' ;

--Result(no data found)


--(Checking For Duplicate Values For pizza_id And order_id) --
SELECT 
pizza_id
FROM pizza_sales 
GROUP BY pizza_id
HAVING COUNT(pizza_id)>1;
--Result(no data found)

SELECT
order_id
FROM pizza_sales
GROUP BY order_id
HAVING count(order_id)>1
--Result(data found)

--(Checking for Range and Logic Validation) --
--This is where you check if the Data actually makes sense from a Business perspective.

--#Price Check
SELECT unit_price FROM pizza_sales
WHERE  unit_price<=0;
--Result(no data found)

--#Quantity Check
SELECT quantity FROM pizza_sales
WHERE quantity=0;
--Result(no data found)

--#Date Check (2015)
SELECT 
MIN(order_date) AS first_order,
MAX(order_date) AS last_order
FROM pizza_sales;
--found data( first_order='2015-01-01' and last_order='2015-12-31'


--( Categorical Consistency )--
--In the 'pizza_category' or 'pizza_size' columns,look for spelling variations.

--#Uniqueness Check
SELECT 
DISTINCT pizza_category 
FROM pizza_sales;
--found data(Classic,Chicken,Veggie,Supreme)

SELECT 
DISTINCT pizza_size
FROM pizza_sales;
--found data(M,S,L,XL,XXL)

--update pizza_size 
SELECT
CASE 
WHEN upper(trim(pizza_size))='M' THEN 'Medium' 
WHEN upper(trim(pizza_size))='S' THEN 'Small'
WHEN upper(trim(pizza_size))='L' THEN 'Large'
WHEN upper(trim(pizza_size))='XL' THEN 'Extra_Large'
WHEN upper(trim(pizza_size))='XXL' THEN 'Extra Extra Large'
END pizza_size_fullname
FROM pizza_sales;


--( Mathematical Reconciliation )--
--The 'total_price' should always equal 'quantity*unit_price'

SELECT * 
FROM pizza_sales 
WHERE total_price<>(quantity*unit_price);
--Result(no data found)


