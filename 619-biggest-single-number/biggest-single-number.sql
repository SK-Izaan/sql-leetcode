-- # Write your MySQL query statement below
-- select num
-- from MyNumbers
-- group by num
-- having count(num)<=1 and max(num)
select max(num) as num
from MyNumbers
where num in(select num from MyNumbers
group by num
having count(num)=1
)