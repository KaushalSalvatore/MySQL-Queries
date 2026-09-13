--1. Find latest transaction per customer.
SELECT customer_name , tran_id , trans_date 
from customer 
QUALIFY ROW_NUMBER() OVER(PARTITION BY cus_id , ORDER BY trans_id DESC);

--2. Remove duplicate rows using window functions.
WITH remove_cte AS (
    select emp_name, ROW_NUMBER() OVER(PARTITION BY employeeID ORDER BY created_at DESC) as rank_emp
    FROM employee 
)
DELETE FROME remove_cte WHERE rank_emp > 1; 

--3. Identify duplicate records based on multiple columns.
WITH duplicate AS (
    select emp_name , emp_salary , emp_id , ROW_NUMBER() OVER(PARTITION BY EMP_ID , EMP_NAME ORDER BY created_at) as rank_emp
    FROM employee
) 
select *  from duplicate where rank_emp > 1; 

--4. Find employees who joined on same day.
Select emp_name , emp_date , count(*) as employee_count 
from employee
GROUP BY emp_date 
having count(*) > 1;

--5. Calculate moving average including current + next rows.
Select store , amount , AVG(amount) 
OVER(order by store ROW BETWEEN CURRENT ROW AND 1 FOLLOWING) as avg_crt_next
from sales;

--6. Find count continuous login days.
Select emp_name , emp_id , emp_login_date , LEAD(emp_login_date) 
OVER(PARTITION BY emp_id , emp_name ORDER BY emp_login_date) AS next_login,
DATEDIFF(day,emp_login_date,LEAD(emp_login_date) OVER (
            PARTITION BY emp_id
            ORDER BY emp_login_date) AS days_difference
FROM employee
ORDER BY emp_id;

--7. Find customers with consecutive purchases.
SELECT cust_name , cust_id  , DATEDIFF(day , order_date ,LEAD(order_date) OVER(PARTITION BY cust_id ORDER BY order_date)) 
as date_diff
FROM customer
WHERE date_diff > 1 ; 

--8. Rank rows based on multiple columns.


--9. Calculate sliding window sum (3 previous rows).

