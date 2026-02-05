SELECT * FROM departments LIMIT 5;

SELECT * FROM employee_projects LIMIT 5;

SELECT * FROM employees LIMIT 5;

SELECT * FROM projects LIMIT 5;

SELECT * FROM user_logins LIMIT 5;

-- BASIC SELECT & FILTERING

-- 1. Fetch all records from employee table
SELECT * FROM employees;

-- 2. Fetch employee name and salary only
SELECT emp_name , salary FROM employees;

-- 3. Fetch employees with salary > 50,000
SELECT emp_name , salary FROM employees
WHERE salary > 50000;

-- 4. Fetch employees whose department is HR
SELECT e.emp_name,e.salary,d.dept_name
FROM employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
WHERE d.dept_name = 'HR';

-- 5. Fetch employees NOT in HR department
SELECT e.emp_name,d.dept_name
FROM employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
WHERE d.dept_name != 'HR';

-- 7. Fetch employees whose salary BETWEEN 50,000 and 80,000
SELECT e.emp_name , e.salary, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary BETWEEN 50000 AND 80000;

-- 8. Fetch employees whose name starts with ‘E’
SELECT * FROM employees
WHERE emp_name = 'E%'
LIMIT 5;

-- 9. Fetch employees whose name ends with ‘n’
SELECT * FROM employees
WHERE emp_name = '%n'
LIMIT 5;


-- 10. Fetch employees whose name contains ‘son’
SELECT * FROM employees
WHERE emp_name = '%son%'
LIMIT 5;

-- 11. Fetch employees with NULL manager_id
SELECT * FROM employees
WHERE manager_id is NULL;

-- 12. Fetch employees with NOT NULL email
SELECT * FROM employees
WHERE email is NOT NULL;

-- 13. Fetch employees ordered by salary DESC
SELECT emp_name , salary from employees
ORDER BY salary DESC;

-- 14. Fetch top 5 highest paid employees
SELECT emp_name , salary from employees
ORDER BY salary DESC
LIMIT 5;

-- 15. Fetch employees hired after 2022
SELECT emp_name,hire_date FROM employees
WHERE hire_date > '2022-01-01';

-- 16. Fetch employees hired in current year
SELECT emp_name,hire_date FROM employees
WHERE hire_date > '2026-01-01';

-- 17. Fetch employees with salary IN (40k, 60k, 80k)
SELECT emp_name,salary FROM employees
WHERE salary IN ('40000','60000','80000');
-- WHERE salary = '40000' OR salary = '60000' OR salary = '80000';

-- 18. Fetch employees excluding salary 50k
SELECT emp_name,salary FROM employees
WHERE salary <> '50000';
-- WHERE salary != '50000';

-- 19. Fetch employees whose salary is multiple of 10,000
SELECT emp_name,salary FROM employees
WHERE salary % 10000 = 0;

-- 20. Fetch employees working in IT or HR
SELECT e.emp_name,e.salary,d.dept_name
FROM employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
WHERE d.dept_name IN ('IT','HR');

-- 21. Fetch employees not working in IT or HR
SELECT e.emp_name,e.salary,d.dept_name
FROM employees e
INNER JOIN departments d
on e.dept_id = d.dept_id
WHERE d.dept_name NOT IN ('IT','HR');

-- 22. Fetch first 10 rows
SELECT * FROM employees
LIMIT 10;

-- 23. Fetch last 5 rows
SELECT * FROM employees
ORDER BY emp_id DESC
LIMIT 5;

-- 24. Fetch employees with duplicate names
SELECT emp_name , COUNT(*)
FROM employees
GROUP BY emp_name
HAVING COUNT(*) > 1;

-- 25. Fetch employees whose email is Gmail
SELECT emp_name,email
FROM employees
WHERE email LIKE '%gmail%';