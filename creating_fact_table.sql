CREATE TABLE fact_orders AS
WITH order_payment_agg AS (
    SELECT order_id, SUM(payment_value) AS total_payment_value
    FROM stg_payments
    GROUP BY order_id
),
order_review_agg AS (
    SELECT order_id, AVG(review_score) AS avg_review_score
    FROM stg_reviews
    GROUP BY order_id
)
SELECT
    ROW_NUMBER() OVER (ORDER BY oi.order_id, oi.order_item_id) AS fact_key,
    oi.order_id,
    oi.order_item_id,
    dc.customer_key,
    dp.product_key,
    dd.date_key,
    dg.geo_key,
    o.order_status,
    oi.price,
    oi.freight_value,
    opa.total_payment_value,
    ora.avg_review_score,
    CASE WHEN o.order_status = 'canceled' THEN TRUE ELSE FALSE END AS is_canceled
FROM stg_order_items oi
JOIN stg_orders o        ON oi.order_id = o.order_id
JOIN stg_customers c     ON o.customer_id = c.customer_id
JOIN dim_customers dc    ON c.customer_unique_id = dc.customer_unique_id
JOIN dim_products dp     ON oi.product_id = dp.product_id
JOIN dim_date dd         ON dd.full_date = o.order_purchase_timestamp::date
LEFT JOIN dim_geography dg ON dg.zip_code_prefix = c.customer_zip_code_prefix
LEFT JOIN order_payment_agg opa ON oi.order_id = opa.order_id
LEFT JOIN order_review_agg ora  ON oi.order_id = ora.order_id;

SELECT COUNT(*) FROM fact_orders;
SELECT COUNT(*) FROM stg_order_items;