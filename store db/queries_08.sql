-- 1. Rank sales within each store by quantity.
SELECT 
    s.store_name,
    SUM(i.stock_qty) AS total_quantity,
    RANK() OVER(
        ORDER BY SUM(i.stock_qty) DESC
    ) AS store_rank
FROM stores s
JOIN inventory i
    ON s.store_id = i.store_id
GROUP BY s.store_name;

-- 2. Find customer who bought top payment.
SELECT 
    c.first_name,
    p.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id
ORDER BY p.amount DESC
LIMIT 1;

-- 3. Get store with highest average sale value.
SELECT s.store_name , AVG(rd.revenue) AS store_revenue
FROM stores s 
JOIN revenue_daily rd
ON s.store_id = rd.store_id
GROUP BY s.store_name
ORDER BY store_revenue DESC;

-- 4. Find category generating highest revenue.
SELECT category_name, product_name, total_revenue
FROM (
    SELECT 
        c.category_name,
        p.product_name,
        SUM(pay.amount) AS total_revenue,
        RANK() OVER(
            PARTITION BY c.category_name
            ORDER BY SUM(pay.amount) DESC
        ) AS rnk
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    JOIN payments pay
        ON oi.order_id = pay.order_id
    GROUP BY c.category_name, p.product_name
) t
WHERE rnk = 1;

-- 5. Find customers who bought the most purches ammount.
SELECT first_name, total_purchase
FROM (
    SELECT 
        c.first_name,
        SUM(p.amount) AS total_purchase,
        RANK() OVER(ORDER BY SUM(p.amount) DESC) AS rnk
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY c.customer_id, c.first_name
) t
WHERE rnk = 1;

-- 6. Get stores selling products above average price.

-- 7. Find products sold in all stores.

-- 8. Get customers who never purchased anything.

-- 9. Find stores with no sales.

-- 10. Find repeat customers.