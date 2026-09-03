--1. Compare current salary with previous employee salary.
WITH compare_salary AS (
    SELECT
        emp_id,
        emp_name,
        salary,
        salary - LAG(salary) OVER (
            ORDER BY salary
        ) AS diff_salary
    FROM employee
)
SELECT
    emp_id,
    emp_name,
    salary,
    diff_salary
FROM compare_salary
ORDER BY salary;

--2. Detect salary increase or decrease.

--4. Find gap between consecutive transactions.

--5. Identify customers who skipped months

--6. Compare current record with next record.

--7. Find time difference between events.

--8. Detect repeated values in consecutive rows.


--9. Find trend (increase/decrease) in sales.

--10. Calculate day-over-day growth percentage.




--10. Fetch first and last salary in each department.

-- Find earliest joined employee per department.
-- Find latest transaction per customer.
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