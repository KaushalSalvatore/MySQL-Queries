-- RANKING & ORDERING (Very High Frequency)
-- RANK() {1, 2, 2, 4} 
--  DENSE_RANK() {1, 2, 2, 3} 
-- ROW_NUMBER() {1, 2,3, 4}

--1.  Find highest salary in each department.

SELECT emp_name , salary , dept_id
FROM (SELECT *, ROW_NUMBER() OVER
     (PARTITION BY dept_id ORDER BY salary DESC) rn
    FROM employees)
WHERE rn = 1;

--2. Find 2nd highest salary in the company.
SELECT emp_name , salary , dept_id
FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY salary DESC) rn
    FROM employees)
WHERE rn = 1;

--3. Find top 3 salaries per department.
SELECT emp_name , salary , dept_id 
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC)
    rn FROM employees
)
WHERE rn <= 3 ANd dept_id NOT NULL;

-- 4. Find employees with same salary and same rank.
SELECT emp_id , salary , dept_id , DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary)
AS salary_rank
FROM employees;

-- 5. Assign unique row numbers to records without using ID.
Select emp_name , ROW_NUMBER() OVER(ORDER BY joining_date) AS emp_rank
FROM employees;

-- 6. Assign unique row numbers to records without using ID and order by dept_id.
SELECT emp_name , dept_id , ROW_NUMBER()
OVER(PARTITION BY dept_id  ORDER BY salary DESC) AS rank_salary , salary
from employees; 

-- 7. Fetch last 3 joined employees in each department.
WITH ranked_emp AS (
    SELECT emp_name,
           dept_id,
           joining_date,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id 
               ORDER BY joining_date DESC
           ) AS rank_joining_date
    FROM employees
    WHERE dept_id IS NOT NULL
)
SELECT *
FROM ranked_emp
WHERE rank_joining_date <= 3;

-- 8. Identify employees earning more than department average.

-- SELECT d.dept_name , GROUP_CONCAT(e.emp_name) AS emp_list,
--  AVG(e.salary) AS dept_avg_salary , COUNT(*) AS emp_count
-- FROM employees e
-- JOIN departments d
-- ON e.dept_id = d.dept_id
-- WHERE e.dept_id IS NOT NULL AND 
--  e.salary > (SELECT AVG(e2.salary) FROM employees e2
--     WHERE e2.dept_id = e.dept_id)
-- GROUP BY e.dept_id;

SELECT 
    d.dept_name,
    GROUP_CONCAT(e.emp_name) AS emp_list,
    AVG(e.salary) OVER (PARTITION BY e.dept_id) AS dept_avg_salary,
    COUNT(*) AS emp_count
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
)
GROUP BY e.dept_id;

-- 10. Find Nth highest salary (N is dynamic).
SELECT *
FROM (
    SELECT emp_name,
           dept_id,
           salary,
           DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;
