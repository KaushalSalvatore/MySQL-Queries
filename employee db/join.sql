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
HAVING COUNT(ep.project_id) > 1;

-- 13. Fetch employees working in same department
SELECT d.dept_name , GROUP_CONCAT(e.emp_name, ', ') AS emp_names
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;


-- 14. Fetch all employees working in same department as Meera
SELECT d.dept_name , GROUP_CONCAT(e.emp_name, ', ') AS emp_names
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.dept_id = (
    SELECT dept_id FROM employees
    WHERE emp_name = 'Meera');

-- 15. Fetch employees with department location
SELECT e.emp_name , d.dept_name , d.location
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

--16. Fetch employee has no project write No Project
SELECT COALESCE(p.project_name, 'No Project') AS project_name,
       GROUP_CONCAT(e.emp_name, ', ') AS emp_names
FROM employees e
LEFT JOIN employees_project ep
    ON e.emp_id = ep.emp_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id 
WHERE ep.project_id is NULL
GROUP BY COALESCE(p.project_name, 'No Project');

-- 17. Fetch employees working on Cloud Setup project
SELECT e.emp_name , p.project_name
FROM employees e
LEFT JOIN employees_project ep
ON e.emp_id = ep.emp_id
LEFT JOIN projects p
ON ep.project_id = p.project_id
WHERE p.project_name LIKE 'Cloud Setup';

-- 18. Fetch employees working in multiple projects
SELECT p.project_name , GROUP_CONCAT(e.emp_name, ', ') AS emp_names
FROM employees e
JOIN employees_project ep
ON e.emp_id = ep.emp_id
JOIN projects p
ON ep.project_id = p.project_id
GROUP BY p.project_name
HAVING COUNT(e.emp_name)>1;

-- 19. Fetch employees who never worked on project
SELECT e.emp_name
FROM employees e
LEFT JOIN employees_project ep
ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;

-- 20. Fetch projects with max employees
SELECT p.project_name, COUNT(ep.project_id) AS employee_count
FROM employees_project ep
LEFT JOIN projects p
ON ep.project_id = p.project_id
GROUP BY p.project_name 
ORDER BY employee_count DESC
LIMIT 1;

-- 21. Fetch employees even if department does not exist
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id is NULL;

-- 22. Fetch employees whose department is NULL
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id is NULL;

-- 23. Fetch employees working in same location
SELECT d.location , GROUP_CONCAT(e.emp_name,",") AS employee
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id NOT NULL
GROUP BY d.location;

-- 24. Fetch department-wise employee count using join
SELECT d.dept_name , COUNT(*) AS employee_count
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id NOT NULL
GROUP BY d.dept_name;

-- 25. Fetch employees earning more than department avg
SELECT  e.emp_name,
        e.salary , 
        d.avg_salary AS dept_avg_salary,
        e.salary - d.avg_salary AS difference_salary
FROM employees e
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) d
ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_salary;

-- 26. Fetch employees with same salary in same department
SELECT dept_id ,salary, GROUP_CONCAT(emp_name,',') AS emp_name
FROM employees
GROUP BY dept_id,salary
HAVING COUNT(*) > 1;

-- 27. Fetch employees belonging to multiple departments
SELECT emp_name, GROUP_CONCAT(dept_id,',') AS dept_ids
FROM employees
GROUP BY emp_id
HAVING COUNT(DISTINCT dept_id) > 1;

-- 28. Fetch employees whose department has more than 10 employees
SELECT dept_id , COUNT(*) AS total_employee
FROM employees
GROUP BY dept_id
HAVING COUNT(*) >=10;

-- 29. Fetch employees with no manager
SELECT emp_name
FROM employees
WHERE manager_id is NULL;

-- 30. Fetch employees reporting to same manager
SELECT GROUP_CONCAT(emp_name,',') AS employee_name
FROM employees
GROUP BY manager_id;

-- 31. Fetch employees whose  salary higher then manager
SELECT e.emp_name,
    e.salary AS emp_salary,
    m.manager_name,
    m.salary AS manager_salary
FROM employees e
JOIN managers m
ON e.manager_id = m.manager_id
WHERE e.salary > m.salary;

-- 40. update employee record according to emp_id
-- UPDATE employees
-- set dept_id = NULL
-- WHERE emp_id = 18;

