create database sql_practice_05;

use sql_practice_05;

create table sales_data(
sales_date date,
shop_id varchar(5),
sales_amount int
);

INSERT INTO sales_data (sales_date, shop_id, sales_amount) VALUES
('2024-03-20', 'S001', 5000),
('2024-03-21', 'S002', 7000),
('2024-03-22', 'S003', 4500),
('2024-03-23', 'S001', 8000),
('2024-03-24', 'S002', 6000),
('2024-03-25', 'S003', 7500),
('2024-03-26', 'S001', 9000),
('2024-03-27', 'S002', 6500),
('2024-03-28', 'S003', 5000),
('2024-03-29', 'S001', 7200);


# Total count of sales for each shop using window function
# Working functions - SUM(), MIN(), MAX(), COUNT(), AVG()

select * ,count(*) over(partition by shop_id) as total_sale_count_by_shops
from sales_data;

select * ,sum(sales_amount) over(partition by shop_id) as total_sale_count_by_shops
from sales_data;

select  shop_id, count(*) as total_sale_count_by_shops from sales_data group by shop_id;

select *, count(*) over(partition by shop_id order by sales_amount desc) as total_sale_count_by_shops
from sales_data;

# if we only use order by in over clause 
select * , sum(sales_amount) over(order by sales_amount desc) as total_sum_of_sales from sales_data;

# if we only use partition
select * , sum(sales_amount) over(partition by shop_id) as total_sum_of_sales from sales_data;

# If we only use Partition By & Order By together
select *, sum(sales_amount) over(partition by shop_id order by sales_amount desc) as total_sum_of_sales
from sales_data;

select shop_id ,count(*) as total_sales_count_by_shops from sales_data group by shop_id;

create table amazon_sales(
  sales_date date,
  sales_amount int
);

INSERT INTO amazon_sales (sales_date, sales_amount) VALUES
('2024-03-20', 10000),
('2024-03-21', 12000),
('2024-03-22', 9500),
('2024-03-23', 15000),
('2024-03-24', 11000),
('2024-03-25', 17500),
('2024-03-26', 13000),
('2024-03-27', 14000),
('2024-03-28', 15500),
('2024-03-29', 16000);

# Calculate the date wise rolling average of amazon sales
 select * from amazon_sales;
 
 select * ,avg(sales_amount) over(order by sales_date) as rolling_avg from amazon_sales;

 select * ,avg(sales_amount) over(order by sales_date) as rolling_avg,
 sum(sales_amount) over(order by sales_date) as rolling_sum
 from amazon_sales;
 
 # Rank(),ROW_Number,Dense_Rank() window function 
 
# ROW_NUMBER()	Assigns unique row numbers
# RANK()	Assigns ranks with gaps for duplicates
# DENSE_RANK()	Assigns ranks without gaps
# NTILE(n)	Splits rows into n buckets
# SUM()	Running total
# AVG()	Running average
# COUNT()	Counts rows in a window
# LEAD()	Gets next row’s value
# LAG()	Gets previous row’s value
# FIRST_VALUE()	Gets first row’s value
# LAST_VALUE()	Gets last row’s value


create table shop_sales_data(
sales_date date,
shop_id varchar(5),
sales_amount int
);



insert into shop_sales_data values('2022-02-19','S1',400);
insert into shop_sales_data values('2022-02-20','S1',400);
insert into shop_sales_data values('2022-02-22','S1',300);
insert into shop_sales_data values('2022-02-25','S1',200);
insert into shop_sales_data values('2022-02-15','S2',600);
insert into shop_sales_data values('2022-02-16','S2',600);
insert into shop_sales_data values('2022-02-16','S3',500);
insert into shop_sales_data values('2022-02-18','S3',500);
insert into shop_sales_data values('2022-02-19','S3',300);

select * from shop_sales_data;

select * , row_number() over(partition by shop_id order by sales_amount desc) as row_num,
rank() over(partition by shop_id order by sales_amount desc) as rank_num,
dense_rank() over(partition by shop_id order by sales_amount desc) as dense_num
from shop_sales_data;

# temp tables Example 
create table employees
(
    emp_id int,
    salary int,
    dept_name VARCHAR(30)
);

