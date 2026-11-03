with A1 as(select *,coalesce(sum(amount) over(partition by account_id order by txn_time rows between unbounded preceding and 1 preceding),0) as prev_sum,
sum(amount) over(partition by account_id order by txn_time) as current_sum
from `emplyee_data`.`bank_transactions`),
A2 as(select *, case 
when prev_sum>=0 and current_sum<0 then 'OVERDRAFT_BREACH'
when prev_sum<0 and current_sum<0 then 'UNDER_WATER'
when prev_sum<0 and current_sum>=0 then 'OVERDRAFT_RESOLVED'
else 'NORMAL' 
end as account_status
from A1)
select * from A2 
where account_status in ('OVERDRAFT_BREACH', 'OVERDRAFT_RESOLVED')