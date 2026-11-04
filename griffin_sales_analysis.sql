-- Name: Mequil Griffin
-- Territory: Connecticut
-- Capstone 1 Sales Analysis

-- 1st Analysis: Total revenue overall for sales in Connecticut sorted by start and end dates.
SELECT SUM(Sale_Amount) AS total_rev,
MIN(Transaction_Date) AS start_date,
MAX(Transaction_Date) AS end_date
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State = "Connecticut" ;

-- 2nd Analysis: Connecticut sales breakdown by Year 2022
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
	AND Date BETWEEN "2022-01-01" AND "2022-12-31"
ORDER BY Date ASC ;
-- 2nd Analysis (B): Connecticut sales breakdown by year 2025
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
	AND Date BETWEEN "2025-01-01" AND "2025-12-31"
ORDER BY Date ASC ;
-- 2nd Analysis (C): Connecticut sales breakdown by months
SELECT *
FROM online_sales
WHERE ShiptoState LIKE "connecticut%"
ORDER BY MONTH(Date);
-- 3rd Analysis: Comparison bewteen Connecticut total revenue vs East region revenue
SELECT Region, SUM(Sale_Amount) AS Region_Rev
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
JOIN management
	ON store_locations.State = management.State
WHERE Region = "East"
GROUP BY Region ;

-- 4th Analysis: Number of transactions per month and averge transaction by product category in Connecticut
SELECT inventory_categories.Category, COUNT(*) AS Total_Transactions, 
ROUND(AVG(store_sales.Sale_Amount), 2) AS Avg_Transactions
FROM store_sales JOIN products
	ON Prod_Num = ProdNum
JOIN inventory_categories
	ON products.Categoryid = inventory_categories.Categoryid
JOIN store_locations
	ON Store_ID = StoreId
WHERE store_locations.State = "Connecticut"
GROUP BY inventory_categories.Category
ORDER BY Total_Transactions DESC
;
-- 5th Analysis: Ranking  of in-store sales performance in Connecticut
SELECT DISTINCT Store_ID, StoreLocation,COUNT(Sale_Amount) AS total_sales
FROM store_sales JOIN store_locations
	ON store_sales.Store_ID = store_locations.StoreId
WHERE State = "Connecticut"
GROUP BY Store_ID
ORDER BY total_sales DESC ;
-- New London had the most sales while Waterbury had the lowest

-- 6th Analysis: Recommendation on where to focus sales attention in the next quarter.
-- I suggest focusing our attention toward our sales in Waterbury for Connecticut. Our total revenue makes up for about 
-- 33% of regional revenue. Waterbury has the lowest revenue when ranking stores. Let's focus our
-- attention toward bringing up the sales through morre product variety and introducing more deals and sales. 