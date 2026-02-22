-- RANKING & ORDERING (Very High Frequency)
-- RANK() {1, 2, 2, 4}, DENSE_RANK() {1, 2, 2, 3} , ROW_NUMBER() {1, 2,3, 4}

--1.  Find highest salary in each department.

SELECT emp_name , salary , dept_id
FROM (
    SELECT *, ROW_NUMBER() OVER
     (PARTITION BY dept_id ORDER BY salary DESC) rn
    FROM employees
)
WHERE rn = 1;

--2. Find 2nd highest salary in the company.
SELECT emp_name , salary , dept_id
FROM (
    SELECT *, ROW_NUMBER() OVER
     (ORDER BY salary DESC) rn
    FROM employees
)
WHERE rn = 1;

--3. Find top 3 salaries per department.
SELECT emp_name , salary , dept_id 
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
    rn FROM employees
)
WHERE rn <= 3 ANd dept_id NOT NULL;

-- 4. Find employees with same salary and same rank.
SELECT emp_id , salary , dept_id , DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary)
AS salary_rank
FROM employees;

-- 5. Assign unique row numbers to records without using ID.
Select emp_name , ROW_NUMBER() OVER(ORDER BY joining_date) AS emp_rank
FROM employees;

-- 6. Assign unique row numbers to records without using ID and order by dept_id.
SELECT emp_name , dept_id , ROW_NUMBER()
OVER(PARTITION BY dept_id  ORDER BY salary DESC) AS rank_salary , salary
from employees; 

-- 7. Fetch last 3 joined employees in each department.
WITH ranked_emp AS (
    SELECT emp_name,
           dept_id,
           joining_date,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id 
               ORDER BY joining_date DESC
           ) AS rank_joining_date
    FROM employees
    WHERE dept_id IS NOT NULL
)
SELECT *
FROM ranked_emp
WHERE rank_joining_date <= 3;

-- 8. Identify employees earning more than department average.

-- SELECT d.dept_name , GROUP_CONCAT(e.emp_name) AS emp_list,
--  AVG(e.salary) AS dept_avg_salary , COUNT(*) AS emp_count
-- FROM employees e
-- JOIN departments d
-- ON e.dept_id = d.dept_id
-- WHERE e.dept_id IS NOT NULL AND 
--  e.salary > (SELECT AVG(e2.salary) FROM employees e2
--     WHERE e2.dept_id = e.dept_id)
-- GROUP BY e.dept_id;

SELECT 
    d.dept_name,
    GROUP_CONCAT(e.emp_name) AS emp_list,
    AVG(e.salary) OVER (PARTITION BY e.dept_id) AS dept_avg_salary,
    COUNT(*) AS emp_count
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
)
GROUP BY e.dept_id;

-- 10. Find Nth highest salary (N is dynamic).
SELECT *
FROM (
    SELECT emp_name,
           dept_id,
           salary,
           DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

-- RUNNING TOTALS & AGGREGATIONS

-- 1. Calculate running total of salary by join date.
-- 2. Calculate cumulative sales per month.
-- 3. Find department-wise total salary without GROUP BY.
-- 4. Calculate moving average of last 3 salaries.
-- 5. Count number of employees hired till date.
-- 6. Find difference between current and previous row salary.
-- 7. Find maximum salary till current row.
-- 8. Calculate rolling 7-day average.
-- 9. Show percentage contribution of each employee salary.
-- 10. Find running sum reset per department.

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
-- Calculate sliding window sum (3 previous rows).
-- Calculate moving average including current + next rows.
-- Why does LAST_VALUE() give unexpected output?
-- How to fix LAST_VALUE() using frame clause?