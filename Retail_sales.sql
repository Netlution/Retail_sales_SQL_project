SELECT * FROM project.retail_sales
limit 20;

select 
count(*)
from retail_sales;

-- DATA CLEANING
select*from retail_sales
where 
  transaction_id is NULL
  or
  sales_time is NULL
  or
 sales_date is NULL
  or
 customer_id is NULL
  or
 Gender is NULL
 or
 Age is NULL
 or
 Category is NULL
or
 Quantity is NULL
or
price_per_unit is NULL
or
cog is NULL
or
total_sale is NULL;

-- DATA EXPLORATION

-- How many total sales will have?
select count(total_sale) as total_sale from retail_sales;

-- How many unigue customers will have?
select count(distinct(customer_id)) as customers from retail_sales;

-- How many unigue category will have?
select count(distinct(Category)) from retail_sales;

-- Names of the category?
select distinct(Category) as Category from retail_sales;

-- DATA ANALYSIS AND BUSINESS KEY UESTIONS AND ANSWERS

-- write a SQL Query to retrieve all columns for sales made on "2022-11-05

SELECT*
FROM retail_sales
where Sales_date = '2022-11-05';

-- write a SQL Query to retrieve all transactions where category is 'clothings' and the Quantity sold is more than in the month of nov 2022 

SELECT
*
FROM retail_sales
where Category = 'Clothing'
AND date_format (Sales_time, 'YYYY-MM-DD') = '2022-11'
AND Quantity >= 4;

-- write a SQL Query to calculate the total sales (total_sales) for each category

SELECT 
      Category, 
      SUM(total_sale) AS net_sales,
      count(total_sale) as total_orders
FROM retail_sales
GROUP BY 1;

-- write a SQL Query to find the avearge age of customers who purchased items from the 'Beauty' category

SELECT 
   Category,
  round(AVG(Age)) AS avg_customers_age
FROM retail_sales
where Category = 'Beauty';

-- write a SQL Query to find all transactions where the total_sale is greater than 1000

SELECT
    total_sale
FROM retail_sales
WHERE total_sale > 1000;

--  write a SQL Query to find the total number of transactions(Transaction_id) made by each gender in each category

SELECT
    Gender,
    category,
    count(transaction_id) as Total_transactions
FROM retail_sales
GROUP BY Category, Gender
order by 1;

--  write a SQL Query to calculate the average sale for each month, and find out the best selling month in each

SELECT* FROM
(

	SELECT
		Year(sales_date) as Year,
		Month(Sales_date) as month,
	   round(avg(total_sale)) as Avg_sale,
	RANK() OVER(
			PARTITION BY YEAR(sales_date)
			ORDER BY AVG(total_sale) DESC
		) AS sale_rank
		
	FROM retail_sales
	GROUP by 1, 2

) as Rank2
where sale_rank = 1;

-- order by 1, 2, 3 desc


--  write a SQL Query to find the top 5 customers based on the highest total sales

SELECT
    customer_id as customers,
    sum(total_sale) as highest_sale
FROM retail_sales
group by 1
order by 1, 2 desc
LIMIT 5;

-- Write a SQL Query to find the number of uniQue customers who purchased items from each category

SELECT
   category,
   count(distinct(customer_id)) as Num_of_uni_cums
FROM retail_sales
group by 1;

-- Write a SQL Query to create each shift and number of orders(Example morning <=12, Afternoon Between 12 & 17, Evening >27


with hourly_sale
AS
(
SELECT 
    case
      when hour(sales_time) <12 then 'Morning'
      when hour(sales_time) between 12 and 17 then 'Afternoon'
      else 'Evening'
	END as shift
From retail_sales
)

SELECT
    shift,
    count(*) as total_sale
    FROM hourly_sale
    Group by shift

   

--     END OF PROJECT







