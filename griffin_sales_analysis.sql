-- Name: Mequil Griffin
-- Territory: Connecticut
-- Capstone 1 Sales Analysis

-- 1st Analysis: Total revenue overall for sales in Connecticut sorted by start and end dates.
SELECT 
SUM(SalesTotal) AS total_rev,
MIN(Date) AS start_date,
MAX(Date) AS end_date
FROM online_sales
WHERE ShiptoState = "Connecticut"
;

-- 2nd Analysis: Connecticut sales breakdown by Year 2022
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
	AND Date BETWEEN "2022-01-01" AND "2022-12-31"
ORDER BY Date ASC
;
-- 2nd Analysis (B): Connecticut sales breakdown by year 2025
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
	AND Date BETWEEN "2025-01-01" AND "2025-12-31"
ORDER BY Date ASC
;
-- 2nd Analysis (C): Connecticut sales breakdown by months
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
ORDER BY MONTH(Date);
-- 3rd Analysis: Comparison bewteen Connecticut total revenue vs East region revenue
SELECT *
FROM 
-- 4th Analysis: Number of transactions per month and averge transaction by product category in Connecticut

-- 5th Analysis: Create a ranking of either in-store or online store sales performance

-- 6th Analysis: Recommendation on where to focus sales attention in the next quarter.