--1.  Find duplicate records using CTE
--1.  Remove duplicate records using CTE
--1.  Find second highest salary using CTE
--1.  Find department-wise highest salary using CTE
--1.  Find employees earning more than dept avg using CTE
--1.  Rank employees by salary
--1.  Find top 3 salaries per department
--1.  Find running total of salaries
--1.  Recursive CTE for employee hierarchy
--1.  Find manager-wise employee count
--1.  Find employees hired in last 6 months
--1.  Find cumulative salary per department
--1.  Find employees earning more than previous employee
--1.  Remove duplicate rows using ROW_NUMBER
--1.  Find first hired employee per department
--1.  Find last hired employee per department
--1.  Find employees with consecutive salaries
--1.  Find gaps in employee IDs
--1.  Find nth highest salary
--1.  Find employees with same hire date
--1.  Find users logged in for 3 consecutive days

-- RANKING & ORDERING (Very High Frequency)

-- Find highest salary in each department.
-- Find 2nd highest salary in the company.
-- Find top 3 salaries per department.
-- Find employees with same salary and same rank.
-- Difference between RANK() and DENSE_RANK() with example.
-- Assign unique row numbers to records without using ID.
-- Fetch last 3 joined employees in each department.
-- Identify employees earning more than department average.
-- Find Nth highest salary (N is dynamic).
-- Divide employees into salary quartiles.
-- 25. Fetch employees earning more than department avg


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