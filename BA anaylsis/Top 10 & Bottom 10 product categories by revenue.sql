WITH category_revenue AS (
    SELECT
        p.category,
        SUM(f.price)                AS total_revenue,
        COUNT(DISTINCT f.order_id)  AS total_orders
    FROM fact_orders f
    JOIN dim_products p ON f.product_key = p.product_key
    WHERE f.is_canceled = FALSE
    GROUP BY p.category
)
SELECT *
FROM (
    (SELECT *, 'Top 10' AS rank_group FROM category_revenue
     ORDER BY total_revenue DESC LIMIT 10)
    UNION ALL
    (SELECT *, 'Bottom 10' AS rank_group FROM category_revenue
     ORDER BY total_revenue ASC LIMIT 10)
) ranked
ORDER BY rank_group, total_revenue DESC;
