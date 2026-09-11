--1. Compare current salary with previous employee salary.
WITH compare_salary AS (
    SELECT
        emp_id,
        emp_name,
        salary,
        salary - LAG(salary) OVER (
            PARTITION by employee_id, employee_name
            ORDER BY salary
        ) AS diff_salary
    FROM employee
)
SELECT
    emp_id,
    emp_name,
    salary,
    diff_salary
FROM compare_salary
ORDER BY salary;

--2. Detect salary increase or decrease.
WITH compare_salary AS (
    SELECT
        emp_id,
        emp_name,
        salary,
        salary - LAG(salary) OVER (
            ORDER BY salary
        ) AS diff_salary
    FROM employee
)
SELECT
    emp_id,
    emp_name,
    salary,
    diff_salary,
    case 
        when diff_salary > 0 "increase",
        when diff_salary < 0 "decrease",
      ELSE 'No Change'
    end as salary_in_de
FROM compare_salar
ORDER BY salary;

--3. Find gap between consecutive transactions.
select customerID , customer_name , DATEDFF('day' , LAG(trans_date) 
OVER(PARTITION BY customerID ORDER BY trans_date), trans_date) AS trans_gap
from order_transaction
ORDER BY customerID, trans_date;

--4. Identify customers who skipped months EMI. 
select cusotmer_name , LAG(emi_date) over(PARTITION BY customer_id ORDER BY emi_date) as miss_emidate
from emi_time
where DATEDIFF(emi_date > miss_emidate) 
ORDER BY customerID, emi_date;

--5. Compare current record with next record.
WITH emi_check AS (
    SELECT
        customer_id,
        customer_name,
        emi_date,
        LAG(emi_date) OVER (
            PARTITION BY customer_id
            ORDER BY emi_date
        ) AS previous_emi_date
    FROM emi_time)
SELECT
    customer_id,
    customer_name,
    emi_date,
    previous_emi_date,
    DATEDIFF('month', previous_emi_date, emi_date) AS month_gap
FROM emi_check
WHERE DATEDIFF('month', previous_emi_date, emi_date) > 1
ORDER BY customer_id, emi_date;

--6. Find time difference between events.
with eventdiff as (
    select event_id , event_name , event_date LAG(event_date) OVER(PARTITION BY event_id , event_name ORDER by event_date)
    AS pre_event
    from event_record)
select event_id , event_name , event_date , pre_event DATEDIFF("month", event_date, pre_event)
from eventdiff
ORDER by event_id;

--7. Detect repeated orer amount values in consecutive rows.
with orderValue AS (
Select order_id , order_amount , order_time LAG(order_amount) Over(PARTITION BY order_id ORDER BY order_time)
AS pre_order
from order_table
)
select order_id , order_amount , order_time ,pre_order 
From orderValue
WHERE order_amount = pre_order
ORDER BY order_id, order_time;

--8. Calculate day-over-day growth percentage.
with growth_cal AS (
    select shop_name, shop_id , month , sale, LAG(sale) Over(PARTITION BY Shop_id ORDER BY month)
    as pre_month
    from sales
)
selet ,shop_name ,month ,sale, ROUND((sale - pre_month) / pre_month) * 100,2) AS per_sale
from growth_cal
ORDER BY shop_id;

--9. Fetch first and last salary in each department.


--10. Find earliest joined employee per department.