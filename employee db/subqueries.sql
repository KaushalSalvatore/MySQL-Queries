-- 1. Find employees earning more than average salary
SELECT emp_name , salary
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Find employees earning highest salary
SELECT emp_name , MAX(salary)
FROM employees;

-- 3. Find employees earning second highest salary
SELECT emp_name , salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees)
ORDER BY salary DESC 
LIMIT 1;

-- 4. Find employees earning less than average salary
SELECT emp_name , salary
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);

-- 5. Find employees name , departemnt , salary , avg department salary and diffrence 
SELECT 
    e.emp_name,
    d.dept_name,
    e.salary AS emp_salary,
    avg_table.avg_salary AS dept_avg_salary,
    e.salary - avg_table.avg_salary AS salary_difference
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) avg_table
ON e.dept_id = avg_table.dept_id
WHERE e.salary > avg_table.avg_salary;

-- 6. Find employees not in HR department
SELECT emp_id, emp_name 
FROM employees
WHERE emp_id != 1;
-- not in (1)
-- <> 1

-- 7. count of employees departemnt wise who join after 01-01-2021
SELECT  d.dept_name , COUNT(*) AS employee_count
FROM (SELECT dept_id FROM employees
WHERE joining_date > '2021-01-01')e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_id;

-- 8. Find employees count earning more than department avg
SELECT  d.dept_name , COUNT(*) AS employee_count , 
GROUP_CONCAT(e.emp_name) AS employee_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary > (SELECT AVG(e2.salary) FROM employees e2
    WHERE e2.dept_id = e.dept_id)
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- 09. Find department desc according to max employees
SELECT d.dept_name , COUNT(*) AS employee_count
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_id
ORDER BY employee_count DESC;

-- 10.  Find employees with same salary


-- 12.  Find employees earning more than their manager

-- 13.  Find employees working in same department as ‘Alice’

-- 14.  Find employees not working on any project

-- 15.  Find employees working on max number of projects

-- 16.  Find employees whose salary is in top 10%

-- 17.  Find employee with max salary per department

-- 18.  Find departments where avg salary > company avg

-- 19.  Find employees hired in earliest year

-- 20.  Find employees hired most recently

-- 1.  Find projects with max budget

-- 1.  Find employees in departments located in ‘Delhi’

-- 1.  Find employees whose department has only one employee

-- 1.  Find employees earning more than IT department avg

-- 1.  Find departments with total salary > 1 million

-- 1.  Find employees whose manager earns less than avg

-- 1.  Find departments having duplicate salaries

-- 1.  Find employees working on same project as manager

-- 1.  Find employees with salary greater than all HR salaries

-- 1.  Find employees with salary greater than any HR salary

-- 1.  Find employees whose department has max salary

-- 1.  Find departments with min employee count

-- 1.  Find employees whose salary equals department max

-- 1.  Find employees without department using subquery

-- 1.  Find projects without employees using subquery
