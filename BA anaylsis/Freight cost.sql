SELECT
    p.category,
    SUM(f.freight_value) AS total_freight,
    SUM(f.price)          AS total_price,
    ROUND(100.0 * SUM(f.freight_value) / NULLIF(SUM(f.price), 0), 2) AS freight_pct_of_revenue
FROM fact_orders f
JOIN dim_products p ON f.product_key = p.product_key
WHERE f.is_canceled = FALSE
GROUP BY p.category
ORDER BY freight_pct_of_revenue DESC;