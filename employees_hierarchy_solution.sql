with recursive A1 as(select *, 1 as hierarchy_level, emp_name as reporting_path
from `emplyee_data`.`employees_hierarchy`
where manager_id = ''

union all

select e.emp_id, e.emp_name, e.manager_id, hierarchy_level+1 as hierarchy_level, 
concat(h.reporting_path, '->', e.emp_name) as reporting_path
from `emplyee_data`.`employees_hierarchy` as e
inner join A1 as h
on e.manager_id = h.emp_id
)
select * from A1
