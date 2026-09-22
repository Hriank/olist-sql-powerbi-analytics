WITH customer_order_counts AS (
    SELECT
        dc.customer_key,
        COUNT(DISTINCT fo.order_id) AS num_orders
    FROM fact_orders fo
    JOIN dim_customers dc ON fo.customer_key = dc.customer_key
    WHERE fo.is_canceled = FALSE
    GROUP BY dc.customer_key
)
SELECT
    CASE WHEN num_orders = 1 THEN 'One-time buyer' ELSE 'Repeat buyer' END AS customer_type,
    COUNT(*) AS num_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_customers
FROM customer_order_counts
GROUP BY CASE WHEN num_orders = 1 THEN 'One-time buyer' ELSE 'Repeat buyer' END;