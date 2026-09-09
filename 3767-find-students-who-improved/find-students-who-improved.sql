# Write your MySQL query statement below
SELECT 
    student_id,
    subject,
    MIN(CASE WHEN exam_date = first_date THEN score END) AS first_score,
    MAX(CASE WHEN exam_date = latest_date THEN score END) AS latest_score
FROM (
    SELECT *,
           MIN(exam_date) OVER (PARTITION BY student_id, subject) AS first_date,
           MAX(exam_date) OVER (PARTITION BY student_id, subject) AS latest_date
    FROM Scores
) t
GROUP BY student_id, subject
HAVING COUNT(DISTINCT exam_date) >= 2
   AND first_score < latest_score
ORDER BY student_id, subject;