-- 1. Find customers whose spending is above their city average.
WITH customer_spending AS (
    SELECT 
        cust.customer_id,
        cust.city,
        SUM(p.amount) AS total_spend
    FROM customers cust
    JOIN orders o
        ON cust.customer_id = o.customer_id
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY cust.customer_id, cust.city
),
city_average AS (
    SELECT 
        city,
        AVG(total_spend) AS city_avg_spend
    FROM customer_spending
    GROUP BY city
)
SELECT 
    cs.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    cs.city,
    cs.total_spend
FROM customer_spending cs
JOIN city_average ca
    ON cs.city = ca.city
JOIN customers c
    ON cs.customer_id = c.customer_id
WHERE cs.total_spend > ca.city_avg_spend;

-- 2. Find customers with total purchases > 10000.
SELECT 
    cust.first_name || ' ' || cust.last_name AS customer_name,
    SUM(p.amount) AS total_spent
FROM customers cust
JOIN orders o
ON cust.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY cust.customer_id
HAVING SUM(p.amount) > 10000;

-- 3. Get stores with revenue > 100000.
SELECT s.store_name , rv.revenue
FROM stores s
JOIN revenue_daily rv
ON s.store_id = rv.store_id
WHERE rv.revenue > 140000
GROUP BY s.store_name;

-- 4. Find categories with avg price > 32000.
SELECT c.category_name , AVG(p.price) AS avg_price
FROM products p 
JOIN categories c
ON p.category_id = c.category_id 
GROUP BY c.category_id
HAVING avg_price > 32000;

-- 5. Get products sold more than 30 qty.
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity) > 30
ORDER BY total_qty DESC;

-- 6. Find customers with more than 5 times.
SELECT 
    cust.first_name,
    COUNT(o.order_id) AS customer_order_count
FROM customers cust
JOIN orders o
ON cust.customer_id = o.customer_id
GROUP BY cust.customer_id, cust.first_name
HAVING COUNT(o.order_id) > 5
ORDER BY customer_order_count DESC;

-- 7. Find products priced above average price.
SELECT product_name , price
FROM products 
WHERE price > (
    SELECT AVG(price) FROM products);

-- 8. Get customers who made only one purchase.
SELECT 
    cust.first_name,
    COUNT(o.order_id) AS customer_order_count
FROM customers cust
JOIN orders o
ON cust.customer_id = o.customer_id
GROUP BY cust.customer_id, cust.first_name
HAVING COUNT(o.order_id) = 1
ORDER BY customer_order_count DESC;

-- 9. Find products never sold.
SELECT p.product_name , p.product_id
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 10. Get stores with revenue higher than 20% average.
SELECT s.store_name , SUM(rv.revenue) AS total_speding
FROM stores  s
JOIN revenue_daily rv
ON s.store_id = rv.store_id
GROUP BY s.store_id,s.store_name
HAVING total_speding > (
    SELECT AVG(revenue) * 1.2
    FROM revenue_daily
);

