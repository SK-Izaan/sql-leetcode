# Write your MySQL query statement below
WITH weekly_meetings AS (
    SELECT
        employee_id,
        YEARWEEK(meeting_date, 1) AS week_num,
        SUM(duration_hours) AS meeting_hours
    FROM meetings
    GROUP BY employee_id, YEARWEEK(meeting_date, 1)
)
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    COUNT(*) AS meeting_heavy_weeks
FROM weekly_meetings w
JOIN employees e
    ON w.employee_id = e.employee_id
WHERE w.meeting_hours > 20
GROUP BY
    e.employee_id,
    e.employee_name,
    e.department
HAVING COUNT(*) >= 2
ORDER BY
    meeting_heavy_weeks DESC,
    e.employee_name ASC;