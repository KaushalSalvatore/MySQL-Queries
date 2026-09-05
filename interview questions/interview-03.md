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