create database sql_practice_04;

use sql_practice_04;

# Example of join 

create table orders(
    order_id int,
    cust_id int,
    order_dat date, 
    shipper_id int
);

create table customers(
	cust_id int,
    cust_name varchar(50),
    country varchar(50)

);

create table shippers
(
    ship_id int,
    shipper_name varchar(50)
);

INSERT INTO customers (cust_id, cust_name, country) VALUES
(1, 'Alice Johnson', 'USA'),
(2, 'Bob Smith', 'Canada'),
(3, 'Charlie Brown', 'UK'),
(4, 'David Wilson', 'Germany'),
(5, 'Emma Watson', 'Australia');

INSERT INTO shippers (ship_id, shipper_name) VALUES
(1, 'DHL'),
(2, 'FedEx'),
(3, 'UPS'),
(4, 'Blue Dart'),
(5, 'USPS');


INSERT INTO orders (order_id, cust_id, order_dat, shipper_id) VALUES
(101, 1, '2024-03-20', 1),
(102, 2, '2024-03-21', 2),
(103, 3, '2024-03-22', 3),
(104, 4, '2024-03-23', 4),
(105, 5, '2024-03-24', 5),
(106, 1, '2024-03-25', 3),
(107, 3, '2024-03-26', 2),
(108, 2, '2024-03-27', 4),
(109, 4, '2024-03-28', 1),
(110, 5, '2024-03-29', 5);

select * from customers;

select * from shippers;

select * from orders;

# inner join 
# get the customer information for each order if value of customer is present in orders table 
select 
ord.*,cst.*
from orders ord
inner join customers cst on ord.cust_id = cst.cust_id;

# left join 
select 
ord.*,cst.*
from orders ord
left join customers cst on ord.cust_id = cst.cust_id;

# right join 
select 
ord.*,cst.*
from orders ord
inner join customers cst on ord.cust_id = cst.cust_id;

# How to join more than 2 datasets?
# perform inner JOIN
# get the customer informations for each order order, if value of customer is present in orders TABLE
# also get the information of shipper name
select 
o.*, c.*, s.*
from orders o
inner join customers c on o.cust_id = c.cust_id
inner join shippers s on o.shipper_id = s.ship_id;

CREATE TABLE manager (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(50),
    department VARCHAR(50)
);

-- Create employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES manager(manager_id)
);

INSERT INTO manager (manager_id, manager_name, department) VALUES
(1, 'Michael Scott', 'Sales'),
(2, 'Harvey Specter', 'Legal'),
(3, 'Rachel Green', 'Fashion'),
(4, 'Tony Stark', 'Engineering'),
(5, 'Bruce Wayne', 'Security');

INSERT INTO employee (emp_id, emp_name, department, manager_id) VALUES
(101, 'Jim Halpert', 'Sales', 1),
(102, 'Dwight Schrute', 'Sales', 1),
(103, 'Mike Ross', 'Legal', 2),
(104, 'Donna Paulsen', 'Legal', 2),
(105, 'Joey Tribbiani', 'Fashion', 3),
(106, 'Chandler Bing', 'Fashion', 3),
(107, 'Peter Parker', 'Engineering', 4),
(108, 'Pepper Potts', 'Engineering', 4),
(109, 'Dick Grayson', 'Security', 5),
(110, 'Alfred Pennyworth', 'Security', 5);

SELECT DISTINCT m1.manager_name 
FROM manager m1
JOIN employee e ON m1.manager_id = e.manager_id;


create table amazon_customer(
id int ,
name varchar(100)
);

create table amazon_orders(
order_id int,
amount int ,
cust_id int 
);

INSERT INTO amazon_customer (id, name) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'David Wilson'),
(5, 'Emma Watson');

INSERT INTO amazon_orders (order_id, amount, cust_id) VALUES
(101, 250, 1),
(102, 150, 2),
(103, 300, 3),
(104, 500, 4),
(105, 100, 5),
(106, 200, 1),
(107, 400, 3),
(108, 350, 2),
(109, 450, 4),
(110, 600, 5);


select * from amazon_customer;

select * from amazon_orders;

# Get the orders information along with customers full details
# if order amount were greater than 400

select 
cust.*,ord.*
from amazon_orders ord
inner join  amazon_customer cust on ord.cust_id = cust.id
where ord.amount > 400;

# we can use where or and both 

select 
cust.*,ord.*
from amazon_orders ord
inner join  amazon_customer cust on ord.cust_id = cust.id
and ord.amount > 400;



