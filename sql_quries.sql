create table retail_sales_project.sales (
 transactions_id INT,
 sale_date DATE,
 sale_time TIME,
 customer_id INT,
 gender VARCHAR(10),
 age INT,
 category VARCHAR(50),
 quantity INT,
 price_per_unit DECIMAL(10,2),
 cogs DECIMAL(10,2),
 total_sale DECIMAl(10,2)
 );
 
LOAD DATA LOCAL INFILE 'C:/Users/Praniket Udawant/OneDrive/Desktop/SQL - Retail Sales Analysis.csv'
INTO TABLE retail_sales_project.sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select*from retail_sales_project.sales
order by transactions_id limit 10;

select count(*)
from retail_sales_project.sales;

select*from retail_sales_project.sales
where transactions_id is null;

select * from retail_sales_project.sales
where gender = ''
or category = '';

delete from retail_sales_project.sales
where age = 0
or Quantity = 0
or price_per_unit = 0
or cogs = 0
or total_sale = 0;
 
 select count(*) as total_rows from
 retail_sales_project.sales;
 
select transactions_id, count(*) as duplicate_count 
from retail_sales_project.sales
group by transactions_id
having count(*) > 1; 

describe retail_sales_project.sales;

SELECT transactions_id , COUNT(*) AS duplicate_count
FROM retail_sales_project.sales
GROUP BY transactions_id
ORDER BY COUNT(*) DESC;

-- DATA EXPLORATION
-- HOW MANY TRANSACTIONS WE HAVE
select count(*) as total_sales from retail_sales_project.sales;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE
select count(distinct customer_id) as total_customers from retail_sales_project.sales;

-- HOW MANY unique CATEGORYS WE HAVE 
select count(distinct category) as unique_category from retail_sales_project.sales;

-- UNIQUE CATEGORY WITH NAME WITHOUT NUMBER
select distinct category  from retail_sales_project.sales;

-- DATA ANALYSIS AND BUSINESS KEY PROBLEMS
-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales_project.sales 
where sale_date = '2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
-- the quantity sold is more than 4 in the month of Nov-2022

select * from retail_sales_project.sales
where 
   category = 'Clothing' 
   AND
   date_format(sale_date, '%Y-%m') = '2022-11'
   AND  quantity >='4';
      
select count(*) from retail_sales_project.sales
where category = 'Clothing';

select count(*) from retail_sales_project.sales
where category = 'Clothing' AND quantity > 4;

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale),
count(*) as total_orders from retail_sales_project.sales
group by 1;

-- 4.Write a SQL query to find the average age of 
-- customers who purchased items from the 'Beauty' category

select round(avg(age),2) as avg_age, category from retail_sales_project.sales
where category = 'Beauty';

-- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000.

select count(total_sale) as '>1000' from retail_sales_project.sales
where total_sale > '1000';

-- 6.Write a SQL query to find the total number of transactions 
-- (transaction_id) made by each gender in each category.

select count(*) as totalno_oftrans, gender, category from retail_sales_project.sales
group by gender, category;

-- 7.Write a SQL query to calculate the average sale 
-- for each month. Find out best selling month in each year.  

select YEAR(sale_date) as year,
       month(sale_date) as month,
	   avg(total_sale) as avg_sale 
	   from retail_sales_project.sales
 group by year(sale_date), 
 month(sale_date)
 order by year, month;

SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS bestselling_month,
    AVG(total_sale) AS avg_sale
FROM retail_sales_project.sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, avg_sale DESC;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT
    customer_id as top5_customers,
    SUM(total_sale) AS total_sales
FROM retail_sales_project.sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9.Write a SQL query to find the number of unique customers who purchased items from 
-- each category.

select category, count(distinct customer_id) as no_of_uniquecustomers
from retail_sales_project.sales
group by category;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, 
-- Afternoon Between 12 & 17, Evening >17)

select case
      when sale_time < '12.00.00' then 'Morning'
      when sale_time >= '12.00.00' and sale_time < '17.00.00' then 'Afternoon'
      else 'Evening'
      end as shifts,
      count(customer_id) as no_of_orders
      from retail_sales_project.sales
      group by shifts;
      
-- End of Project
      
      
      
      
      
      
      
      
      
      

