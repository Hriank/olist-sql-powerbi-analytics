WITH order_level AS (
    SELECT
        fo.order_id,
        dd.year,
        dd.month,
        TO_CHAR(dd.full_date, 'Mon YYYY') AS month_label,
        SUM(fo.price + fo.freight_value) AS order_total
    FROM fact_orders fo
    JOIN dim_date dd ON fo.date_key = dd.date_key
    WHERE fo.is_canceled = FALSE
    GROUP BY fo.order_id, dd.year, dd.month, TO_CHAR(dd.full_date, 'Mon YYYY')
)
SELECT
    year,
    month,
    month_label,
    ROUND(AVG(order_total), 2) AS avg_order_value,
    COUNT(*) AS total_orders
FROM order_level
GROUP BY year, month, month_label
ORDER BY year, month;