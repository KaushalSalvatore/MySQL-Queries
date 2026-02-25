--1. Total sales quantity per product.
SELECT p.product_name , p.product_id,
SUM(oi.quantity) AS total_qty
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_qty DESC;

--2. Show product name with in inventory.
SELECT p.product_id , p.product_name , i.stock_qty
FROM inventory i
JOIN products p
ON i.product_id = p.product_id ;

--3. Display store name for each completed order.
SELECT p.product_id , p.product_name , i.stock_qty
FROM inventory i
JOIN products p
ON i.product_id = p.product_id;

--4. Get customer name and city for each sale.


--5. List all products sold with their price.

--6. Find customers from Delhi.

--7. Get products with price > 100.

--8. Find sales with quantity > 5.

--9. Show revenue entries > 5000.

--10. Get products in Electronics category.

