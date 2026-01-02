SET search_path TO retail;
SELECT * FROM date_dim LIMIT 5;


ALTER TABLE date_dim
ADD COLUMN day INT;

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

DROP TABLE IF EXISTS sales_fact;

CREATE TABLE store_dim (
    store_id TEXT PRIMARY KEY,
    region TEXT
);


CREATE TABLE product_dim (
    product_id TEXT PRIMARY KEY,
    category TEXT,
    price NUMERIC,
    competitor_pricing NUMERIC
);
INSERT INTO store_dim (store_id, region)
SELECT DISTINCT
    store_id,
    region
FROM staging_sales
WHERE store_id IS NOT NULL;

INSERT INTO product_dim (product_id, category, price, competitor_pricing)
SELECT
    product_id,
    MAX(category) AS category,
    AVG(price::NUMERIC) AS price,
    AVG(competitor_pricing::NUMERIC) AS competitor_pricing
FROM staging_sales
WHERE product_id IS NOT NULL
GROUP BY product_id;

TRUNCATE TABLE product_dim;


SELECT COUNT(*) FROM sales_fact;
SELECT * FROM sales_fact LIMIT 5;

CREATE TABLE sales_fact (
    sales_id SERIAL PRIMARY KEY,

    date_id INT REFERENCES date_dim(date_id),
    store_id TEXT REFERENCES store_dim(store_id),
    product_id TEXT REFERENCES product_dim(product_id),

    units_sold INT,
    units_ordered INT,
    demand INT,
    inventory_level INT,

    net_price NUMERIC,
    discount NUMERIC,

    stock_gap INT,
    stockout_risk TEXT,
    demand_to_inventory_ratio NUMERIC
);


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


