SELECT
    COUNT(DISTINCT order_id) FILTER (WHERE is_canceled)                              AS canceled_orders,
    COUNT(DISTINCT order_id)                                                          AS total_orders,
    ROUND(100.0 * COUNT(DISTINCT order_id) FILTER (WHERE is_canceled) / COUNT(DISTINCT order_id), 2) AS cancellation_rate_pct,
    SUM(price + freight_value) FILTER (WHERE is_canceled)                             AS revenue_lost
FROM fact_orders;

-- by category
SELECT
    p.category,
    COUNT(DISTINCT f.order_id) FILTER (WHERE f.is_canceled)                              AS canceled_orders,
    COUNT(DISTINCT f.order_id)                                                            AS total_orders,
    ROUND(100.0 * COUNT(DISTINCT f.order_id) FILTER (WHERE f.is_canceled) / COUNT(DISTINCT f.order_id), 2) AS cancellation_rate_pct,
    SUM(f.price + f.freight_value) FILTER (WHERE f.is_canceled)                          AS revenue_lost
FROM fact_orders f
JOIN dim_products p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue_lost DESC NULLS LAST;