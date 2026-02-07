-- 1. Count total employees
SELECT COUNT(*) FROM employees;

-- 2. Find average salary
SELECT AVG(salary) FROM employees;

-- 3. Find minimum salary
SELECT MIN(salary) FROM employees;

-- 4. Find maximum salary
SELECT MAX(salary) FROM employees;

-- 5. Find sum of all salaries
SELECT SUM(salary) FROM employees;

-- 6. Find department-wise employee count
SELECT d.dept_name, COUNT(*) AS employee_count
FROM departments d
LEFT JOIN employees e
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 7. Find department-wise total salary
SELECT d.dept_name , SUM(e.salary) AS Total_salary
FROM departments d
LEFT JOIN employees e 
on d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 8. Find department-wise average salary
SELECT d.dept_name , AVG(e.salary) AS AVG_salary
FROM departments d
LEFT JOIN employees e 
on d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 9. Find departments having more than 5 employees
SELECT d.dept_name, COUNT(*) AS employee_count
FROM departments d
LEFT JOIN employees e
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING employee_count > 5;

-- 10. Find departments where avg salary > 60k
SELECT d.dept_name , AVG(e.salary) AS AVG_salary
FROM departments d
LEFT JOIN employees e 
on d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING AVG_salary > 60000;

-- 11. Find year-wise hiring count
-- SELECT YEAR(hire_date) AS hire_year,
--        COUNT(*) AS hiring_count
-- FROM employees
-- GROUP BY YEAR(hire_date)
-- ORDER BY hire_year;

-- 12. Find duplicate salaries


-- 13. Find second highest salary
SELECT emp_name , salary 
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1 ; 

-- 14. Find third highest salary

-- 15. Find top 3 salaries

-- 16. Find department-wise highest salary

-- 17. Find department-wise lowest salary

-- 18. Find department with maximum employees

-- 19. Find department with minimum employees

-- 20. Find departments having only one employee

-- 1. Find salary range (max-min)

-- 1. Count employees without manager

-- 1. Find number of employees per location

-- 1. Find total salary per location

-- 1. Find locations where avg salary > company avg