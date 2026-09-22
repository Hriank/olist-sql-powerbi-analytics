SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.price + f.freight_value)  AS monthly_revenue,
    COUNT(DISTINCT f.order_id)      AS order_volume
FROM fact_orders f
JOIN dim_date d ON f.date_key = d.date_key
WHERE f.is_canceled = FALSE
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;
