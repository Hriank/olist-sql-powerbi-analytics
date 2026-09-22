SELECT
    dg.state,
    SUM(fo.price + fo.freight_value) AS total_revenue,
    COUNT(DISTINCT fo.order_id) AS total_orders,
    ROUND(SUM(fo.price + fo.freight_value) / COUNT(DISTINCT fo.order_id), 2) AS revenue_per_order
FROM fact_orders fo
JOIN dim_geography dg ON fo.geo_key = dg.geo_key
WHERE fo.is_canceled = FALSE
GROUP BY dg.state
ORDER BY total_revenue DESC
LIMIT 15;