#### Q-1 How do you handle NULL values in SQL ? 
```bash
✅ 1. Use COALESCE (replace NULL)
SELECT *
FROM A
JOIN B
ON COALESCE(A.id, 0) = COALESCE(B.id, 0);

✅ 2. Explicit NULL matching
SELECT *
FROM A
JOIN B
ON (A.id = B.id OR (A.id IS NULL AND B.id IS NULL));

✅ 3. Filter NULLs before join
SELECT *
FROM A
JOIN B
ON A.id = B.id
WHERE A.id IS NOT NULL AND B.id IS NOT NULL;
```

#### Q-2 Write an SQL query to calculate the customer churn rate over the last 6 months ?
```bash
WITH last_txn AS (
    SELECT 
        customer_id,
        MAX(transaction_date) AS last_transaction
    FROM transactions
    GROUP BY customer_id
),
churn_data AS (
    SELECT 
        COUNT(CASE 
              WHEN last_transaction < CURRENT_DATE - INTERVAL '6 months' 
              THEN 1 END) AS churned_customers,
        COUNT(*) AS total_customers
    FROM last_txn
)
SELECT 
    churned_customers,
    total_customers,
    ROUND(churned_customers * 100.0 / total_customers, 2) AS churn_rate_percentage
FROM churn_data;
```

#### Q-3 we have table with user login/logout details, find users that have not logged in 2 consecutive days ? 
```bash
SELECT DISTINCT user_id
FROM (
    SELECT 
        user_id,
        login_date,
        LAG(login_date) OVER (PARTITION BY user_id ORDER BY login_date) AS prev_login
    FROM user_activity
) t
WHERE DATEDIFF(login_date, prev_login) > 1;
```

#### Q-4 SQL execution flow - 1
```bash
SELECT emp_name , salary
FROM employees 
WHERE salary < (SELECT AVG(salary) FROM employees);

Step 1 — Execute Subquery First
SELECT AVG(salary) FROM employees;

Step 2 — Outer Query Runs

SELECT → FROM → WHERE
1. FROM employees
2. Subquery (AVG calculation)
3. WHERE salary < avg
4. SELECT columns
```

#### Q-5 SQL execution flow - 2
```bash
SELECT d.dept_name , COUNT(e.emp_name) AS emp_count
FROM departments d
LEFT JOIN employees e
    ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_name) = 3
ORDER BY emp_count ASC
LIMIT 1;

1. FROM + JOIN
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id

🥈 2. GROUP BY
GROUP BY d.dept_name

🥉 3. Aggregate Functions
COUNT(e.emp_name)

🏅 4. HAVING (Filter Groups)
HAVING COUNT(e.emp_name) = 3

🏁 5. SELECT
SELECT d.dept_name, COUNT(e.emp_name) AS emp_count

🔽 6. ORDER BY
ORDER BY emp_count ASC

🔟 7. LIMIT
LIMIT 1

1. FROM + JOIN
2. GROUP BY
3. Aggregation (COUNT)
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT
```

#### Q-6
```bash
```

#### Q-7
```bash
```

#### Q-8
```bash
```

#### Q-9
```bash
```

#### Q-10
```bash
```

#### Q-11
```bash
```

#### Q-12
```bash
```

#### Q-13
```bash
```

#### Q-14
```bash
```

#### Q-15
```bash
```

#### Q-16
```bash
```

#### Q-17
```bash
```

#### Q-18
```bash
```

#### Q-19
```bash
```

#### Q-20
```bash
```