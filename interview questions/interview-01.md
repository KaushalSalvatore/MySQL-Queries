#### Q-1 VALUE and VALUES key word in mysql ?
```bash
MySQL is flexible with SQL syntax to improve developer convenience.

VALUE is technically intended for a single row, but MySQL doesn't enforce it.

It treats VALUE the same as VALUES under the hood.

But:
VALUES is more standard and explicit, making your code more readable.

Some other SQL databases (e.g., PostgreSQL, SQL Server) do not allow VALUE for multiple inserts.

Portability: If you ever switch databases, VALUES will work everywhere — VALUE might break.
```

#### Q-2 what is STRICT_ALL_TABLES or STRICT_TRANS_TABLES ? 
```bash
| Mode                  | Behavior                                                  |
| --------------------- | --------------------------------------------------------- |
| `STRICT_ALL_TABLES`   | Strict rules for **all tables**                           |
| `STRICT_TRANS_TABLES` | Strict rules mainly for **transactional tables (InnoDB)** |

STRICT_ALL_TABLES forces MySQL to reject bad data instead of automatically fixing it.

When STRICT_ALL_TABLES is enabled, MySQL will:
❌ Reject invalid data
❌ Stop the query with an error
❌ Prevent automatic data truncation or correction

Example 1:-
CREATE TABLE users (
  id INT,
  age INT NOT NULL
);
INSERT INTO users (id, age) VALUES (1, NULL);

| Mode                | Result                               |
| ------------------- | ------------------------------------ |
| Normal mode         | MySQL may insert `0` or default      |
| `STRICT_ALL_TABLES` | ❌ Error: Column 'age' cannot be null |

Example 2:-
CREATE TABLE products (
  name VARCHAR(5)
);
INSERT INTO products VALUES ('Laptop');\

| Mode        | Result                        |
| ----------- | ----------------------------- |
| Normal      | Inserts `"Lapto"` (truncated) |
| Strict mode | ❌ Error: Data too long        |

STRICT_ALL_TABLES helps to:
Maintain data integrity
Prevent hidden bugs
Avoid unexpected data modification
```

#### Q-3 Why Multiple NULLs Are Allowed in a UNIQUE Column ?
```bash
UNIQUE constraint enforces that no two values should be the same.

But NULL represents "unknown" — it's not considered a value.

Since each NULL is treated as unique, you can insert it multiple times.

according to the SQL standard, NULL is not equal to anything, not even to another NULL
```

#### Q-4 Where Clause and Group By Clause --> What should be the proper sequence ?
```bash
Answer -> Where Clause and then Group By ?
```

#### Q-5 what use of DELETE key in sql ? 
```bash
DELETE FROM customers;
DELETE FROM customers WHERE country = 'USA';

Characteristics:
Can delete specific rows using WHERE
Fully logged (row-level logging)
Slower for large tables
Triggers DO fire
Can be rolled back
Does NOT reset auto-increment/identity (in most DBs)
```

#### Q-6 what use of TRUNCATE key in sql ? 
```bash
TRUNCATE
TRUNCATE TABLE customers;
removes all rows only
Much faster
Minimal logging
Triggers usually DO NOT fire
Often cannot be rolled back (depends on DB)
Resets auto-increment / identity
Cannot use WHERE
```

#### Q-7 how to ROLLBACK data if table DELETE ? 
```bash
You can only roll back a DELETE if the delete happened inside a transaction that hasn’t been committed yet. 
Once it’s committed, the database considers it final and rollback won’t work.

BEGIN;
DELETE FROM customers WHERE country = 'USA';
-- Check what happened
SELECT * FROM customers;
ROLLBACK;
After ROLLBACK, the deleted rows come back.

DELETE FROM customers;
COMMIT;

You CANNOT use ROLLBACK.
Now your recovery options depend on your database setup:
```

#### Q-8 Difference between ROWS and RANGE ? 
```bash
1. ROWS
ROWS defines the window by physical row positions.
SELECT id, salary,
SUM(salary) OVER (
  ORDER BY id
  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS running_sum
FROM employees;

2. RANGE
RANGE defines the window based on value range, not row count.
SELECT salary,
SUM(salary) OVER (
  ORDER BY salary
  RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
FROM employees;
```

#### Q-9 remove duplicates from table ?
```bash
There are 3 ways to find duplicates:
Method	When to Use
| Method            | When to Use            |
| ----------------- | ---------------------- |
| GROUP BY + HAVING | Simple duplicates      |
| CTE + JOIN        | Clean separation logic |
| Window Function   | Most modern & powerful |
```

#### Q-10 How would you find the 2nd highest salary from an employee table without using TOP or LIMIT ? 
```bash
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary < (
    SELECT MAX(salary)
    FROM employee
);
------------------------------------------------
SELECT name, dept, salary
FROM (
    SELECT 
        name,
        dept,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rk
    FROM employee
) t
WHERE rk = 2;
```

#### Q-11 Write a query to fetch duplicate records from a table with employee name and salary ? 
```bash
SELECT e1.name, e1.salary
FROM employee e1
JOIN employee e2
ON e1.name = e2.name
AND e1.salary = e2.salary
AND e1.id > e2.id;
-----------------------------------------------------------
SELECT name, salary, COUNT(*) AS duplicate_count
FROM employee
GROUP BY name, salary
HAVING COUNT(*) > 1;
---------------------------------------------------------
SELECT *
FROM (
    SELECT *,
           COUNT(*) OVER(PARTITION BY name, salary) AS cnt
    FROM employee
) t
WHERE cnt > 1;
```

