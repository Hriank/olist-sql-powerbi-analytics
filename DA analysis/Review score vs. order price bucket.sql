WITH bucketed AS (
    SELECT
        CASE
            WHEN f.price < 50  THEN '1. Under R$50'
            WHEN f.price < 150 THEN '2. R$50-150'
            WHEN f.price < 300 THEN '3. R$150-300'
            ELSE '4. R$300+'
        END AS price_bucket,
        f.avg_review_score,
        f.freight_value
    FROM fact_orders f
    WHERE f.is_canceled = FALSE
      AND f.avg_review_score IS NOT NULL
)
SELECT
    price_bucket,
    COUNT(*)                        AS num_orders,
    ROUND(AVG(avg_review_score), 2) AS avg_review_score,
    ROUND(AVG(freight_value), 2)    AS avg_freight
FROM bucketed
GROUP BY price_bucket
ORDER BY price_bucket;