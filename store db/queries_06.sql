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
WITH customer_totals AS (
    SELECT 
        c.customer_id,
        c.first_name,
        SUM(oi.quantity) AS total_items
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name
)

SELECT *
FROM customer_totals
WHERE total_items > (
    SELECT AVG(total_items)
    FROM customer_totals
)
ORDER BY total_items DESC;

-- 5. Rank products by price.
SELECT product_name , price ,RANK() OVER(ORDER BY price DESC) 
AS produst_rank
FROM products;

-- 6. Assign row number to sales completed ordered with customer name by date.
SELECT c.first_name, o.order_date , o.customer_id , o.status , 
DENSE_RANK() OVER(ORDER BY c.first_name, o.order_date) AS order_rank
from orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.status = 'completed';

-- 7. Get cumulative sales quantity.
SELECT 
    customer_id,
    order_date,
    oi.quantity,
    SUM(oi.quantity) OVER(
       ORDER BY o.order_date, o.order_id
    ) AS cumulative_sales_qty
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id ;

-- 8. Get cumulative sales quantity by customer.
SELECT 
    o.customer_id,
    o.order_date,
    oi.quantity,
    SUM(oi.quantity) OVER(
        PARTITION BY o.customer_id
        ORDER BY o.order_date, o.order_id
    ) AS cumulative_sales_qty
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id;

-- 9. Rank customers by total spending.
SELECT 
    c.customer_id,
    c.first_name,
    GROUP_CONCAT(o.order_id) AS orders,
    SUM(p.amount) AS total_spending,
    DENSE_RANK() OVER(ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_id, c.first_name;

-- 10. Get rank running total revenue per store.
WITH store_sales AS (
SELECT 
    s.store_id,
    s.store_name,
    SUM(rd.revenue) AS total_revenue
FROM stores s
JOIN revenue_daily rd
ON s.store_id = rd.store_id
GROUP BY s.store_id, s.store_name
)
SELECT *,
DENSE_RANK() OVER(ORDER BY total_revenue DESC) AS store_rank
FROM store_sales;