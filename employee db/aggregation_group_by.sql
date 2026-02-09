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
SELECT salary,emp_name
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1;


-- 13. Find second highest salary
SELECT emp_name , salary 
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1 ; 

-- 14. Find third highest salary
SELECT emp_name, MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees)
LIMIT 1 OFFSET 1 ; 

-- 15. Find top 3 salaries
SELECT emp_name , salary 
FROM employees
ORDER BY salary DESC
limit 3;



-- 16. Find department-wise highest salary
SELECT d.dept_name , MAX(salary) AS max_salary
FROM departments d
LEFT JOIN employees e
on d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY max_salary DESC;

-- 17. Find department-wise lowest salary
SELECT d.dept_name , MIN(e.salary) AS min_salary
FROM departments d
LEFT JOIN employees e
on d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY min_salary;


-- 18. Find department with maximum employees
SELECT d.dept_name , COUNT(e.emp_name) AS emp_count
FROM departments d
LEFT JOIN employees e
on d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY emp_count DESC
LIMIT 1;

-- 19. Find department with minimum employees
SELECT d.dept_name , COUNT(e.emp_name) AS emp_count
FROM departments d
LEFT JOIN employees e
on d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY emp_count ASC
LIMIT 1 ;

-- 20. Find departments having only 3 employee
SELECT d.dept_name , COUNT(e.emp_name) AS emp_count
FROM departments d
LEFT JOIN employees e
on d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING emp_count = 3 ;

-- 21. Find salary range (max-min)
SELECT MAX(salary) - MIN(salary) AS salary_range
FROM employees;


-- 22. Count employees without manager
SELECT COUNT(*)
FROM employees
WHERE manager_id is NULL;

-- 23. Find number of employees per location
SELECT d.location , COUNT(*) AS emploee_count
FROM departments d
LEFT JOIN employees e 
ON d.dept_id = e.dept_id
GROUP BY d.location;

-- 24. Find total salary per location
SELECT d.location , SUM(e.salary) AS sum_salary
FROM departments d
LEFT JOIN employees e 
ON d.dept_id = e.dept_id
GROUP BY d.location;

-- 25. Find locations where avg salary > company avg
SELECT d.dept_name,d.location,AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);