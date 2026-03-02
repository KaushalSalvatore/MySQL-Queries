-- 1.  Total sales per Quarter-wise sales
SELECT
    strftime('%Y', date) AS years,
    ((CAST(strftime('%m', date) AS INTEGER) - 1) / 3) + 1 AS monthly_quarter,
    SUM(revenue) AS total_revenue
FROM revenue_daily
GROUP BY years, monthly_quarter
ORDER BY years, monthly_quarter;

-- 2.  Get total sales quantity per customer.
SELECT cust.first_name , SUM(oi.quantity) AS total_qty
FROM customers cust
JOIN  orders o
ON cust.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cust.first_name
ORDER BY total_qty DESC;

-- 3.  Find total revenue generated per store using sales.
SELECT s.store_name , SUM(r.revenue) AS total_rev
FROM stores s
JOIN revenue_daily r
ON s.store_id = r.store_id
GROUP BY s.store_id;

-- 4. Get total spending per customer.
SELECT cust.first_name || ' ' || cust.last_name AS customer_name, 
SUM(oi.unit_price * oi.quantity) AS total_spending 
FROM customers cust
JOIN orders o
ON cust.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY cust.customer_id, cust.first_name
ORDER BY cust.first_name;

-- 5. Find stores with highest number of sales.
SELECT s.store_name , SUM(rd.revenue) AS total_revenue
FROM stores s
JOIN revenue_daily rd
ON s.store_id = s.store_id
GROUP BY s.store_id , s.store_name
ORDER BY total_revenue DESC;

-- 6. Find most sold product.
SELECT p.product_name , 
COUNT(oi.product_id) * quantity AS total_sold_products 
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id;

-- 7.  Get least sold product.
SELECT p.product_name , o.order_date , o.status
FROM  products p
JOIN  order_items  oi
ON p.product_id = oi.product_id
JOIN  orders  o
ON oi.order_id = o.order_id
GROUP BY p.product_id
ORDER BY o.order_date DESC
LIMIT 5;

-- 8. Find total sales per city.
SELECT s.city , SUM(rd.revenue) AS store_total_revenue
FROM  stores s
JOIN  revenue_daily rd
ON s.store_id =  rd.store_id
GROUP BY s.city
ORDER BY store_total_revenue DESC;



-- 9. Get total revenue per product category.
 
-- 10 Show top 5 customers by spending.

