# Retail_sales_SQL_project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `project

This project aims to showcase essential SQL skills and techniques commonly used by data analysts to explore, clean, and interpret retail sales data. It involves creating a retail sales database, conducting exploratory data analysis (EDA), and answering key business questions using SQL queries. It's an excellent starting point for beginners in data analysis who want to develop a strong foundation in SQL.`


## Objectives

1. **Database Setup**: Build and populate a retail sales database using the provided data.
2. **Data Cleaning**: Detect and eliminate records containing missing or null values to ensure data accuracy.
3. **Exploratory Data Analysis (EDA)**: Conduct initial analysis to gain a better understanding of the dataset.
4. **Business Insights**: Write SQL queries to address key business questions and extract meaningful insights from the sales data.

```sql
CREATE DATABASE project;

CREATE TABLE retail_sales
(
    transaction_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    Gender VARCHAR(200),
    age INT,
    category VARCHAR(200),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

  SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT*
FROM retail_sales
where Sales_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
   
```sql
SELECT
*
FROM retail_sales
where Category = 'Clothing'
AND date_format (Sales_time, 'YYYY-MM-DD') = '2022-11'
AND Quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
   Category,
  round(AVG(Age)) AS avg_customers_age
FROM retail_sales
where Category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT
    total_sale
FROM retail_sales
WHERE total_sale > 1000;
```
6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
    Gender,
    category,
    count(transaction_id) as Total_transactions
FROM retail_sales
GROUP BY Category, Gender
order by 1;

```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
...

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
    customer_id as customers,
    sum(total_sale) as highest_sale
FROM retail_sales
group by 1
order by 1, 2 desc
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
   category,
   count(distinct(customer_id)) as Num_of_uni_cums
FROM retail_sales
group by 1;
```

-- Write a SQL Query to create each shift and number of orders(Example morning <=12, Afternoon Between 12 & 17, Evening >27

...SQL 
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

....

--     END OF PROJECT


##Findings

-Customer Demographics: The dataset features a wide range of customer age groups, with purchases spread across key categories like Clothing and Beauty.
-High-Value Transactions: A notable number of transactions exceeded a total sale value of 1000, suggesting the presence of premium buyers.
-Sales Trends: Monthly analysis revealed fluctuations in sales, highlighting periods of peak activity and seasonal trends.
-Customer Insights: The data helped identify top-spending customers and revealed the most frequently purchased product categories.

##Reports
-Sales Summary: Provides a comprehensive overview of total sales, customer profiles, and product category performance.
-Trend Analysis: Delivers insights into monthly sales trends and identifies patterns across different time periods.
-Customer Insights: Highlights high-value customers and presents unique customer counts by product category.

##Conclusion
This project offers a solid foundation in SQL for aspiring data analysts, guiding users through database creation, data cleaning, exploratory analysis, and writing business-focused queries. The insights derived from the analysis enable a deeper understanding of customer behavior, sales trends, and product performance—valuable assets for data-driven decision-making in retail.
