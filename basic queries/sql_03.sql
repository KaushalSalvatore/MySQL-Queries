create database sql_practice_03;

create table if not exists employee(
id int,
name varchar(50),
age int,
hiring_date date,
salary int,
city varchar(50)
);
INSERT INTO employee (id, name, age, hiring_date, salary, city)
VALUES
(1, 'Amit Sharma', 25, '2022-05-15', 45000, 'Mumbai'),
(2, 'Neha Gupta', 29, '2021-08-10', 52000, 'Delhi'),
(3, 'Rahul Verma', 32, '2020-11-20', 60000, 'Bangalore'),
(4, 'Pooja Singh', 28, '2023-01-25', 48000, 'Hyderabad'),
(5, 'Vikram Thakur', 35, '2019-07-05', 75000, 'Chennai'),
(6, 'Meena Joshi', 26, '2022-03-18', 41000, 'Pune'),
(7, 'Karan Mehta', 31, '2020-10-30', 58000, 'Ahmedabad'),
(8, 'Sonal Patil', 27, '2023-06-12', 46500, 'Kolkata'),
(9, 'Ramesh Iyer', 33, '2021-09-09', 69000, 'Surat'),
(10, 'Swati Desai', 24, '2022-12-01', 39000, 'Jaipur'),
(11, 'Arjun Malhotra', 30, '2020-02-14', 53000, 'Lucknow'),
(12, 'Priya Nair', 28, '2021-04-22', 47000, 'Coimbatore'),
(13, 'Suresh Kumar', 34, '2019-12-19', 72000, 'Indore'),
(14, 'Nikita Rao', 26, '2022-08-16', 42000, 'Nagpur'),
(15, 'Ankit Saxena', 29, '2023-03-08', 49000, 'Patna'),
(11, 'bhanu Sharma', 25, '2022-05-15', 45000, 'Mumbai');

select * from employee;

SET SQL_SAFE_UPDATES = 0;

-- update multiple value 
update employee set age = 20 , salary = '56000' where name = 'nikita rao';

select * from employee;

-- auto increment id 
create table auto_increment_id(
id int auto_increment,
name varchar(100),
primary key (id)); 

insert into auto_increment_id(name) values('rishabh');
INSERT INTO auto_increment_id (name)
VALUES
('Amit Sharma'),
('Neha Gupta'),
('Rahul Verma'),
('Pooja Singh'),
('Vikram Thakur'),
('Meena Joshi'),
('Karan Mehta'),
('Sonal Patil'),
('Ramesh Iyer'),
('Swati Desai'),
('Arjun Malhotra'),
('Priya Nair'),
('Suresh Kumar'),
('Nikita Rao'),
('Ankit Saxena');

select * from auto_increment_id;

-- set limit for show table data 
select * from auto_increment_id limit 2;

-- sorting data by name with using order by (by deafault it work ascending order)
select * from auto_increment_id order by name ;

select * from auto_increment_id order by name desc;

# display employee data in desc order of salary and if salaries are same for more than one employees
# arrange their data in ascedinding order of name

select* from employee ;

-- multi level ordering 
select* from employee order by salary  asc, name desc;

# Write a query to find the employee who is getting maximum salary?
select* from employee order by salary  desc limit 1;


# Write a query to find the employee who is getting maximum salary?
select* from employee order by salary limit 1;

# Conditional Operators ->    < , > , <= , >= 
# Logical Operator -> AND, OR, NOT

# list all employees who are getting salary more than 50000
 select * from employee where salary > 50000;

# list all employees who are getting salary more than or equal to 52000
 select * from employee where salary >= 52000;
 
 # list all employees who are getting less than 50000
 select * from employee where salary < 50000;
 
 # list all employees who are getting less than equal to 52000 
 select * from employee where salary <= 52000;
 
 # filter the record where age of employees is equal to 29
 select * from employee where age = 29; 
 
# filter the record where age of employees is not equal to 20
# we can use != or we can use <>
 select * from employee where age != 29 order by age desc; 
 select * from employee where age <> 29 order by age; 

# find those employees who joined the company on 2022-05-15 and their salary is less than 50000
select * from employee where hiring_date = '2022-05-15' and salary < 50000;


# find those employees who joined the company after 2021-08-11 or  their salary is less than 50000
select * from employee where hiring_date > '2022-05-15' or salary < 50000;


# how to use Between operation in where clause
# get all employees data who joined the company between hiring_date 2022-05-15 to 2022-08-15
select * from employee where hiring_date between '2022-05-15' and '2022-08-16';


# get all employees data who are getting salary in the range of 28000 to 60000
select * from employee where salary between '28000' and '50000';


# how to use LIKE operation in where clause
# % -> Zero, one or more than one characters
# _ -> only one character

# get all those employees whose name starts with 'S'
select * from employee where name like 'S%';

# get all those employees whose name starts with 'Sw'
select * from employee where name like 'Sw%';

