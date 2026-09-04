# Write your MySQL query statement below
select r.contest_id, round(count(r.user_id)*100.0/(select count(*) from users),2) as Percentage
from Register r
group by contest_id
order by percentage desc, r.contest_id;