#### Q-12 How will you remove duplicate records without using DISTINCT ? 
```bash
DELETE e1
FROM employee e1
JOIN employee e2
ON e1.name = e2.name
AND e1.salary = e2.salary
AND e1.id > e2.id;
-----------------------------------------
DELETE FROM employee
WHERE id NOT IN (
    SELECT MIN(id)
    FROM employee
    GROUP BY name, salary
);
```

#### Q-13 Suppose you have a table with Employee, Salary, and Department. How would you return the top 3 highest salaries from each department? 
```bash
SELECT name, salary, dept
FROM (
    SELECT 
        name,
        salary,
        dept,
        DENSE_RANK() OVER(
            PARTITION BY dept 
            ORDER BY salary DESC
        ) AS rnk
    FROM employee
) t
WHERE rnk <= 3;
```

#### Q-14 What will be your approach to increment salary by 10% for employees having salary less than 50K in one query? 
```bash
UPDATE employee
SET salary = salary * 1.10
WHERE salary < 50000;
```

#### Q-15 How would you identify the missing numbers between 1 to 100 from an employee ID column?
```bash
SELECT n.num AS missing_id
FROM (
    SELECT generate_series(1,100) AS num
) n
LEFT JOIN employee e
ON n.num = e.employee_id
WHERE e.employee_id IS NULL;

------------------------------------------------

SELECT e1.employee_id + 1 AS missing_id
FROM employee e1
LEFT JOIN employee e2
ON e1.employee_id + 1 = e2.employee_id
WHERE e2.employee_id IS NULL;
```

#### Q-16 You are given a table EmployeeLogs with columns EmployeeID, LoginTime, LogoutTime, and Date. Write a query to calculate the longest continuous working streak (consecutive days without missing a login) for each employee ?
```bash
Use ROW_NUMBER + date offset trick (gap & island problem) to group consecutive records.

WITH distinct_days AS (
    SELECT DISTINCT 
        EmployeeID,
        Date
    FROM EmployeeLogs
),
numbered AS (
    SELECT 
        EmployeeID,
        Date,
        ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY Date) AS rn
    FROM distinct_days
),
grouped AS (
    SELECT 
        EmployeeID,
        Date,
        Date - (rn * INTERVAL '1 day') AS grp
    FROM numbered
),
streaks AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS streak_length
    FROM grouped
    GROUP BY EmployeeID, grp
)
SELECT 
    EmployeeID,
    MAX(streak_length) AS longest_streak
FROM streaks
GROUP BY EmployeeID;
```

#### Q-17 A table SalesData contains columns TransactionID, Region, ProductID, SaleDate, and Revenue. Write a query to identify the top 3 products with the highest cumulative revenue in each region over the last financial  year ?
```bash
Financial year = April 1 to March 31

WITH filtered_data AS (
    SELECT *
    FROM SalesData
    WHERE SaleDate >= DATE '2024-04-01'
      AND SaleDate <  DATE '2025-04-01'
),
aggregated AS (
    SELECT 
        Region,
        ProductID,
        SUM(Revenue) AS total_revenue
    FROM filtered_data
    GROUP BY Region, ProductID
),
ranked AS (
    SELECT 
        Region,
        ProductID,
        total_revenue,
        RANK() OVER (PARTITION BY Region ORDER BY total_revenue DESC) AS rnk
    FROM aggregated
)
SELECT 
    Region,
    ProductID,
    total_revenue
FROM ranked
WHERE rnk <= 3;
```

#### Q-18 Explain the concept of window functions and how they differ from aggregate functions, with examples of use cases ?
```bash
Window functions:
👉 Perform calculations across a set of rows (window)
👉 BUT do NOT collapse rows

Aggregate functions collapse rows into groups, while window functions perform calculations across rows without losing 
the original data.
```

#### Q-19 Describe how ACID properties are maintained in modern relational databases and the challenges associated with distributed systems ?
```bash
ACID properties ensure reliable and consistent transactions in relational databases.
1. Atomicity (All or Nothing)
Ensures a transaction either fully completes or fully rolls back
Maintained using undo logs / transaction logs
If a failure occurs, the database rolls back incomplete changes

👉 Example: Bank transfer—if debit succeeds but credit fails, everything is rolled back

2. Consistency (Valid State)
Ensures database always moves from one valid state to another
Maintained using:
Constraints (PRIMARY KEY, FOREIGN KEY, CHECK)
Triggers and business rules

👉 Prevents invalid data (e.g., negative balance)

3. Isolation (Concurrency Control)
Ensures transactions don’t interfere with each other
Maintained using:
Locking (pessimistic)
MVCC (multi-version concurrency control)

👉 Example:

PostgreSQL uses MVCC so reads don’t block writes

4. Durability (No Data Loss)
Once committed, data is permanently stored
Maintained using:
Write-Ahead Logging (WAL)
Disk persistence

👉 Example:

MySQL (InnoDB) ensures committed data survives crashes
```

#### Q-20 Explain how different types of indexes (e.g., clustered, non-clustered) impact query performance in large datasets ? 
```bash
Clustered index stores actual data in sorted order → best for range queries
Non-clustered index stores pointers → best for fast lookups
Indexes reduce read time but increase write cost
Proper indexing is critical for large datasets to avoid full scans
```