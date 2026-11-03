with A1 as(select product_id, order_date, quantity,  month(order_date) as rnk
from `emplyee_data`.`order_transactions`),
A2 as(select *,  month(change_date) as rnk1
from `emplyee_data`.`product_price_changes`),
A3 as(select A1.product_id, order_date, quantity, rnk, change_date, new_price, rnk1 from A1
inner join A2 
on A1.product_id = A2.product_id
where A1.order_date>=A2.change_date),
A4 as(select product_id, order_date, max(change_date) as cut_date
from A3
group by product_id, order_date)
select A3.product_id, A4.order_date, A4.cut_date, A3.quantity, A3.new_price, quantity*new_price as total from A4
inner join A3
ON A4.product_id = A3.product_id
where A4.order_date = A3.order_date and A4.cut_date = A3.change_date