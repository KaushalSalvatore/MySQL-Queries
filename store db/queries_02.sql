--1. Total sales quantity per product.
SELECT p.product_name , p.product_id,
SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty DESC;

--2. Show product name with in inventory.
SELECT p.product_id , p.product_name , i.stock_qty
FROM inventory i
JOIN products p
ON i.product_id = p.product_id ;

--3. Display store name for each completed order.
SELECT s.store_id , s.store_name , COUNT(*) AS completed_order
FROM orders o
JOIN stores s
ON o.store_id = s.store_id
WHERE o.status = 'completed'
GROUP BY s.store_id
ORDER BY completed_order DESC;

--4. Get customer name and city for with completed order and store name.
SELECT c.first_name , c.city , s.store_name , s.city
FROM customers c
JOIN orders o
On c.customer_id = o.customer_id
JOIN stores s
On s.store_id = o.store_id
WHERE o.status = 'completed' AND  c.city = s.city;

--5. List all products sold with their price.
SELECT DISTINCT(product_name) , cost
FROM products
ORDER BY cost DESC
LIMIT 10;

--6. Find customers from Delhi.
SELECT first_name
FROM customers
WHERE city = 'Delhi';

--7. Get products with price > 10000.
SELECT product_name , cost
FROM products
WHERE cost > 10000
ORDER BY cost DESC;

--8. Find product sales with quantity > 30.
SELECT p.product_name , p.product_id,
SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 30
ORDER BY total_qty DESC;

--9. Show weekly revenue entries > 50000.
SELECT 
    strftime('%Y', o.order_date) AS year,
    strftime('%W', o.order_date) AS week_number,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY year, week_number
ORDER BY year, week_number;

SELECT 
    YEAR(o.order_date) AS year,
    WEEK(o.order_date) AS week_number,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), WEEK(o.order_date)
ORDER BY year, week_number;

--10. Get products in Electronics category.
SELECT DISTINCT(product_name)
FROM products
WHERE category_id = 1;