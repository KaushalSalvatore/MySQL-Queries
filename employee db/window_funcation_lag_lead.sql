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

--6. Compare current record with next record.
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

--7. Find time difference between events.

--8. Detect repeated values in consecutive rows.


--9. Find trend (increase/decrease) in sales.

--10. Calculate day-over-day growth percentage.




--10. Fetch first and last salary in each department.

-- Find earliest joined employee per department.
-- Find latest transaction per customer.
-- Remove duplicate rows using window functions.
-- Identify duplicate records based on multiple columns.
-- Find employees who joined on same day.
-- Detect islands and gaps problem.
-- Find continuous login days.
-- Find customers with consecutive purchases.
-- Rank rows based on multiple columns.
-- FRAME CLAUSE (INTERVIEWER FAVORITE)
-- Calculate sliding window sum (3 previous rows).
-- Calculate moving average including current + next rows.
-- Why does LAST_VALUE() give unexpected output?
-- How to fix LAST_VALUE() using frame clause?