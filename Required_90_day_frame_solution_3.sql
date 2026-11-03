with A1 as(select A.customer_id, A.customer_name, max(str_to_date(B.order_date, '%Y-%m-%d')) as order_date
from `emplyee_data`.`customers_90_day_frame` as A
left join `emplyee_data`.`orders_90_day_frame` as B
on A.customer_id = B.customer_id
group by A.customer_id, A.customer_name)
select *, timestampdiff(day, order_date,'2026-08-01') as diff  
from A1
where order_date is null or order_date<=date_sub('2026-08-01', interval 90 day)