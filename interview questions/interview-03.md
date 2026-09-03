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

#### Q-3
```bash
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