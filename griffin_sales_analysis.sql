-- Name: Mequil Griffin
-- Territory: Connecticut
-- Capstone 1 Sales Analysis

-- 1st Analysis: Total revenue overall for sales in Connecticut with start and end dates.
SELECT SUM(Sale_Amount) AS total_rev,
MIN(Transaction_Date) AS start_date,
MAX(Transaction_Date) AS end_date
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State = "Connecticut" ;

-- 2nd Analysis: Connecticut sales breakdown by Years (Trend)
SELECT YEAR(Transaction_Date) AS year_trend, SUM(Sale_Amount) AS total_sales
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State LIKE "connecticut%"
GROUP BY year_trend
ORDER BY total_sales DESC ;
-- 2nd Analysis (B): Connecticut sales breakdown by months (Trend)
SELECT MONTH(Transaction_Date) AS month, SUM(Sale_Amount) AS total_sales, YEAR(Transaction_Date) AS year
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State LIKE "connecticut%"
GROUP BY year, month
ORDER BY year, month ASC ; -- Pivot
-- 3rd Analysis: Comparison bewteen Connecticut total revenue vs East region revenue
SELECT Region, SUM(Sale_Amount) AS Region_Rev
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
JOIN management
	ON store_locations.State = management.State
WHERE Region = "East"
GROUP BY Region ;
 --  3rd Analysis continued: Total sales for connecticut
SELECT SUM(Sale_Amount) AS Connecticut_Total
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State = "Connecticut" ; -- Connecticut makes up for 35% of total sales in the East Region

-- 4th Analysis: Number of transactions per month in Connecticut
SELECT MONTH(Transaction_Date) AS Month_CT, COUNT(Sale_Amount) AS Total_Transactions
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State = "Connecticut"
GROUP BY Month_CT
ORDER BY Month_CT ASC ; -- Pivot
-- 4th Analysis (B): Averge transactions by product category in Connecticut
SELECT inventory_categories.Category, COUNT(*) AS Total_Transactions, 
ROUND(AVG(store_sales.Sale_Amount), 2) AS Avg_Sales_Price
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
SELECT DISTINCT Store_ID, StoreLocation,COUNT(Sale_Amount) AS total_transactions, SUM(Sale_Amount) AS total_sales
FROM store_sales JOIN store_locations
	ON store_sales.Store_ID = store_locations.StoreId
WHERE State = "Connecticut"
GROUP BY Store_ID
ORDER BY total_transactions DESC ;
-- New London had the most sales while Old Saybrook had the lowest

-- 6th Analysis: Recommendation on where to focus sales attention in the next quarter.
-- I suggest focusing our attention toward our sales in Waterbury for Connecticut. Our total revenue makes up for about 
-- 35% of regional revenue. Waterbury has the lowest revenue when ranking stores. Let's focus our
-- attention toward bringing up the sales through morre product variety and introducing more deals and sales.

-- 7th Analysis: Counts of individual products sold by Connecticut stores
SELECT Store_ID, StoreLocation, COUNT(DISTINCT(Prod_Num)) AS products_sold
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
WHERE State LIKE "connecticut%"
GROUP BY Store_ID
ORDER BY products_sold DESC ;

-- 8th Analysis: Averages of Product Categories sorted by Year and Month
SELECT 
YEAR(Transaction_Date) AS Year,
MONTH(Transaction_Date) AS Month,
inventory_categories.Categoryid,
inventory_categories.Category,
COUNT(store_sales.id) AS total_transactions,
ROUND(AVG(Sale_Amount), 2) AS Avg_Sales
FROM store_sales JOIN store_locations
	ON Store_ID = StoreId
JOIN products
	ON store_sales.Prod_Num = products.ProdNum
JOIN inventory_categories
	ON products.Categoryid = inventory_categories.Categoryid
WHERE State LIKE "connecticut%"
GROUP BY Year, Month, inventory_categories.Categoryid
ORDER BY Year, Month, inventory_categories.Categoryid ;