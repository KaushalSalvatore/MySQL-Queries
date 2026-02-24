--1. Find total number of customers.
SELECT COUNT(*) AS customer_count FROM customers;

--2. Count total products in each category.
SELECT COUNT(*) AS product_count FROM products;

--3. Get average product price by category.
SELECT AVG(price) AS avg_price FROM products; 

--4. Find total sales quantity.
SELECT SUM(orders_count) AS total_sale FROM revenue_daily;

--5. Get total revenue from the revenue table.
SELECT SUM(revenue) AS total_revenue FROM revenue_daily;

--6. Find maximum product price.
SELECT MAX(price) AS max_price FROM products;

--7. Count number of stores in each city.
SELECT  city , COUNT(*) AS store_count
FROM stores
GROUP BY city;

--8. Find total number of sales per store.
SELECT store_name , SUM(r.revenue) AS store_revenue
FROM stores s
JOIN revenue_daily r
ON s.store_id = r.store_id
GROUP BY s.store_name
ORDER BY store_name ASC;

--9. Get product quantity sold per order.
SELECT order_id, SUM(quantity)
FROM order_items
GROUP BY order_id;

--10. List all sales with customer names.
SELECT GROUP_CONCAT(first_name,last_name) AS full_name ,
SUM(oi.quantity) AS total_qty , SUM(oi.unit_price) AS total_price
FROM customers c
JOIN orders o
ON c.customer_id= o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.first_name;