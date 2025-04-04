create database sql_practice_06;

use sql_practice_06;

create table employees(
emp_id int,
emp_name varchar(50),
mobile bigint,
dept_name varchar(50),
salary int);

INSERT INTO employees (emp_id, emp_name, mobile, dept_name, salary) VALUES
(1, 'Alice Johnson', 9876543210, 'HR', 60000),
(2, 'Bob Smith', 9123456789, 'IT', 75000),
(3, 'Charlie Brown', 9988776655, 'Sales', 50000),
(4, 'David White', 9876512345, 'IT', 82000),
(5, 'Eve Adams', 9765432109, 'Sales', 45000),
(6, 'Frank Martin', 9234567890, 'Finance', 90000),
(7, 'Grace Kelly', 9898765432, 'HR', 62000),
(8, 'Hank Rogers', 9012345678, 'Marketing', 54000),
(9, 'Ivy Scott', 9123987654, 'IT', 72000),
(10, 'Jake Wilson', 9456789012, 'Finance', 67000);

select * from employees ;

# Create logic for department wise salary sum
create view dept_wise_salary as select dept_name, sum(salary) from employees group by dept_name;

select * from dept_wise_salary;

drop view dept_wise_salary;

# union and union all 
create table student
(
stu_id int,
name varchar(50), 
email varchar(50), 
city varchar(50)
);

INSERT INTO student (stu_id, name, email, city) VALUES
(1, 'Amit Sharma', 'amit.sharma@example.com', 'Delhi'),
(2, 'Priya Verma', 'priya.verma@example.com', 'Mumbai'),
(3, 'Rahul Singh', 'rahul.singh@example.com', 'Bangalore'),
(4, 'Neha Kapoor', 'neha.kapoor@example.com', 'Chennai'),
(5, 'Vikas Mehra', 'vikas.mehra@example.com', 'Kolkata'),
(6, 'Anjali Das', 'anjali.das@example.com', 'Hyderabad'),
(7, 'Suresh Nair', 'suresh.nair@example.com', 'Pune'),
(8, 'Divya Menon', 'divya.menon@example.com', 'Jaipur'),
(9, 'Rohit Khanna', 'rohit.khanna@example.com', 'Lucknow'),
(10, 'Kavita Iyer', 'kavita.iyer@example.com', 'Ahmedabad');

select * from student;
 
CREATE TABLE student_new (
    stu_id INT,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO student_new (stu_id, name, email, city) VALUES
(3, 'Rahul Singh', 'rahul.singh@example.com', 'Bangalore'),  
(4, 'Neha Kapoor', 'neha.kapoor@example.com', 'Chennai'),    
(6, 'Anjali Das', 'anjali.das@example.com', 'Hyderabad'),    
(11, 'Sameer Khan', 'sameer.khan@example.com', 'Pune'),     
(12, 'Megha Joshi', 'megha.joshi@example.com', 'Delhi'),     
(13, 'Arjun Patel', 'arjun.patel@example.com', 'Mumbai'),    
(14, 'Pooja Rao', 'pooja.rao@example.com', 'Kolkata'),      
(15, 'Ravi Sharma', 'ravi.sharma@example.com', 'Lucknow');  

# We are organizing an tournament between Class-1 and Class2, 
# we need details of all students from both college
select * from student
UNION
select * from student_new;

 
# how to use union all
select * from student
UNION ALL
select * from student_new;

--- Case 1 - Not Failed
select stu_id, name from student
UNION
select stu_id, name from student_new;


# common expression table 
create table amazon_employees(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int
 );

 insert into amazon_employees values(1,'Shashank', 100, 10000);
 insert into amazon_employees values(2,'Rahul', 100, 20000);
 insert into amazon_employees values(3,'Amit', 101, 15000);
 insert into amazon_employees values(4,'Mohit', 101, 17000);
 insert into amazon_employees values(5,'Nikhil', 102, 30000);

 create table department
 (
    dept_id int,
    dept_name varchar(20) 
  );

insert into department values(100, 'Software');
insert into department values(101, 'HR');
insert into department values(102, 'IT');
insert into department values(103, 'Finance');

select * from department;

select * from amazon_employees;

# Write a query to print the name of department along with the total salary 
# paid in each department

# normal approach
select d.dept_id , temp.total_salary
from (select dept_id , sum(salary) as total_salary from amazon_employees group by dept_id) temp
inner join department d on temp.dept_id = d.dept_id;

# how to do it using with clause??
with dept_wise_salary as (select dept_id ,sum(salalry) as total_salary from amazon_employees
group by dept_id)
select d.dept_name, tmp.total_salary
from dept_wise_salary tmp
inner join department d on tmp.dept_id = d.dept_id;
select * from dept_wise_salary;

# Write a Query to generate numbers from 1 to 10 in SQL

with recursive generate_numbers as   
( 
  select 1 as n
  union 
  select n+1 from generate_numbers where n<10
) select * from generate_numbers;

create table emp_manager(
id int primary key,
name varchar(50),
manager_id int,
designation varchar(50)
);

insert into emp_manager values(1,'Shripath',null,'CEO');
insert into emp_manager values(2,'Satya',5,'SDE');
insert into emp_manager values(3,'Jia',5,'DA');
insert into emp_manager values(4,'David',5,'DS');
insert into emp_manager values(5,'Michael',7,'Manager');
insert into emp_manager values(6,'Arvind',7,'Architect');
insert into emp_manager values(7,'Asha',1,'CTO');
insert into emp_manager values(8,'Maryam',1,'Manager');

select * from emp_manager;

# for our CTO 'Asha', present her org chart

with recursive emp_hir as  
(
   select id, name, manager_id, designation from emp_manager where name='Asha'
   UNION
   select em.id, em.name, em.manager_id, em.designation from emp_hir eh 
   inner join emp_manager em on eh.id = em.manager_id
)select * from emp_hir;


# Print level of employees as well
with recursive emp_hir as  
(
   select id, name, manager_id, designation, 1 as lvl from emp_manager where name='Asha'
   UNION
   select em.id, em.name, em.manager_id, em.designation, eh.lvl + 1 as lvl from emp_hir eh 
   inner join emp_manager em on eh.id = em.manager_id
)
select * from emp_hir;