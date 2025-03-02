CREATE DATABASE customer_transaction;
-- Use the database
USE customer_transaction;

-- Create the main table for storing transactions
CREATE TABLE customer_transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice FLOAT,
    CustomerID INT,
    Country VARCHAR(50)
);

-- Verify table creation
DESCRIBE customer_transactions;

-- View first 10 rows
SELECT * FROM customer_transactions LIMIT 10;

-- Count total transactions
SELECT COUNT(*) AS total_transactions FROM customer_transactions;

-- Count unique customers
SELECT COUNT(DISTINCT CustomerID) AS unique_customers FROM customer_transactions;

-- Find Top 5 Best-Selling Products (by quantity sold)
SELECT Description, SUM(Quantity) AS total_sold
FROM customer_transactions
GROUP BY Description
ORDER BY total_sold DESC
LIMIT 5;

-- Find Top 5 Revenue-Generating Products
SELECT Description, ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM customer_transactions
GROUP BY Description
ORDER BY total_revenue DESC
LIMIT 5;

-- Find Top 5 Most Valuable Customers (by total spend)
SELECT CustomerID, COUNT(*) AS total_purchases, ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
FROM customer_transactions
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 5;

-- Find Monthly Revenue Trends
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS month, 
       ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue
FROM customer_transactions
GROUP BY month
ORDER BY month;

-- Get the date range of transactions
SELECT MIN(InvoiceDate), MAX(InvoiceDate) FROM customer_transactions;

-- Backup the table before modifying columns
CREATE TABLE customer_transactions_backup AS SELECT * FROM customer_transactions;

-- Convert InvoiceDate column to DATETIME format
ALTER TABLE customer_transactions ADD COLUMN InvoiceDate_New DATETIME;
UPDATE customer_transactions 
SET InvoiceDate_New = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i:%s');

-- Verify the conversion
SELECT InvoiceDate, InvoiceDate_New FROM customer_transactions LIMIT 10;

-- Replace old column with new formatted column
ALTER TABLE customer_transactions DROP COLUMN InvoiceDate;
ALTER TABLE customer_transactions CHANGE COLUMN InvoiceDate_New InvoiceDate DATETIME;

-- Modify column data types for better performance
ALTER TABLE customer_transactions MODIFY COLUMN InvoiceNo VARCHAR(20);
ALTER TABLE customer_transactions MODIFY COLUMN StockCode VARCHAR(20);
ALTER TABLE customer_transactions MODIFY COLUMN Description VARCHAR(255);
ALTER TABLE customer_transactions MODIFY COLUMN Quantity INT;
ALTER TABLE customer_transactions MODIFY COLUMN CustomerID BIGINT;
ALTER TABLE customer_transactions MODIFY COLUMN Country VARCHAR(50);

-- Step 1: Create Index on CustomerID for faster customer lookups
CREATE INDEX idx_customer ON customer_transactions (CustomerID);

-- Step 2: Create Index on InvoiceDate for date-based analysis
CREATE INDEX idx_date ON customer_transactions (InvoiceDate);

-- Step 3: Create Composite Index on CustomerID + InvoiceDate for combined lookups
CREATE INDEX idx_customer_date ON customer_transactions (CustomerID, InvoiceDate);

-- Step 4: Verify Indexes
SHOW INDEXES FROM customer_transactions;

-- Analyze query performance
EXPLAIN SELECT * FROM customer_transactions WHERE CustomerID = 12345;

-- Count total rows after modifications
SELECT COUNT(*) FROM customer_transactions;

-- Check for duplicate customers
SELECT CustomerID, COUNT(*) 
FROM customer_transactions
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- Export data to a CSV file
SELECT * FROM customer_transactions 
INTO OUTFILE 'C:/Users/jojee/Desktop/ETL_pipeline_customer_transaction.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';

-- Compute Total Revenue
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue 
FROM customer_transactions;

-- Compute Running Total Revenue Over Time
SELECT InvoiceDate, 
       ROUND(SUM(Quantity * UnitPrice), 2) AS daily_revenue,
       ROUND(SUM(SUM(Quantity * UnitPrice)) OVER (ORDER BY InvoiceDate), 2) AS cumulative_revenue
FROM customer_transactions
GROUP BY InvoiceDate
ORDER BY InvoiceDate;

-- Compute Cumulative Revenue by Month
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS month, 
       ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue,
       ROUND(SUM(SUM(Quantity * UnitPrice)) OVER (ORDER BY DATE_FORMAT(InvoiceDate, '%Y-%m')), 2) AS cumulative_revenue
FROM customer_transactions
GROUP BY month
ORDER BY month;

-- Compute Cumulative Sales for Each Customer
SELECT CustomerID, InvoiceDate, 
       ROUND(SUM(Quantity * UnitPrice), 2) AS transaction_value,
       ROUND(SUM(SUM(Quantity * UnitPrice)) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate), 2) AS cumulative_spent
FROM customer_transactions
GROUP BY CustomerID, InvoiceDate
ORDER BY CustomerID, InvoiceDate;

-- Compute Running Total of Products Sold
SELECT InvoiceDate, 
       SUM(Quantity) AS daily_sales,
       SUM(SUM(Quantity)) OVER (ORDER BY InvoiceDate) AS cumulative_sales
FROM customer_transactions
GROUP BY InvoiceDate
ORDER BY InvoiceDate;

-- Compute Cumulative Revenue by Country
SELECT Country, 
       ROUND(SUM(Quantity * UnitPrice), 2) AS country_revenue,
       ROUND(SUM(SUM(Quantity * UnitPrice)) OVER (ORDER BY Country), 2) AS cumulative_revenue
FROM customer_transactions
GROUP BY Country
ORDER BY cumulative_revenue DESC;
