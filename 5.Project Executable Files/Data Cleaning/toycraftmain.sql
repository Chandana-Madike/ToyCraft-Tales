USE ToyCraftDB;
CREATE TABLE toy_data (
    year INT,
    segment VARCHAR(100),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    manufacturer VARCHAR(100),
    revenue_million_usd DECIMAL(10,2),
    units_sold_million DECIMAL(10,2),
    region VARCHAR(100),
    season VARCHAR(50)
);