INSERT INTO employees (emp_id, salary, dept_name) VALUES
(1, 60000, 'HR'),
(2, 75000, 'IT'),
(3, 50000, 'Sales'),
(4, 82000, 'IT'),
(5, 45000, 'Sales'),
(6, 90000, 'Finance'),
(7, 62000, 'HR'),
(8, 54000, 'Marketing'),
(9, 72000, 'IT'),
(10, 67000, 'Finance');

# Query - get one employee from each department who is getting 
# maximum salary (employee can be random if salary is same)

select 
	tmp.* 
		from (select * , row_number() over(partition by dept_name order by salary desc) as row_num
from employees ) tmp where tmp.row_num = 1 ;

# Query - get one employee from each department who is getting maximum salary 
# (employee can be random if salary is same)

select 
    tmp.*
from (select *,
        row_number() over(partition by dept_name order by salary desc) as row_num
    from employees) tmp
where tmp.row_num = 1;

# Query - get all employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        rank() over(partition by dept_name order by salary desc) as rank_num
    from employees) tmp
where tmp.rank_num = 1;

# Query - get all top 2 ranked employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        dense_rank() over(partition by dept_name order by salary desc) as dense_rank_num
    from employees) tmp
where tmp.dense_rank_num <= 2;

# Example for lag and lead

create table daily_sales(
sales_date date,
sales_amount int);

insert into daily_sales values('2022-03-11',400);
insert into daily_sales values('2022-03-12',500);
insert into daily_sales values('2022-03-13',300);
insert into daily_sales values('2022-03-14',600);
insert into daily_sales values('2022-03-15',500);
insert into daily_sales values('2022-03-16',200);
insert into daily_sales values('2022-03-20',900);
insert into daily_sales values('2022-03-23',200);
insert into daily_sales values('2022-03-25',300);
insert into daily_sales values('2022-03-29',250);



select * from daily_sales;

select * ,lag(sales_amount,1) over(order by sales_date) as pre_day_sales,
lead(sales_amount,1) over(order by sales_date) as post_day_sales
from daily_sales;

# Query - Calculate the differnce of sales with previous day sales
# Here null will be derived

select sales_date,
sales_amount as curnt_date_sales ,
lag(sales_amount, 1) over(order by sales_date) as prev_day_sales,
       sales_amount - lag(sales_amount, 1) over(order by sales_date) as sales_diff
from daily_sales;

# Here we can replace null with 0

select sales_date,
sales_amount as curnt_date_sales ,
lag(sales_amount, 1,0) over(order by sales_date) as prev_day_sales,
       sales_amount - lag(sales_amount, 1,0) over(order by sales_date) as sales_diff
from daily_sales;

# Diff between lead and lag
select *,
      lag(sales_amount, 1) over(order by sales_date) as pre_day_sales
from daily_sales;

select *,
      lead(sales_amount, 1) over(order by sales_date) as next_day_sales
from daily_sales;


# how to use frame clause - Row Between

select * from daily_sales;

select * ,sum(sales_amount) over(order by sales_date rows between 1 preceding and 1 following ) as 
prev_plus_next_sales_sum
from daily_sales;

select * ,sum(sales_amount) over(order by sales_date rows between 1 preceding and current row ) as 
prev_plus_next_sales_sum
from daily_sales;

select * ,sum(sales_amount) over(order by sales_date rows between current row and 1 following ) as 
prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between 2 preceding and 1 following)
      as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and current row) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between current row and unbounded following) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and unbounded following) as prev_plus_next_sales_sum
from daily_sales;

# Alternate way to esclude computation of current row
select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and unbounded following) - sales_amount as prev_plus_next_sales_sum
from daily_sales;

# How to work with Range Between

select *,
      sum(sales_amount) over(order by sales_amount range between 100 preceding and 200 following) as prev_plus_next_sales_sum
from daily_sales;


# Calculate the running sum for a week
# Calculate the running sum for a month

select * from daily_sales;

select *,
       sum(sales_amount) over(order by sales_date range between interval '6' day preceding and current row) as running_weekly_sum
from daily_sales;

