-- 1. Fetch employee name with department name
SELECT e.emp_name , d.dept_name
FROM employees e 
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- 2. Fetch employees without department
SELECT emp_name
FROM employees
WHERE dept_id is NULL;

-- 3. Fetch Project Name with employees
SELECT e.emp_name , p.project_name
FROM employees e
LEFT JOIN employees_project ep
ON e.emp_id = ep.emp_id
LEFT JOIN projects p 
on ep.project_id = p.project_id;

-- 4. Fetch employees working in IT department
SELECT e.emp_name , d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'IT';

-- 5. Fetch employees along with manager name
SELECT e.emp_name , m.manager_name
FROM employees e
LEFT JOIN managers m
ON e.manager_id = m.manager_id;

-- 6. Fetch employees earning more than manager
SELECT e.emp_id,e.emp_name , e.salary , m.manager_name
FROM employees e
LEFT JOIN managers m
ON e.manager_id = m.manager_id
WHERE e.salary > m.salary
GROUP BY m.manager_name;

-- 7. Fetch employees hired before manager
SELECT e.emp_name , e.joining_date , m.manager_name , m.joining_date
FROM employees e
LEFT JOIN managers m
ON e.manager_id = m.manager_id
WHERE e.joining_date < m.joining_date
GROUP BY m.manager_name;

-- 8. Fetch employee count per department
SELECT d.dept_name , COUNT(*) AS emp_count
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 9. Fetch department with highest salary employee
SELECT d.dept_name,e.emp_name , e.salary
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE (e.dept_id, e.salary) IN (
    SELECT dept_id, MAX(salary)
    FROM employees
    GROUP BY dept_id
);

-- 10. Fetch employees not assigned to any project
SELECT e.emp_name
FROM employees e
LEFT JOIN employees_project p
ON e.emp_id = p.emp_id
WHERE p.project_id is NULL;

-- 11. Fetch projects without employees
SELECT p.project_name
FROM projects p
LEFT JOIN employees_project ep
ON p.project_id = ep.project_id
WHERE ep.emp_id IS NULL;

-- 12. Fetch employees working on more than one project
SELECT e.emp_name , COUNT(ep.project_id) AS project_count
FROM employees e
LEFT JOIN employees_project ep
ON ep.emp_id = e.emp_id
GROUP BY emp_name

-- 13. Fetch employees working in same department
SELECT 
FROM
LEFT JOIN
ON

-- 14. Fetch employees working in same department as ‘John’
SELECT
FROM
LEFT JOIN
ON

-- 15. Fetch employees with department location
SELECT
FROM
LEFT JOIN
ON

-- 16. Fetch employee name and project name
SELECT
FROM
LEFT JOIN
ON

-- 17. Fetch employees working on project ‘ABC’
SELECT
FROM
LEFT JOIN
ON

-- 18. Fetch employees working in multiple projects
SELECT
FROM
LEFT JOIN
ON

-- 19. Fetch employees who never worked on project
SELECT
FROM
LEFT JOIN
ON

-- 20. Fetch projects with max employees
SELECT
FROM
LEFT JOIN
ON

-- 21. Fetch employees even if department does not exist
SELECT
FROM
LEFT JOIN
ON

-- 22. Fetch common records from two tables
SELECT
FROM
LEFT JOIN
ON

-- 23. Fetch unmatched records from two tables
SELECT
FROM
LEFT JOIN
ON

-- 24. Fetch employees whose department is NULL
SELECT
FROM
LEFT JOIN
ON

-- 25. Fetch employees working in same location
SELECT
FROM
LEFT JOIN
ON

-- 26. Fetch department-wise employee count using join
SELECT
FROM
LEFT JOIN
ON

-- 27. Fetch employees earning more than department avg
SELECT
FROM
LEFT JOIN
ON

-- 28. Fetch employees with same salary in same department
SELECT
FROM
LEFT JOIN
ON

-- 29. Fetch employees belonging to multiple departments
SELECT
FROM
LEFT JOIN
ON

-- 30. Fetch employee details with last project
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees whose department has more than 5 employees
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees with no manager
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees who are managers
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees who are not managers
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees and their manager’s department
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees working in manager’s department
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees reporting to same manager
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch department with no managers
SELECT
FROM
LEFT JOIN
ON

-- 1. Fetch employees whose manager salary is highest
SELECT
FROM
LEFT JOIN
ON
-- 1. update employee record according to emp_id
-- UPDATE employees
-- set dept_id = NULL
-- WHERE emp_id = 19;

