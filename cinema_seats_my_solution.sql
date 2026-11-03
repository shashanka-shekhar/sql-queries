with A1 as(select *, sum(is_free) over(order by seat_id) as cnt from
`emplyee_data`.`cinema_seats`),
A2 as(select *, seat_id - cnt as diff from A1
where is_free = 1),
A3 as(select *, count(diff) over(partition by diff) as cnt_2 from A2)
select seat_id from A3
where cnt_2>=3