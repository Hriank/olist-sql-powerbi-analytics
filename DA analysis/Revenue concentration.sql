WITH customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(f.price + f.freight_value) AS revenue
    FROM fact_orders f
    JOIN dim_customers c ON f.customer_key = c.customer_key
    WHERE f.is_canceled = FALSE
    GROUP BY c.customer_unique_id
),
ranked AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY revenue DESC) AS revenue_quintile  -- 1 = top 20%
    FROM customer_revenue
)
SELECT
    revenue_quintile,
    COUNT(*)      AS num_customers,
    SUM(revenue)  AS quintile_revenue,
    ROUND(100.0 * SUM(revenue) / SUM(SUM(revenue)) OVER (), 2) AS pct_of_total_revenue
FROM ranked
GROUP BY revenue_quintile
ORDER BY revenue_quintile;
