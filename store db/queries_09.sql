-- 1. Get top 3 sales per store.
SELECT *
FROM (
    SELECT 
        s.store_name,
        rv.date,
        rv.revenue,
        ROW_NUMBER() OVER(
            PARTITION BY s.store_name
            ORDER BY rv.revenue DESC
        ) AS rn
    FROM stores s
    JOIN revenue_daily rv
        ON s.store_id = rv.store_id
) t
WHERE rn <= 3;

-- 2. Calculate percentage contribution of each sale.
SELECT 
    s.store_name,
    SUM(r.revenue) AS total_revenue,
    (SUM(r.revenue) * 100.0 / SUM(SUM(r.revenue)) OVER()) AS pct_contribution
FROM stores s
JOIN revenue_daily r
    ON s.store_id = r.store_id
GROUP BY s.store_name;

-- 3. Find difference between consecutive sales.


-- 4. Get lag/lead sales quantity.


-- 5. Use CTE to calculate daily revenue trends.


-- 6. Use CTE to find top category per city.


-- 7. Use multiple CTEs to calculate profit logic.


-- 8. Use recursive CTE for sequence.


-- 9. Use CTE to filter top 10% customers.


-- 10. Find customers contributing to 80% revenue.

