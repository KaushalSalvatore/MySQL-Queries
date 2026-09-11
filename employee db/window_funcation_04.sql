-- Find latest transaction per customer.
SELECT customer_name , tran_id , trans_date 
from customer 
QUALIFY ROW_NUMBER() OVER(PARTITION BY cus_id , ORDER BY trans_id DESC) = 1;

-- Remove duplicate rows using window functions.


-- Identify duplicate records based on multiple columns.


-- Find employees who joined on same day.


-- Detect islands and gaps problem.


-- Find continuous login days.


-- Find customers with consecutive purchases.


-- Rank rows based on multiple columns.


-- FRAME CLAUSE (INTERVIEWER FAVORITE)


-- Calculate sliding window sum (3 previous rows).


-- Calculate moving average including current + next rows.


-- Why does LAST_VALUE() give unexpected output?


-- How to fix LAST_VALUE() using frame clause?