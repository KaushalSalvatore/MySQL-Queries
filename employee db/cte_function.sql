--1.  Find duplicate records using CTE
-- SELECT emp_name FROM employees
-- GROUP BY emp_name
-- having COUNT(*) > 1;
-- with cte
WITH duplicate_emp AS (
    SELECT emp_name FROM employees
    GROUP BY emp_name
    HAVING COUNT(*) > 1)
SELECT e.emp_name, e.dept_id
FROM employees e
JOIN duplicate_emp dp 
ON e.emp_name = dp.emp_name;

--2. Find employees with consecutive salaries

--3.  Find second highest salary using CTE
--4.  Find department-wise highest salary using CTE
--5.  Find employees earning more than dept avg using CTE
--6.  Rank employees by salary
--7.  Find top 3 salaries per department
--8.  Find running total of salaries
--9.  Recursive CTE for employee hierarchy
--10.  Find manager-wise employee count
--11.  Find employees hired in last 6 months
--12.  Find cumulative salary per department
--13.  Find employees earning more than previous employee
--14.  Remove duplicate rows using ROW_NUMBER
--15.  Find first hired employee per department
--16.  Find last hired employee per department
--1.  
--1.  Find gaps in employee IDs
--1.  Find nth highest salary
--1.  Find employees with same hire date
--1.  Find users logged in for 3 consecutive days

