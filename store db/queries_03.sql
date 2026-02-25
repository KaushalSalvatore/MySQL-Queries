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

--2. Total revenue per store.

--3. Number of customers per city.

--4. Average price per category.

--5. Total sales per day.

--6. List products by price descending.

--7. Show top 10 expensive products.

--8. Show lowest 10 revenue entries.

--9. Sort customers alphabetically.

--10. Sort sales by quantity descending.