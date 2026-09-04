# Write your MySQL query statement below
select user_id, name,mail
from Users

where regexp_like(
    mail,
    '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$',
    'c'
);