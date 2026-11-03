with A1 as(select user_id, date_format(activity_date, '%Y-%m-01') as activity_date
from `emplyee_data`.`user_activity_log`),
A2 as(select *, min(activity_date) over(partition by user_id) as cohort_date 
from A1),
A3 as(select *, timestampdiff(month, cohort_date, activity_date) as diff from A2)
select cohort_date, count(distinct user_id) as total_cnt, 
concat(round(count(distinct case when diff = 1 then user_id end)/count(distinct user_id)*100, 2), '%') as m1,
concat(round(count(distinct case when diff = 2 then user_id end)/count(distinct user_id)*100, 2), '%') as m2,
concat(round(count(distinct case when diff = 3 then user_id end)/count(distinct user_id)*100, 2), '%') as m3 from A3
group by cohort_date