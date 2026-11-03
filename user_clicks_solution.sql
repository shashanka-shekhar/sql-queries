with A1 as(select user_id, click_time, coalesce(lag(click_time) over(partition by user_id order by click_time),
click_time) as next_time
from `emplyee_data`.`user_clicks`),
A2 as(select *, timestampdiff(minute, next_time, click_time) as diff
from A1),
A3 as(select *, case when diff<=30 then 0 else 1 end as flag from A2),
A4 as(select *, sum(flag) over(partition by user_id order by next_time rows between unbounded preceding and current row) +1 as session from A3),
A5 as(select user_id, session, min(click_time) as start, max(click_time) as end, count(session) as total_clicks
from A4
group by user_id, session)
select *, timestampdiff(minute, start, end) as session_duration_minutes
from A5