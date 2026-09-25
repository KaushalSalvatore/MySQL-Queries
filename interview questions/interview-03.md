#### Q-1 find the total transaction amount for each product of group and total amount in decending order ? 
```bash
products 
id      name        grp
1       dsire       maruti
2       nexon       tata
3       punch       tata

transaction 
trns_id     id      amount
1           2           8
2           2           8
3           2           6
4           1           4
5           3           4

select grp,sum(ammount) as total_amt
from products p
join transaction t
on p.id = t.id
group by p.maruti
order by total_amt decs
```

#### Q-2 find First Order Date and Last Order Date for Every Customer ?
```bash
Select Distinct customer_id, Min(order_date) OVER(partitionBy("customer_id")) AS startig_date, 
MAX(order_date) over(partitionBY("customer_id")) AS ending_date
from customer_record
order by customer_id;
```

#### Q-3 You are given a transactions table , write a query to identify repeated payments made at the same merchant,using the same credit card and with same amount within 10 minutes.
```bash
trans_id , merchant_id , card_id, amount , tran_time 

with payment_check AS (
    select trana_id , merchant_id , card_id, amount , tran_time , LAG(tran_time) Over(
        PARTITION BY trana_id , merchant_id , card_id
        ORDER BY tran_time
    ) pre_trans_time
    from transactions
)
select trans_id, merchant_id, card_id, amount, tran_time,previous_trans_time,
    DATEDIFF('minute',previous_trans_time,tran_time) AS time_gap_minutes
FROM payment_check
WHERE DATEDIFF('minute',previous_trans_time,tran_time) <= 10
ORDER BY merchant_id, card_id, tran_time;
``` 

#### Q-4 Write a query to Group clicks into unique sessions.A new session starts if a user has been inactive for more than 30 minutes. Assign a session_id to each click. 
```bash
table : user_id , event_time
output : usr_id, evebt_time,sessionID

WITH click_gap AS (
    SELECT
        user_id,
        event_time,
        LAG(event_time) OVER (
            PARTITION BY user_id
            ORDER BY event_time
        ) AS previous_event_time
    FROM clicks
),
session_start AS (
    SELECT
        user_id,
        event_time,
        CASE
            WHEN previous_event_time IS NULL THEN 1
            WHEN DATEDIFF(
                'minute',
                previous_event_time,
                event_time
            ) > 30 THEN 1
            ELSE 0
        END AS new_session
    FROM click_gap
)
SELECT
    user_id,
    event_time,
    SUM(new_session) OVER (
        PARTITION BY user_id
        ORDER BY event_time
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS session_id
FROM session_start
ORDER BY user_id, event_time;
```

#### Q-5 Winfow function CURRENT ROW , PRECEDING , UNBOUNDED , LEAD , LAG , INTERVAL '6 days' ? 
```bash
1. ROWS BETWEEN 2 PRECEDING AND CURRENT ROW :- Take the current row and the previous 2 physical rows.

2. ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW :- Start from the very first row in the window and 
continue up to the current row.

3. RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW :- Include all rows whose date falls within the 
previous 6 calendar days, up to the current date.

4. LAG() :- fetches a value from a previous row.

5. LEAD() :- fetches a value from a following row.

PRECEDING  → rows before current row
CURRENT ROW → current row
FOLLOWING  → rows after current row

UNBOUNDED PRECEDING → start from first row
UNBOUNDED FOLLOWING → go until last row
```

#### Q-6   Write a Python function to filter out customers who have made more than 5 purchases in the last 6 months ? 
```bash
Select 
From customerName , Count(*) As purchases_count 
from purchases
WHERE purchase_date >= CURRENT_DATE - INTERVAL '6 months'
Group by customerID 
HAVING COUNT(*) > 5 
ORDER BY purchases_count desc ;
```

#### Q-7 write a query to identify users who placed more than 20 critical orders every week for at least 1 month ?  
```bash
WITH weekly AS (
    SELECT
        user_id,
        username,
        DATE_TRUNC('week', order_date) AS week_start,
        COUNT(*) AS weekly_count
    FROM userRecord
    WHERE order_type = 'CRITICAL'
    GROUP BY user_id, username, DATE_TRUNC('week', order_date)
)
SELECT
    user_id,
    username
FROM weekly
WHERE weekly_count > 20
GROUP BY user_id, username
HAVING COUNT(*) >= 4;
```

#### Q-8 Write a SQL query to identify accounts with transactions exceeding a specified threshold within a 24-hour period ? 
```bash
SELECT DISTINCT
    account_id
FROM transactions
QUALIFY
    SUM(amount) OVER (
        PARTITION BY account_id
        ORDER BY transaction_time
        RANGE BETWEEN INTERVAL '24 HOURS' PRECEDING
                  AND CURRENT ROW
    ) > 10000;
```

#### Q-9 need to caluclate transaction count under the 10 sec ? 
```bash
transaction_id customer amount   transaction_date 
19153           ram      65.90   07/10/2022 10:00:00
19153           ram      65.90   07/10/2022 10:00:01

SELECT
    transaction_id,
    customer,
    transaction_date,
    COUNT(*) OVER (
        PARTITION BY customer
        ORDER BY transaction_date
        RANGE BETWEEN INTERVAL '10 SECONDS' PRECEDING
                  AND CURRENT ROW
    ) AS transaction_count_10_sec
FROM transactions;
```

#### Q-10 Write a SQL query to identify accounts with transactions exceeding a specified threshold within a 24-hour period ? 
```bash
transactions
------------
account_number
transaction_date
transaction_amount
transaction_limit

SELECT
    account_number,
    transaction_date,
    transaction_amount,
    SUM(transaction_amount) OVER (
        PARTITION BY account_number
        ORDER BY transaction_date
        RANGE BETWEEN INTERVAL '24 HOURS' PRECEDING
                  AND CURRENT ROW
    ) AS amount_24_hours
FROM transactions
QUALIFY amount_24_hours > transaction_limit;
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