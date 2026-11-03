with A1 as(select department_id, count(emp_id) over(partition by department_id) as emp_cnt, salary,
row_number() over(partition by department_id order by salary) as rnk
from `emplyee_data`.`department_wise_median`)
select department_id, emp_cnt, round(avg(salary), 0) as salary
from A1
where rnk between emp_cnt/2.0 and (emp_cnt/2.0)+1 
group by department_id, emp_cnt
order by department_id, emp_cnt
