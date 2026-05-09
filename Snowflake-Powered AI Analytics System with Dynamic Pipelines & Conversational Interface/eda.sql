-- ── Q1: Average rent by city  ──────────────────────
SELECT
    city,
    province,
    COUNT(*)                      AS total_listings,
    ROUND(AVG(monthly_rent), 0)   AS avg_monthly_rent,
    ROUND(MIN(monthly_rent), 0)   AS min_rent,
    ROUND(MAX(monthly_rent), 0)   AS max_rent,
    ROUND(STDDEV(monthly_rent), 0) AS stddev_rent
FROM ALL_RENTALS
GROUP BY city, province
ORDER BY avg_monthly_rent DESC;


-- ── Q2: Monthly trend — average rent per year/month ────────────────────────
SELECT
    listing_year,
    listing_month,
    TO_DATE(listing_year || '-' || LPAD(listing_month, 2, '0') || '-01') AS period,
    COUNT(*)                    AS listings,
    ROUND(AVG(monthly_rent), 0) AS avg_rent
FROM ALL_RENTALS
GROUP BY listing_year, listing_month
ORDER BY listing_year, listing_month;


-- ── Q3: Top 5 most expensive cities per home type ───────────────────────────
WITH ranked AS (
    SELECT
        home_type,
        city,
        province,
        ROUND(AVG(monthly_rent), 0)                                AS avg_rent,
        RANK() OVER (PARTITION BY home_type ORDER BY AVG(monthly_rent) DESC) AS rnk
    FROM ALL_RENTALS
    GROUP BY home_type, city, province
)
SELECT home_type, city, province, avg_rent, rnk
FROM ranked
WHERE rnk <= 5
ORDER BY home_type, rnk;