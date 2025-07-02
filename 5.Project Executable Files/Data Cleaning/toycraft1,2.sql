SELECT 
  SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year,
  SUM(CASE WHEN segment IS NULL THEN 1 ELSE 0 END) AS missing_segment,
  SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS missing_category,
  SUM(CASE WHEN sub_category IS NULL THEN 1 ELSE 0 END) AS missing_sub_category,
  SUM(CASE WHEN manufacturer IS NULL THEN 1 ELSE 0 END) AS missing_manufacturer,
  SUM(CASE WHEN revenue_million_usd IS NULL THEN 1 ELSE 0 END) AS missing_revenue,
  SUM(CASE WHEN units_sold_million IS NULL THEN 1 ELSE 0 END) AS missing_units,
  SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS missing_region,
  SUM(CASE WHEN season IS NULL THEN 1 ELSE 0 END) AS missing_season
FROM toy_data;

SELECT year, segment, category, sub_category, manufacturer, region, season,
       COUNT(*) AS duplicate_count
FROM toy_data
GROUP BY year, segment, category, sub_category, manufacturer, region, season
HAVING COUNT(*) > 1;

SELECT DISTINCT season FROM toy_data;
SELECT DISTINCT region FROM toy_data;
SELECT DISTINCT category FROM toy_data;
SELECT DISTINCT manufacturer FROM toy_data;

SET SQL_SAFE_UPDATES = 0;


UPDATE toy_data
SET revenue_million_usd = ROUND(revenue_million_usd, 2),
    units_sold_million = ROUND(units_sold_million, 2);
    
-- Scenario 1: Market Trend Analysis by Season
SELECT 
  year, 
  season, 
  SUM(revenue_million_usd) AS total_revenue
FROM toy_data
GROUP BY year, season
ORDER BY year, season;

-- Scenario 2: Consumer Preference by Region and Category
SELECT 
  region, 
  category, 
  SUM(units_sold_million) AS total_units_sold
FROM toy_data
GROUP BY region, category
ORDER BY region, total_units_sold DESC;

-- Scenario 3: Product Performance by Manufacturer
SELECT 
  manufacturer, 
  SUM(revenue_million_usd) AS total_revenue,
  SUM(units_sold_million) AS total_units_sold
FROM toy_data
GROUP BY manufacturer
ORDER BY total_revenue DESC;

-- Scenario 4: Top 10 Sub-Categories by Revenue
SELECT 
  sub_category, 
  SUM(revenue_million_usd) AS total_revenue
FROM toy_data
GROUP BY sub_category
ORDER BY total_revenue DESC
LIMIT 10;

-- Optional: Create a view for Tableau
CREATE VIEW v_region_category_sales AS
SELECT 
  region, 
  category, 
  SUM(units_sold_million) AS total_units_sold
FROM toy_data
GROUP BY region, category;


