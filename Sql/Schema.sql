CREATE SCHEMA IF NOT EXISTS retail;

-- =========================
-- DATE DIMENSION
-- =========================
CREATE TABLE IF NOT EXISTS retail.date_dim (
    date_id INT PRIMARY KEY,
    date DATE,
    year INT,
    month INT,
    quarter INT,
    week INT,
    day INT
);

-- =========================
-- STORE DIMENSION
-- =========================
CREATE TABLE IF NOT EXISTS retail.store_dim (
    store_id TEXT PRIMARY KEY,
    region TEXT
);

-- =========================
-- PRODUCT DIMENSION
-- =========================
CREATE TABLE IF NOT EXISTS retail.product_dim (
    product_id TEXT PRIMARY KEY,
    category TEXT,
    price NUMERIC,
    competitor_pricing NUMERIC
);

-- =========================
-- SALES FACT TABLE
-- =========================
CREATE TABLE retail.sales_fact (
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

