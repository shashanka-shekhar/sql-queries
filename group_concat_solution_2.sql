select department, count(*) as emp_cnt, group_concat(distinct project_name separator ' ,') as projects
from `emplyee_data`.`group_concat`
group by department
order by department