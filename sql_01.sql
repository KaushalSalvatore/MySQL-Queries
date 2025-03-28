create database sql_practice_01;

show databases;

drop database sql_practice_01;

-- use particular table 
use sql_practice_01;

create table employee (
id int ,
name varchar(50));

-- show totale table that in present in employee database 
show tables ;
show create table employee;

-- drop table 
drop tables employee;

-- create table
create table if not exists employee (
id int ,
name varchar(100),
salary double,
hiring_date date
);

-- insert recode in table 
insert into employee values(1,'abhay',10000,'2025-12-12');

insert into employee(name, salary,id) values('piya',10000,2);

insert into employee values(3,'kaushal','40000','2025-1-12');

-- show table recode
select * from employee;

-- if i want to show date in '%d-%m-%Y' formate by default it use yyyy-mm-dd formate 
SELECT id, name, salary, DATE_FORMAT(hiring_date, '%d-%m-%Y') AS formatted_date FROM employee;
    
-- insert date in '%d-%m-%Y' formate
insert into employee values(1, 'John Doe', 50000, STR_TO_DATE('27-03-2025', '%d-%m-%Y'));

select * from employee;

-- insert multiple recode 
insert into employee values(3,'kaushal','40000','2025-1-12'),(5,'raju','40000','2025-1-12'),
(5,'mahesh','40000','2025-1-12');


insert into employee value(3,'kaushal','40000','2025-1-12'),(5,'raju','40000','2025-1-12'),
(5,'mahesh','40000','2025-1-12');

select * from employee;

create table if not exists employee_constraints (
id int not null,
name varchar(50) not null,
salary double,
hiring_date date default '2025-01-01',
unique (id),
check(salary>1000)
);

insert into employee_constraints values(1,'abhay','5000',null);

insert into employee_constraints values(2,'abhay','5000','2025-10-23');

select * from employee_constraints;

-- add alias name in table 
create table if not exists employee_constraints_alias (
id int not null,
name varchar(50) not null,
salary double,
hiring_date date default '2025-01-01',
constraint unique_key unique(id),
constraint high_salary check(salary>1000)
);

insert into employee_constraints_alias values(1,'abhay','500','2025-12-12');


select * from employee_constraints_alias;







