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
FROM
JOIN 
IN

-- 5. Use CTE to calculate total sales per customer.
SELECT
FROM
JOIN 
IN

-- 6. Use CTE to find top 5 products.
SELECT
FROM
JOIN 
IN

-- 7. Use CTE to filter high revenue stores.
SELECT
FROM
JOIN 
IN

-- 8. Use CTE to find avg sales per store.
SELECT
FROM
JOIN 
IN

-- 9. Use CTE to find customers with high spending.
SELECT
FROM
JOIN 
IN

-- 10. Find total revenue per city.
SELECT
FROM
JOIN 
IN
