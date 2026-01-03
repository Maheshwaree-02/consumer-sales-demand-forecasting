-- =========================
-- LOAD DATE DIMENSION
-- =========================
INSERT INTO date_dim (date, year, month, quarter, week, day)
SELECT DISTINCT
    TO_DATE(date, 'YYYY-MM-DD') AS date,
    year::INT,
    month::INT,
    quarter::INT,
    week::INT,
    day::INT
FROM staging_sales
WHERE date IS NOT NULL;

-- =========================
-- LOAD STORE DIMENSION
-- =========================
INSERT INTO store_dim (store_id, region)
SELECT DISTINCT
    store_id,
    region
FROM staging_sales
WHERE store_id IS NOT NULL;

-- =========================
-- LOAD PRODUCT DIMENSION
-- =========================
INSERT INTO product_dim (product_id, category, price, competitor_pricing)
SELECT
    product_id,
    MAX(category) AS category,
    AVG(price::NUMERIC) AS price,
    AVG(competitor_pricing::NUMERIC) AS competitor_pricing
FROM staging_sales
WHERE product_id IS NOT NULL
GROUP BY product_id;

-- =========================
-- LOAD SALES DIMENSION
-- =========================
INSERT INTO sales_fact (
    date_id,
    store_id,
    product_id,
    units_sold,
    units_ordered,
    demand,
    inventory_level,
    net_price,
    discount,
    stock_gap,
    stockout_risk,
    demand_to_inventory_ratio
)
SELECT
    d.date_id,
    s.store_id,
    s.product_id,

    ROUND(s.units_sold::NUMERIC)::INT,
    ROUND(s.units_ordered::NUMERIC)::INT,
    ROUND(s.demand::NUMERIC)::INT,
    ROUND(s.inventory_level::NUMERIC)::INT,

    s.net_price::NUMERIC,
    s.discount::NUMERIC,

    ROUND(s.stock_gap::NUMERIC)::INT,
    s.stockout_risk,
    s.demand_to_inventory_ratio::NUMERIC
FROM staging_sales s
JOIN date_dim d
  ON d.date = TO_DATE(s.date, 'YYYY-MM-DD');

