with A1 as(select order_id, product_id, row_number() over(partition by order_id order by product_id) as rn 
from `emplyee_data`.`market_basket_2`),
A2 as(select A.product_id as product_A, B.product_id as product_B from A1 as A
inner join A1 as B
on A.order_id = B.order_id and A.rn<B.rn)
select product_A, product_B, count(*) as req_cnt from A2
group by product_A, product_B
order by count(*) desc
