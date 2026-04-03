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

#### Q-6 where to use cte ,subqureiy , window function ? 
```bash
1. CTE (Common Table Expression) – “Make complex logic readable”

👉 Use CTE (WITH clause) when:

You have multi-step transformations
You want readability & modular logic
You need to reuse the same intermediate result
You’re doing recursive queries
Breaking large queries into steps
Debugging (you can run each CTE separately)

2. Subquery – Filter or derive quick values
Use subqueries when:

You need a quick filter or lookup
Logic is simple and used once
Inside WHERE, FROM, or SELECT

3. Window Function – “Do calculations without collapsing rows”
Use window functions when:

You need ranking, running totals, lag/lead
Want aggregation but keep row-level detail

✔ Best for:

Top N per group
Deduplication
Time-based analysis
Moving averages
```

#### Q-7 row vs columnar storage and example  ?
```bash
1. Row-Based Storage – “Store full rows together”
id | name | age
1  | A    | 25
2  | B    | 30

Row1 → (1, A, 25)
Row2 → (2, B, 30)

✅ When to use:
OLTP systems (frequent inserts/updates)
When you read entire rows

🧠 Real examples:
MySQL
PostgreSQL
SQL Server

⚡ Pros:

✔ Fast for insert/update
✔ Good for transactional workloads
✔ Efficient when accessing full rows

❌ Cons:

✖ Slow for analytics (scans unnecessary columns)
✖ Poor compression

🔹 2. Columnar Storage – “Store column-wise”
id   → 1, 2
name → A, B
age  → 25, 30

✅ When to use:
OLAP / analytics
Queries on few columns over large data

🧠 Real examples:
Apache Parquet
ORC
Amazon Redshift
Snowflake

⚡ Pros:

✔ Reads only required columns → faster queries
✔ High compression (similar data together)
✔ Great for aggregation queries

❌ Cons:

✖ Slower writes/updates
✖ Not ideal for transactional systems

Scenario:

Table = 1 billion rows, 20 columns

👉 Query:
SELECT salary FROM employees;

Row store → scans all 20 columns ❌
Column store → scans only 1 column ✅

✔ Huge performance gain
```

#### Q-8 What is a Surrogate Key ?
```bash
A surrogate key is a system-generated unique identifier with no business meaning, used primarily in data warehouses 
to ensure stability, improve join performance, and handle slowly changing dimensions.

A surrogate key is an artificial (system-generated) unique identifier for a record.

It has no business meaning
Usually an integer or UUID
Used as a primary key

| customer_sk | customer_id | name |
| ----------- | ----------- | ---- |
| 1           | C101        | A    |
| 2           | C102        | B    |

customer_id → business key (natural key)
customer_sk → surrogate key

Why do we use Surrogate Keys?

1. ✅ Handle Changing Data (SCD Type 2)
✔ Same customer → multiple records
✔ Surrogate key keeps them unique

✔ Same customer → multiple records
✔ Surrogate key keeps them unique

| customer_sk | customer_id | city   |
| ----------- | ----------- | ------ |
| 1           | C101        | Delhi  |
| 2           | C101        | Mumbai |

2. ✅ Improve Join Performance
JOIN fact_table f
ON f.customer_sk = d.customer_sk

🧠 How to Generate Surrogate Keys
SQL :-

IDENTITY(1,1)
AUTO_INCREMENT
SEQUENCE

PySpark :-

from pyspark.sql.functions import monotonically_increasing_id

df = df.withColumn("customer_sk", monotonically_increasing_id())
```

#### Q-9 delete the duplicate records by id ? 
```bash
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY col1, col2 ORDER BY id) AS rn
    FROM your_table
)
DELETE FROM cte
WHERE rn > 1;

DELETE FROM your_table
WHERE id NOT IN (
    SELECT MIN(id)
    FROM your_table
    GROUP BY col1, col2
);
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