# Write your MySQL query statement below
WITH ranked_reviews AS (
    SELECT
        employee_id,
        rating,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn
    FROM performance_reviews
),
last_three AS (
    SELECT
        employee_id,
        rating,
        rn
    FROM ranked_reviews
    WHERE rn <= 3
)
SELECT
    e.employee_id,
    e.name,
    MAX(l.rating) - MIN(l.rating) AS improvement_score
FROM last_three l
JOIN employees e
    ON l.employee_id = e.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(*) = 3
   AND MAX(CASE WHEN rn = 3 THEN rating END)
       < MAX(CASE WHEN rn = 2 THEN rating END)
   AND MAX(CASE WHEN rn = 2 THEN rating END)
       < MAX(CASE WHEN rn = 1 THEN rating END)
ORDER BY improvement_score DESC, e.name ASC;