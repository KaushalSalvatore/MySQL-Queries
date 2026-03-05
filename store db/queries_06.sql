-- 1. Get products whose price is above category average.
WITH category_avg AS
(SELECT
category_id ,AVG(price) AS cat_avg_price
    FROM products
    GROUP BY category_id )
SELECT 
    p.product_name,
    c.category_name,
    ca.cat_avg_price,
    p.price AS product_price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
JOIN category_avg ca
    ON p.category_id = ca.category_id
WHERE p.price > ca.cat_avg_price
ORDER BY c.category_name, p.price DESC;

-- 2. Find stores whose revenue is above their city average.
WITH store_revenue_avg AS (
    SELECT store_id , AVG(revenue) AS store_city_avg
    FROM revenue_daily
    GROUP BY store_id
)
SELECT s.store_name,s.city,rd.revenue,srv.store_city_avg
FROM stores s 
JOIN revenue_daily rd 
ON s.store_id = rd.store_id
JOIN store_revenue_avg srv
ON rd.store_id = srv.store_id
WHERE rd.revenue > srv.store_city_avg
ORDER BY s.store_name , rd.revenue;

-- 3. Get sales where quantity is above average quantity.
SELECT product_id ,quantity ,  AVG(quantity) avg_qty
FROM order_items
GROUP BY order_item_id
HAVING product_id > avg_qty;

-- 4. Find customers who bought more than average number of items.


-- 5. Rank products by price.

-- 6. Assign row number to sales ordered by date.

-- 7. Get cumulative sales quantity.

-- 8. Rank customers by total spending.

-- 9. Get running total revenue per store.

-- 10. Find top product per category using RANK.
