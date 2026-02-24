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
SELECT emp_name , salary FROM 
employees WHERE salary = 
(SELECT salary FROM employees);

-- SELECT emp_name , salary 
-- FROM employees
-- GROUP BY salary
-- HAVING COUNT(*) > 1 ;

-- SELECT emp_name , salary
-- FROM employees
-- WHERE salary IN (
--     SELECT salary FROM employees
--     GROUP BY salary
--     HAVING COUNT(*) > 1
-- )
-- GROUP BY salary;

-- SELECT e.emp_name , e.salary
-- FROM employees e 
-- JOIN employees e1 
-- ON e.salary = e1.salary
-- AND e.emp_id <> e1.emp_id ;

-- 12.  Find employees earning more than their manager
SELECT e.salary , e.emp_name , m.manager_name , m.salary
FROM employees e
JOIN managers m 
ON e.manager_id = m.manager_id
WHERE e.salary > m.salary
GROUP BY m.manager_id;

-- 13.  Find employees working in same department as Heena
SELECT emp_name , dept_id 
from employees
WHERE dept_id = (SELECT dept_id FROM employees
WHERE emp_name LIKE 'Heena%');

-- 14.  Find employees not working on any project
SELECT e.emp_name 
FROM employees e
JOIN employees_project em
ON e.emp_id = em.emp_id
WHERE em.project_id is NULL
GROUP BY e.emp_id;

-- 15.  Find employees working on max number of projects
SELECT e.emp_name , COUNT(*) AS total_projects
FROM employees e
JOIN employees_project em
ON e.emp_id = em.emp_id
GROUP BY e.emp_id
HAVING total_projects = (
    SELECT MAX(project_count)
    FROM (
        SELECT COUNT(*) AS project_count
        FROM employees_project
        GROUP BY emp_id
    ));

-- SELECT e.emp_name , COUNT(*) AS total_projects
-- FROM employees e
-- JOIN employees_project em
-- ON e.emp_id = em.emp_id
-- GROUP BY e.emp_id
-- ORDER BY total_projects DESC;

-- 16. Find employees whose salary is in top 10%
-- SELECT emp_name , salary 
-- FROM employees
-- WHERE salary >= (
--     SELECT MIN(salary)
--     FROM (
--         SELECT DISTINCT salary
--         FROM employees
--         ORDER BY salary DESC
--         LIMIT 10 PERCENT 
--     ) t
-- );

-- 17. Find employee with max salary per department
SELECT emp_name,salary,dept_id
FROM employees e
WHERE salary = (SELECT MAX(salary) FROM employees
WHERE dept_id = e.dept_id);

-- 18.  Find departments avg salary and  company avg in desc mode
SELECT dept_id , AVG(salary) AS dept_avg , 
(SELECT AVG(salary) FROM employees) As company_avg_salary
FROM employees
GROUP BY dept_id
ORDER BY dept_avg DESC;
  
-- 19.  Find employees in departments located in ‘Delhi’
SELECT e.emp_name , d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.location = 'Delhi';

-- 20.  Find employees whose department has only one employee
SELECT e.emp_name , d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.dept_id IN (SELECT dept_id FROM employees
GROUP BY dept_id
HAVING COUNT(*) = 1);

-- 21.  Find employees earning more than IT department avg
SELECT e.emp_name , d.dept_name , e.salary
As avg_salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary > 
(SELECT AVG(e2.salary) 
FROM employees e2
JOIN departments d2
ON e2.dept_id = d2.dept_id
 WHERE d2.dept_name = 'IT') ;

-- 22.  Find employees working on same project as manager
SELECT GROUP_CONCAT(e.emp_name) AS emp_list , m.manager_name
FROM employees e
JOIN managers m
ON e.manager_id = m.manager_id
GROUP BY m.manager_name;
