with A1 as(select user_id, date_format(login_date, '%Y-%m-%d') as login_date
from `emplyee_data`.`consecutive_logins`),
A2 as(select distinct user_id, login_date, dense_rank() over(partition by user_id order by login_date) as rnk 
from A1),
A3 as(select user_id, date_sub(login_date, interval rnk day) as diff
from A2),
A4 as(select user_id, diff, count(*) as cnt from A3
group by user_id, diff
order by user_id)
select user_id, max(cnt) as req_cnt
from A4
group by user_id
order by user_id
