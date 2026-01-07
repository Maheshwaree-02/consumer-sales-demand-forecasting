--Total Sales and Volume--
SELECT
    SUM(units_sold) AS total_units_sold,
    SUM(units_sold * net_price) AS total_sales_value
FROM retail.sales_fact;
------------------------
------------------------
--Sales Trending Month over Month--
SELECT
    d.year,
    d.month,
    SUM(f.units_sold * f.net_price) AS monthly_sales
FROM retail.sales_fact f
JOIN retail.date_dim d ON f.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
---------------------------
---------------------------

--Regions generate the highest revenue--
SELECT
    s.region,
    SUM(f.units_sold * f.net_price) AS total_sales
FROM retail.sales_fact f
JOIN retail.store_dim s ON f.store_id = s.store_id
GROUP BY s.region
ORDER BY total_sales DESC;
-----------------------------------------
-----------------------------------------

--Category Demand Analysis---
SELECT
    p.category,
    SUM(f.units_sold) AS total_units_sold,
    SUM(f.units_sold * f.net_price) AS category_sales
FROM retail.sales_fact f
JOIN retail.product_dim p ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY category_sales DESC;
-----------------------------------------
-----------------------------------------

---Promotion Impact----
SELECT
    s.promotion,
    AVG(f.units_sold) AS avg_units_sold,
    SUM(f.units_sold * f.net_price) AS total_sales
FROM retail.sales_fact f
JOIN retail.date_dim d
    ON f.date_id = d.date_id
JOIN retail.staging_sales s
    ON s.store_id = f.store_id
   AND s.product_id = f.product_id
   AND CAST(s.date AS DATE) = d.date
GROUP BY s.promotion;
-------------------------------------
-------------------------------------

