# Write your MySQL query statement below
WITH trip_efficiency AS (
    SELECT
        driver_id,
        MONTH(trip_date) AS month,
        distance_km / fuel_consumed AS efficiency
    FROM trips
),
driver_avg AS (
    SELECT
        driver_id,
        AVG(CASE WHEN month BETWEEN 1 AND 6 THEN efficiency END) AS first_half_avg,
        AVG(CASE WHEN month BETWEEN 7 AND 12 THEN efficiency END) AS second_half_avg
    FROM trip_efficiency
    GROUP BY driver_id
)
SELECT
    d.driver_id,
    d.driver_name,
    ROUND(a.first_half_avg, 2) AS first_half_avg,
    ROUND(a.second_half_avg, 2) AS second_half_avg,
    ROUND(a.second_half_avg - a.first_half_avg, 2) AS efficiency_improvement
FROM driver_avg a
JOIN drivers d
    ON a.driver_id = d.driver_id
WHERE a.first_half_avg IS NOT NULL
  AND a.second_half_avg IS NOT NULL
  AND a.second_half_avg > a.first_half_avg
ORDER BY efficiency_improvement DESC, d.driver_name ASC;