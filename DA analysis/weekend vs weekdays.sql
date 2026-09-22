WITH order_level AS (
    SELECT f.order_id, d.full_date, d.is_weekend,
        SUM(f.price + f.freight_value) AS order_total
    FROM fact_orders f
    JOIN dim_date d ON f.date_key = d.date_key
    WHERE f.is_canceled = FALSE
    GROUP BY f.order_id, d.full_date, d.is_weekend
),
daily AS (
    SELECT full_date AS order_date, is_weekend,
        COUNT(order_id) AS daily_orders,
        SUM(order_total) AS daily_revenue
    FROM order_level
    GROUP BY full_date, is_weekend
)
SELECT is_weekend,
    ROUND(AVG(daily_orders), 1) AS avg_daily_orders,
    ROUND(AVG(daily_revenue), 2) AS avg_daily_revenue,
    ROUND(AVG(daily_revenue) / NULLIF(AVG(daily_orders), 0), 2) AS avg_order_value
FROM daily
GROUP BY is_weekend;

