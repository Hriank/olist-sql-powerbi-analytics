WITH order_level AS (
    SELECT
        f.order_id,
        d.year,
        SUM(f.price + f.freight_value) AS order_total
    FROM fact_orders f
    JOIN dim_date d ON f.date_key = d.date_key
    WHERE f.is_canceled = FALSE
    GROUP BY f.order_id, d.year
),
yearly_revenue AS (
    SELECT year, SUM(order_total) AS revenue
    FROM order_level
    GROUP BY year
)
SELECT
    year,
    revenue,
    LAG(revenue) OVER (ORDER BY year) AS prev_year_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY year))
        / NULLIF(LAG(revenue) OVER (ORDER BY year), 0), 2
    ) AS yoy_growth_pct
FROM yearly_revenue
ORDER BY year;

