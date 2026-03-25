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

#### Q-4
```bash
```

#### Q-5
```bash
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