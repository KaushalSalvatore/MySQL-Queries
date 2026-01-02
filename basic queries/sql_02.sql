use sql_practice_01;

create table if not exists student(
id int,
name varchar(50),
address varchar(100),
city varchar(50) );

show tables;

insert into student values(1,'khush','vaibhav nagar','indore');

-- add new column fter creating table 
alter table student add DOB date;

select * from student;

-- remove cloumn after creating table
alter table student drop DOB;

select * from student;

-- modify name varchar value 
alter table student modify column name varchar(100);

-- modify column name varchar value 
alter table student rename column name to studennt_name;

-- add unique integity constraint on id column 
alter table student add constraint unique(id);

-- this will give error 
insert into student values(1,'raam','saket nagar','delhi');

-- drop constraints 
alter table student drop constraint id;

-- create primary key
create table person(
id int,
name varchar(50),
age int,
constraint pk primary key(id));

insert into person values(1, 'kauhsal',25);

-- error 
insert into person values(1, 'kauhsal',25);

-- error 
insert into person values(null, 'kauhsal','25');

alter table person add constraint age_unique UNIQUE(age); 

insert into person values(2, 'navi','34');

insert into person values(3, 'bake',45);

insert into person values(4,'Amit',null);

insert into person values(5,'jay',null);

select * from person;

-- create foreign key 
create table department(
dept_id int primary key,
dept_name varchar(50)
);

create table dept_employee(
emp_id int primary key,
emp_name varchar(100),
emp_mobile bigint,
dept_id int ,
constraint dept_fk foreign  key (dept_id) references department(dept_id)
);


--  Candidate Key
create table primary_student(
id int,
email varchar(50),
mobile_number varchar(50),
subject varchar(50),
constraint stundent_key primary key (id),
constraint unique_key_1 unique (email),
constraint unique_key_2 unique (mobile_number)
);

-- composit key 
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    price DOUBLE,
    PRIMARY KEY (order_id, product_id)
);


-- drop amnd truncate

select * from person;

-- clear all data in table but not delete table   
truncate table person;

select * from person ;

-- this will also delete table 
drop table person ;

create table if not exists person(
id int ,
name varchar(50),
age int
);

insert into person values
(1,'kaushal',10),
(2,'kanish',15),
(3,'kanchu',20),
(3,'kapil',20),
(3,'kinnu',20),
(4,'killa',23),
(5,'bhura',50),
(6,'raja',35),
(7,'ramesh',40);

select * from person;

-- how to count total records
select count(*) from person ;

-- alias name 
select count(*) as total_value from person;

-- show specific column 
select name,age from person;

-- aliases name to columns 
select name as student_name , age as student_age from person;

-- unique age value person 
select  distinct(age) from person;

select  distinct age , name from person;

-- count of total unique value 
select  count(distinct(age)) from person;

-- increament age by 5 year 
select id , name , age as oldAge , (age + 5 ) as newAge from person;

-- disable safe mode 
SELECT @@SQL_SAFE_UPDATES;
SET SQL_SAFE_UPDATES = 0;

-- update 
update person set age = 20;

select * from person ;

-- where 
select * from person where name = 'kaushal';

-- update the age where name kaushal
update person set age = 30 where name = 'kaushal';

select * from person;

-- delete perticular entry 
delete from person where name = 'raja';

select * from person ; 






















