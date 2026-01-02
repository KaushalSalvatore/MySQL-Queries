# Sub-queries in SQL 
create database sql_practice_03;

use sql_practice_03;

create table employee (
id int,
name varchar(50),
salary int
);

INSERT INTO employee (id, name, salary)
VALUES
(1, 'Amit Sharma', 45000),
(2, 'Neha Gupta', 52000),
(3, 'Rahul Verma', 60000),
(4, 'Pooja Singh', 48000),
(5, 'Vikram Thakur', 75000),
(6, 'Meena Joshi', 41000),
(7, 'Karan Mehta', 58000),
(8, 'Sonal Patil', 46500),
(9, 'Ramesh Iyer', 69000),
(10, 'Swati Desai', 39000);

select * from employee;

# Write a query to print all those employee records who are getting more salary than 'Sonal Patil'
# Sub-queries in SQL 
select * from employee where salary > (select salary from employee where name = 'Sonal Patil');

# Use of IN and NOT IN
create table orders
(
 cust_id int,
 order_id int,
 country varchar(50),
 state varchar(50)
);

INSERT INTO orders (cust_id, order_id, country, state)
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

select * from orders;

# Use of IN and NOT IN
select * from orders where state in ('kyoto','berlin');
#select * from orders where state = 'kyoto' or  state = 'berlin';

create table customer_order_data
(
    order_id int,
    cust_id int,
    supplier_id int,
    cust_country varchar(50)
);

create table supplier_data(
supplier_id int ,
supplier_country varchar(50)
);

INSERT INTO customer_order_data (order_id, cust_id, supplier_id, cust_country) VALUES
(101, 1001, 1, 'USA'),
(102, 1002, 2, 'Canada'),
(103, 1003, 3, 'Germany'),
(104, 1004, 4, 'India'),
(105, 1005, 5, 'Australia'),
(106, 1006, 1, 'USA'),
(107, 1007, 3, 'Germany'),
(108, 1008, 2, 'Canada');

INSERT INTO supplier_data (supplier_id, supplier_country) VALUES
(1, 'USA'),
(5, 'Australia');

select * from supplier_data;


# write a query to find all the customer order data where all customers are from same county as the supplier 

select * from customer_order_data where 
cust_country in (select distinct supplier_country from supplier_data);

# use case and when 
create table student_marks(
id int,
name varchar(50),
marks int
);

INSERT INTO student_marks (id, name, marks) VALUES
(1, 'Alice', 90),
(2, 'Bob', 85),
(3, 'Charlie', 80),
(4, 'David', 75),
(5, 'Emma', 70),
(6, 'Frank', 65),
(7, 'Grace', 60),
(8, 'Henry', 55),
(9, 'Ivy', 50),
(10, 'Jack', 88);

select * from student_marks;

# Write a query to caluclate the grades for a student by following below criteria
# marks >= 90 , grade A+
# marks < 90 and marks >=85, grade A
# marks < 85 and marks >=75, grade B+
# marks < 75 and marks >=60, grade B
# marks < 60 , grade C

select id, name, marks, case
			when marks >= 90 then 'A+'
            when marks >= 85 and marks <90 then 'A'
            when marks >= 75 and marks <85 then 'B+'
            when marks >= 60 and marks <75 then 'B'
            else 'C'
		end as grade
        from student_marks;

# Example for Case When with Group By - Amazon SQL Questions
create table transactions
(
    trx_date date,
    merchant_id varchar(10),
    amount int,
    payment_mode varchar(10)
);


INSERT INTO transactions (trx_date, merchant_id, amount,payment_mode) VALUES
('2022-04-02','m1',150,'CASH'),('2022-04-02','m1',500,'ONLINE'),('2022-04-03','m2',450,'ONLINE'),
('2022-04-03','m1',100,'CASH'),('2022-04-03','m3',600,'CASH'),('2022-04-05','m5',200,'ONLINE'),
('2022-04-05','m2',100,'ONLINE');

select * from transactions;

select merchant_id, 
		sum(case when payment_mode = 'CASH' then amount else 0 end )as amt_cash,
        sum(case when payment_mode = 'ONLINE' then amount else 0 end ) as amt_online
        from transactions
        group by merchant_id;