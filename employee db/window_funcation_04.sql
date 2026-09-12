--1. Find latest transaction per customer.
SELECT customer_name , tran_id , trans_date 
from customer 
QUALIFY ROW_NUMBER() OVER(PARTITION BY cus_id , ORDER BY trans_id DESC);

--2. Remove duplicate rows using window functions.


--3. Identify duplicate records based on multiple columns.


--4. Find employees who joined on same day.


--5. Detect islands and gaps problem.


--6. Find continuous login days.


-- 7. Find customers with consecutive purchases.


--8. Rank rows based on multiple columns.


--9. FRAME CLAUSE (INTERVIEWER FAVORITE)


--10 Calculate sliding window sum (3 previous rows).


-- Calculate moving average including current + next rows.
