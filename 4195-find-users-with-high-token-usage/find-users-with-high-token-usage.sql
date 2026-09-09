# Write your MySQL query statement below
WITH user_stats AS (
    SELECT
        user_id,
        COUNT(*) AS prompt_count,
        AVG(tokens) AS avg_tokens
    FROM prompts
    GROUP BY user_id
)
SELECT
    p.user_id,
    u.prompt_count,
    ROUND(u.avg_tokens, 2) AS avg_tokens
FROM prompts p
JOIN user_stats u
    ON p.user_id = u.user_id
WHERE u.prompt_count >= 3
GROUP BY
    p.user_id,
    u.prompt_count,
    u.avg_tokens
HAVING MAX(p.tokens) > u.avg_tokens
ORDER BY
    avg_tokens DESC,
    p.user_id ASC;