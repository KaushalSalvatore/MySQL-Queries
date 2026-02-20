-- RANKING & ORDERING (Very High Frequency)

-- Find highest salary in each department.

SELECT emp_name , salary , dept_id
FROM (
    SELECT *, ROW_NUMBER() OVER
     (PARTITION BY dept_id ORDER BY salary DESC) rn
    FROM employees
)
WHERE rn = 1;

-- Find 2nd highest salary in the company.
SELECT emp_name , salary , dept_id
FROM (
    SELECT *, ROW_NUMBER() OVER
     (ORDER BY salary DESC) rn
    FROM employees
)
WHERE rn = 1;

-- Find top 3 salaries per department.
SELECT emp_name , salary , dept_id 
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
    rn FROM employees
)
WHERE rn <= 3 ANd dept_id NOT NULL;

-- 4. Find employees with same salary and same rank.
-- RANK() , DENSE_RANK() , ROW_NUMBER()
SELECT emp_id , salary , dept_id , DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary)
AS salary_rank
FROM employees;

-- Assign unique row numbers to records without using ID.

-- Fetch last 3 joined employees in each department.
-- Identify employees earning more than department average.
-- Find Nth highest salary (N is dynamic).
-- Divide employees into salary quartiles.
-- Fetch employees earning more than department avg


-- RUNNING TOTALS & AGGREGATIONS

-- Calculate running total of salary by join date.
-- Calculate cumulative sales per month.
-- Find department-wise total salary without GROUP BY.
-- Calculate moving average of last 3 salaries.
-- Count number of employees hired till date.
-- Find difference between current and previous row salary.
-- Find maximum salary till current row.
-- Calculate rolling 7-day average.
-- Show percentage contribution of each employee salary.
-- Find running sum reset per department.

-- LAG / LEAD (VERY COMMON)

-- Compare current salary with previous employee salary.
-- Find salary hike compared to previous month.
-- Detect salary drop or decrease.
-- Find gap between consecutive transactions.
-- Identify customers who skipped months
-- Compare current record with next record.
-- Find time difference between events.
-- Detect repeated values in consecutive rows.
-- Find trend (increase/decrease) in sales.
-- Calculate day-over-day growth percentage.

-- ADVANCED ANALYTICS (High Signal Questions)

-- Fetch first and last salary in each department.
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

-- Difference between ROWS and RANGE.
-- Calculate sliding window sum (3 previous rows).
-- Calculate moving average including current + next rows.
-- Why does LAST_VALUE() give unexpected output?
-- How to fix LAST_VALUE() using frame clause?