-- some sql questions 

create database sql_practice_02;

use sql_practice_02;

create table customer_order(
order_no int,
purch_amt double,
ord_date date,
customer_id int,
salesman_id int
);


insert into customer_order value(70001,150.5,'2012-10-05',3005,5002);
insert into customer_order value(70009,270.65,'2012-11-05',3001,5001);
insert into customer_order value(70002,65.26,'2012-03-05',3012,5003);
insert into customer_order value(70004,110.5,'2012-10-11',3003,5004);
insert into customer_order value(70007,948.5,'2012-10-15',3006,5005);
insert into customer_order value(70005,2400.6,'2012-10-21',3007,5006);
insert into customer_order value(70008,550.5,'2012-10-21',3008,5007);
insert into customer_order value(700010,750.5,'2012-10-05',3009,5008);
insert into customer_order value(700012,950.5,'2012-01-04',3021,5009);
insert into customer_order value(700011,4450.5,'2012-12-05',3022,5010);
insert into customer_order value(700013,40.5,'2012-09-05',3024,5011);
	
-- 1. Write a query to display the columns in a specific order, such as order date,
 -- salesman ID, order number, and purchase amount for all orders.
 
 select ord_date,salesman_id,order_no,purch_amt from customer_order;
 
 -- create salesman table 
 create table salesman(
 salesman_id int,
 salesman_name varchar(50),
 salesman_city varchar(50),
 salesman_commission double);
 
 
insert into salesman values(5001 ,'James Hoog', 'new York',0.15);
insert into salesman values(5002 ,'nail knite', 'paris',0.13);
insert into salesman values(5005 ,'pit alex', 'london',0.11);
insert into salesman values(5006 ,'mc lyon', 'paris',0.14);
insert into salesman values(5007 ,'paul adam', 'rome',0.13);
insert into salesman values(5003,'lauson hen', 'san jose',0.12);

select * from salesman;

-- from the following table, write a SQL query to locate salespeople who live in the city
-- of 'Paris'. Return salesperson's name, city. 

select salesman_name , salesman_city from salesman where salesman_city = 'paris';
 
 create table product(
  PRO_ID int,
  PRO_NAME varchar(100),
  PRO_PRICE double,
  PRO_COM double
 );
 
insert into product value(101, 'Motherboard',3200.00,16);
insert into product value(102, 'Keyboard',450.00,14);
insert into product value(103, 'ZIP drive',250.00,16);
insert into product value(104, 'Speaker',550.00,15);
insert into product value(105, 'Monitor',5000.00,11);
insert into product value(106, 'DVD drive',900.00,12);
insert into product value(107, 'CD drive',800.00,12);
insert into product value(108, 'Printer',2600.00,13);
insert into product value(109, 'Refill cartridge',350.00,13);
insert into product value(1010, 'Mouse',250.00,12);
 
select * from product;
 
 
-- From the following table, write a SQL query to select a range of products whose
-- price is in the range Rs.200 to Rs.600. Begin and end values are included. Return
--  pro_id, pro_name, pro_price, and pro_com.

select * from product where PRO_PRICE between 200 and 600; 

select * from product where PRO_PRICE >= 200 and PRO_PRICE <=600;  

-- From the following table, write a SQL query to find the items whose prices are
-- higher than or equal to $550. Order the result by product price in descending, then
-- product name in ascending.

select * from product where PRO_PRICE >= 550  order by PRO_PRICE desc , PRO_NAME asc;


CREATE TABLE orders (
    ord_no INT ,             
    purch_amt double,   
    ord_date DATE,  
    customer_id INT,                    
    salesman_id INT                 
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29,  '2012-08-17', 3003, 5007),
(70013, 3045.60, '2012-04-25', 3002, 5001);

select * from orders;

--  From the following table, write a SQL query to find details of all orders excluding
-- those with ord_date equal to '2012-09-10' and salesman_id higher than 5005 or
-- purch_amt greater than 1000.Return ord_no, purch_amt, ord_date, customer_id and
-- salesman_id.

select * from orders where  ord_date = '2012-09-10' and (salesman_id  > 5005 or purch_amt  > 1000);


