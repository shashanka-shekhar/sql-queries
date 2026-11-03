with A1 as(select year(sale_date) as Year, month(sale_date) as mnth, amount from 
`emplyee_data`.`daily_sales`),
A2 as(select Year, mnth, sum(amount) as monthly_sales,
sum(sum(amount)) over(partition by Year order by mnth) as current_year_ytd from A1
group by Year, mnth
order by Year, mnth),
A3 as(select *, lag(current_year_ytd) over(partition by mnth order by Year) as prior_year_ytd from A2
order by Year)
select *, concat(round(((current_year_ytd - prior_year_ytd)/prior_year_ytd)*100, 2), '%') as yoy_ytd_growth_pct
from A3