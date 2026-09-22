CREATE TABLE dim_date AS
SELECT
    ROW_NUMBER() OVER (ORDER BY d) AS date_key,
    d AS full_date,
    EXTRACT(YEAR FROM d) AS year,
    EXTRACT(MONTH FROM d) AS month,
    TO_CHAR(d, 'Month') AS month_name,
    EXTRACT(DAY FROM d) AS day,
    EXTRACT(DOW FROM d) AS day_of_week_num,   -- 0=Sunday, 6=Saturday
    TO_CHAR(d, 'Day') AS day_name,
    CASE WHEN EXTRACT(DOW FROM d) IN (0,6) THEN TRUE ELSE FALSE END AS is_weekend,
    EXTRACT(QUARTER FROM d) AS quarter
FROM generate_series('2016-01-01'::date, '2018-12-31'::date, '1 day'::interval) AS d;

SELECT * FROM dim_date ORDER BY date_key LIMIT 5;
SELECT COUNT(*) FROM dim_date;

CREATE TABLE dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_unique_id) AS customer_key,
    customer_unique_id,
    customer_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix
FROM stg_customers;

SELECT COUNT(*) FROM dim_customers;
SELECT COUNT(DISTINCT customer_unique_id) FROM stg_customers;

DROP TABLE IF EXISTS dim_customers;

CREATE TABLE dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_unique_id) AS customer_key,
    customer_unique_id,
    MIN(customer_city) AS customer_city,
    MIN(customer_state) AS customer_state,
    MIN(customer_zip_code_prefix) AS customer_zip_code_prefix
FROM stg_customers
GROUP BY customer_unique_id;

SELECT COUNT(*) FROM dim_customers;
SELECT COUNT(DISTINCT customer_unique_id) FROM stg_customers;

DROP TABLE IF EXISTS dim_products;

CREATE TABLE dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY p.product_id) AS product_key,
    p.product_id,
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM stg_products p
LEFT JOIN stg_category_translation t
    ON p.product_category_name = t.product_category_name;

SELECT COUNT(*) FROM dim_products;
SELECT COUNT(*) FROM stg_products;
SELECT category, COUNT(*) FROM dim_products GROUP BY category ORDER BY COUNT(*) DESC LIMIT 5;

DROP TABLE IF EXISTS dim_geography;

CREATE TABLE dim_geography AS
SELECT
    ROW_NUMBER() OVER (ORDER BY geolocation_zip_code_prefix) AS geo_key,
    geolocation_zip_code_prefix AS zip_code_prefix,
    MODE() WITHIN GROUP (ORDER BY geolocation_city) AS city,
    MODE() WITHIN GROUP (ORDER BY geolocation_state) AS state,
    AVG(geolocation_lat) AS latitude,
    AVG(geolocation_lng) AS longitude
FROM stg_geolocation
GROUP BY geolocation_zip_code_prefix;

SELECT COUNT(*) FROM dim_geography;
SELECT COUNT(DISTINCT geolocation_zip_code_prefix) FROM stg_geolocation;