# get all those employees whose name ends with 'a'
select * from employee where name like '%a';

# get all those employees whose name starts with 'A' and ends with 'a'
select * from employee where name like 'a%a';

# Get all those employees whose name will have exact 10 characters
select * from employee where name like '___________';

# Return all those employees whose name contains atleast 13 characters
select * from employee where name like '%_____________%';

# How to use IS NULL or IS NOT NULL in the where clause

insert into employee values(16,'Kapil gupta', null, '2021-08-10', 30000, 'Assam');
insert into employee values(17,'Nikhil pandey', 30, '2021-08-10', null, 'Assam');

select * from employee;

# get all those employees whos age value is null
select * from employee where age is null;

# get all those employees whos salary value is not null
select * from employee where salary is not null;

# get all those employees whos salary and age value is not null
select * from employee where salary is not null and age is not null;

-- use of group by key 
create table orders_data
(
 cust_id int,
 order_id int,
 country varchar(50),
 state varchar(50)
);

INSERT INTO orders_data (cust_id, order_id, country, state)
VALUES
(101, 5001, 'India', 'Maharashtra'),
(102, 5002, 'India', 'Karnataka'),
(103, 5003, 'India', 'Tamil Nadu'),
(104, 5004, 'India', 'Gujarat'),
(201, 6001, 'Japan', 'Tokyo'),
(202, 6002, 'Japan', 'Osaka'),
(203, 6003, 'Japan', 'Hokkaido'),
(204, 6004, 'Japan', 'Kyoto'),
(301, 7001, 'Germany', 'Bavaria'),
(302, 7002, 'Germany', 'Berlin'),
(303, 7003, 'Germany', 'Hamburg'),
(304, 7004, 'Germany', 'Hesse'),
(401, 8001, 'USA', 'California'),
(402, 8002, 'USA', 'New York'),
(403, 8003, 'USA', 'Texas'),
(404, 8004, 'USA', 'Florida'),
(405, 8004, 'china', 'Beijing');

select * from orders_data;

-- this will give an error 
select country , cust_id , count(*) as order_count from orders_data group by country;

-- right way to write group by quiry 
select country , count(*) as order_group_by_each_country from orders_data group by country;

--  Write a query to find the total salary by each age group 
create table if not exists govt_employee(
id int,
name varchar(50),
age int,
hiring_date date,
salary int,
city varchar(50)
);
INSERT INTO govt_employee (id, name, age, hiring_date, salary, city)
VALUES
(1, 'Amit Sharma', 25, '2022-05-15', 45000, 'Mumbai'),
(2, 'Neha Gupta', 25, '2021-08-10', 52000, 'Delhi'),
(3, 'Rahul Verma', 25, '2020-11-20', 60000, 'Bangalore'),
(4, 'Pooja Singh', 25, '2023-01-25', 48000, 'Hyderabad'),
(5, 'Vikram Thakur', 35, '2019-07-05', 75000, 'Chennai'),
(6, 'Meena Joshi', 35, '2022-03-18', 41000, 'Pune'),
(7, 'Karan Mehta', 35, '2020-10-30', 58000, 'Ahmedabad'),
(8, 'Sonal Patil', 35, '2023-06-12', 46500, 'Kolkata'),
(9, 'Ramesh Iyer', 35, '2021-09-09', 69000, 'Surat'),
(10, 'Swati Desai', 30, '2022-12-01', 39000, 'Jaipur'),
(11, 'Arjun Malhotra', 30, '2020-02-14', 53000, 'Lucknow'),
(12, 'Priya Nair', 30, '2021-04-22', 47000, 'Coimbatore'),
(13, 'Suresh Kumar', 30, '2019-12-19', 72000, 'Indore'),
(14, 'Nikita Rao', 30, '2022-08-16', 42000, 'Nagpur'),
(15, 'Ankit Saxena', 30, '2023-03-08', 49000, 'Patna'),
(11, 'bhanu Sharma', 25, '2022-05-15', 45000, 'Mumbai');

select * from govt_employee;

select age ,sum(salary) as total_same_age_salary from govt_employee group by age ;

# calculate different aggregated metrices for salary
select age, 
	   sum(salary) as total_salary_by_each_age_group,
       max(salary) as max_salary_by_each_age_group,
       min(salary) as min_salary_by_each_age_group,
       avg(salary) as avg_salary_by_each_age_group,
       count(*) as total_employees_by_each_age_group
from govt_employee group by age;


# Use of having Clause 
# Write a query to find the country where only 1 order was placed
select * from orders_data;
select country from orders_data group by country having count(*)=1;

# how tot use group_concat
# Query - Write a query to print distinct states present in the dataset for each country?
select country , group_concat(state) as states_in_country from orders_data group by country;

# state not repeated
select country , group_concat(distinct state) as states_in_country from orders_data group by country; 

# set desc order 
select country , group_concat(distinct state order by state desc separator ' -> ') as states_in_country from orders_data group by country;












