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

-- 3. Get stores with revenue > 50000.


-- 4. Find categories with avg price > 2000.

-- 5. Get products sold more than 50 times.

-- 6. Find customers with more than 10 purchases.
 
-- 7. Find products priced above average price.

-- 8. Get customers who made at least one purchase.

-- 9. Find products never sold.

-- 10. Get stores with revenue higher than average.
