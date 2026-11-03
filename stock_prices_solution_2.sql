with A1 as(select ticker, date_format(trade_date, '%Y-%m-%d') as trade_date, close_price
from `emplyee_data`.`stock_prices`),
A2 as(select *, 
coalesce(max(close_price) over(partition by ticker order by trade_date rows between unbounded preceding and 1 preceding), close_price) as max_price 
from A1)
select * from A2
where close_price>=max_price