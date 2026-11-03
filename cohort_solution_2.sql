with A1 as(select user_id, date_format(login_date, '%Y-%m-01') as login_date
from `emplyee_data`.`cohort`),
A2 as(select *, min(login_date) over(partition by user_id) as cohort_month from A1),
A3 as(select *, timestampdiff(month, cohort_month, login_date) as diff from A2)
select cohort_month, count(distinct case when diff = 0 then user_id end) as month_0,
count(distinct case when diff = 1 then user_id end) as month_1,
count(distinct case when diff = 2 then user_id end) as month_2
from A3
group by cohort_month
order by cohort_month