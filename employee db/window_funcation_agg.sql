
-- Aggregate Window FunctionsSUM() ,AVG(),COUNT(),MIN(),MAX()

-- 1. Calculate running total of salary by join date.
SELECT emp_name, salary ,SUM(salary) OVER(ORDER by joining_date) AS total_salary
FROM employees
ORDER BY joining_date;

-- 2. Calculate running total departement wise without GROUP BY.
SELECT
    emp_name,
    dept.dept_name,
    salary,
    SUM(salary) OVER (
        PARTITION BY emp.dept_id
        ORDER BY salary DESC
    ) AS running_total
FROM employees emp
JOIN departments dept
    ON emp.dept_id = dept.dept_id;


-- 3. Calculate the cumulative project budget by project creation order.
SELECT prj.project_name, SUM(emp.salary) OVER(PARTITION BY prj.project_id) as budget,
SUM(emp.salary) OVER(PARTITION BY prj.project_id) * 1.30 AS project_budget
FROM employees emp
JOIN employees_project eprj 
ON eprj.emp_id = emp.emp_id
JOIN projects prj
ON prj.project_id = eprj.project_id;

-- 4. Calculate the moving average of the last 3 employee salaries based on joining date.
SELECT emp_id, 
       emp_name,
       salary, 
       joining_date, 
       AVG(salary) OVER(ORDER BY joining_date
       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW 
 )  As last_3_month_salary 
FROM employees
ORDER BY joining_date;

-- 5. Count number of employees hired till date.
SELECT emp_id, 
       emp_name,
       salary, 
       joining_date, 
       COUNT(*) OVER(ORDER BY joining_date
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
 )  As employees_hired_till_dates 
FROM employees 
ORDER BY joining_date;

-- 6. Find difference between current and previous row salary.
SELECT
emp_name, salary, LAG(salary) over(
    ORDER by joining_date 
) AS previous_salary,
salary - LAG(salary) OVER(
    ORDER BY joining_date
) AS salary_difference
FROM employees
ORDER BY joining_date;

-- 7. Find maximum salary till current row.
SELECT emp_name, salary, joining_date
MAX(salary) OVER(ORDER BY joining_date ROWS BETWEEN UNBOUNDED
PRECEDING AND CURRENT ROW) AS maximum_salary
FROM employees
ORDER BY joining_date;

-- 8. Calculate rolling 7-day average.
select emp_id, AVG(salary) OVER(ORDER BY joining_date RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW) AS 7_day_avg
FROM employees 
ORDER BY joining_date;


-- 9. Show percentage contribution of each employee salary.


-- 10. Find running sum reset per department.
