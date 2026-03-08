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
```

#### Q-11 Write a query to fetch duplicate records from a table with employee name and salary ? 
```bash
```

#### Q-12 How will you remove duplicate records without using DISTINCT ? 
```bash
```

#### Q-13 Suppose you have a table with Employee, Salary, and Department. How would you return the top 3 highest salaries from each department? 
```bash
```

#### Q-14 What will be your approach to increment salary by 10% for employees having salary less than 50K in one query? 
```bash
```

#### Q-15 How would you identify the missing numbers between 1 to 100 from an employee ID column?
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