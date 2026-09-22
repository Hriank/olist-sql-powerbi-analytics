WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(d.full_date)               AS last_order_date,
        COUNT(DISTINCT f.order_id)     AS frequency,
        SUM(f.price + f.freight_value) AS monetary
    FROM fact_orders f
    JOIN dim_customers c ON f.customer_key = c.customer_key
    JOIN dim_date d ON f.date_key = d.date_key
    WHERE f.is_canceled = FALSE
    GROUP BY c.customer_unique_id
),
rfm_scores AS (
    SELECT
        *,
        NTILE(4) OVER (ORDER BY last_order_date DESC) AS r_score,  -- more recent = higher
        NTILE(4) OVER (ORDER BY frequency ASC)         AS f_score,
        NTILE(4) OVER (ORDER BY monetary ASC)          AS m_score
    FROM rfm_base
)
SELECT
    customer_unique_id,
    r_score, f_score, m_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3                  THEN 'Loyal'
        WHEN r_score <= 2 AND f_score >= 3                  THEN 'At-Risk'
        ELSE 'Lost'
    END AS rfm_segment
FROM rfm_scores;