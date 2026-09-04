# Write your MySQL query statement below
select ifnull(null, email) as Email
from Person
group by email
having count(email)>1