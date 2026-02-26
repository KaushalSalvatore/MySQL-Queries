--1. show all duplicate product with name and quntity and id
SELECT 
    p.product_id,
    p.product_name,
    i.stock_qty
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE p.product_name IN (
    SELECT product_name
    FROM products
    GROUP BY product_name
    HAVING COUNT(*) > 1
)
ORDER BY p.product_name;

--2. Total revenue per city and store store.
SELECT s.city , GROUP_CONCAT(DISTINCT s.store_name) AS
store_names, SUM(r.revenue) AS store_revenue
FROM stores s
JOIN revenue_daily r
ON s.store_id = r.store_id
GROUP BY s.city;

--3. Number of customers per city.
SELECT city , COUNT(*) AS total_customer
FROM customers
GROUP BY city
ORDER BY total_customer DESC;

--4. Average price per category.
SELECT c.category_name , AVG(p.price) AS avg_price
FROM products p
JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_id;

--5. Total sales per Moonth.
SELECT
    strftime('%Y', date) AS years,
    strftime('%m', date) AS month_number,
    SUM(revenue) AS total_revenue
FROM revenue_daily
GROUP BY years, month_number
ORDER BY years, month_number;

--6. List products by price top 10 lowest.
SELECT product_name , price , brand
FROM products
ORDER BY price ASC
LIMIT 10;

--7. Show top 10 expensive products.
SELECT product_name , price , brand
FROM products
ORDER BY price DESC
LIMIT 10;

--8. Show lowest 10 revenue entries.
SELECT date , revenue
FROM revenue_daily
ORDER BY revenue ASC
LIMIT 10;

--9. Sort customers alphabetically.
SELECT *
FROM customers
ORDER BY first_name ASC;

--10. Sort sales by quantity descending.
SELECT order_id , SUM(quantity) AS total_quntity
FROM order_items
GROUP BY order_id;
