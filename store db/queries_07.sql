-- 1. Get second highest priced product.
SELECT product_name , price , cost
FROM (SELECT * , RANK() 
OVER(ORDER BY price DESC) rn FROM products) t
WHERE rn = 2;

-- 2. Find top 3 customers count  per city.
SELECT city , customers_count
FROM (SELECT city , COUNT(*) AS customers_count,ROW_NUMBER() 
OVER(PARTITION BY city ORDER BY COUNT(*) DESC) rn FROM customers
GROUP BY city)
t  
WHERE rn <=3;

-- 3. Find top product per category using RANK.
WITH product_price AS (
    SELECT 
        p.product_name,
        p.price,
        c.category_name,
        RANK() OVER(
            PARTITION BY c.category_name
            ORDER BY p.price DESC
        ) AS product_rank
    FROM products p
    JOIN categories c
    ON p.category_id = c.category_id
)
SELECT *
FROM product_price
WHERE product_rank = 1;

-- 4. Calculate moving average of revenue.
SELECT 
    date,
    revenue,
    AVG(revenue) OVER(
        ORDER BY date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_revenue
FROM revenue_daily;

-- 5. Use CTE to calculate total sales per customer.
WITH sale_per_customer AS (
   SELECT  
       c.first_name,
       SUM(p.amount) AS total_amount
   FROM customers c
   JOIN orders o 
       ON c.customer_id = o.customer_id
   JOIN payments p 
       ON o.order_id = p.order_id
   GROUP BY c.customer_id, c.first_name
)

SELECT first_name, total_amount
FROM sale_per_customer
ORDER BY total_amount DESC;


-- 6. Use CTE to find top 5 products according to sale.
WITH top_product AS (
    SELECT 
        p.product_name,
        COUNT(oi.product_id) AS product_sale
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name
)

SELECT *
FROM top_product
ORDER BY product_sale DESC
LIMIT 5;

-- WITH top_product AS (
--     SELECT 
--         p.product_name,
--         COUNT(oi.product_id) AS product_sale,
--         ROW_NUMBER() OVER(ORDER BY COUNT(oi.product_id) DESC) AS rn
--     FROM products p
--     JOIN order_items oi
--         ON p.product_id = oi.product_id
--     GROUP BY p.product_name
-- )

-- SELECT product_name, product_sale
-- FROM top_product
-- WHERE rn <= 5;


-- 7. Use CTE to filter high revenue stores.
WITH revenue_store AS(
SELECT s.store_name , SUM(rd.revenue) AS total_revenue
FROM stores s 
JOIN revenue_daily rd
ON s.store_id = rd.store_id
GROUP BY s.store_id , s.store_name
)
SELECT *
FROM revenue_store
ORDER BY total_revenue DESC
LIMIT 5;

-- 8. Use CTE to find avg sales per store.
WITH revenue_store AS(
SELECT s.store_name , AVG(rd.revenue) AS total_revenue
FROM stores s 
JOIN revenue_daily rd
ON s.store_id = rd.store_id
GROUP BY s.store_id , s.store_name
)
SELECT *
FROM revenue_store
ORDER BY total_revenue DESC
LIMIT 5;


-- 9. Use CTE to find customers with high spending more then 200000.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.first_name,
        SUM(p.amount) AS total_spending
    FROM customers c
    JOIN orders o 
        ON c.customer_id = o.customer_id
    JOIN payments p 
        ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.first_name
)

SELECT *
FROM customer_spending
WHERE total_spending > 200000
ORDER BY total_spending DESC;

-- 10. Find total revenue per city.
WITH revenue_city AS(
    SELECT s.city , SUM(rd.revenue) AS revenue_city
    FROM stores s 
    JOIN revenue_daily rd
    ON s.store_id = rd.store_id
    GROUP BY s.city
)
SELECT *
FROM revenue_city;

