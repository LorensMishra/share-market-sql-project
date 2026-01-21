-- =========================================
-- SHARE MARKET SQL PROJECT
-- Database Creation, Tables, Sample Data
-- Practice Questions and Examples
-- =========================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS Share_MarketDB;
USE Share_MarketDB;
-- 2. Create Tables
-- Companies Table
CREATE TABLE Companies (
    company_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    sector VARCHAR(50),
    market_cap DECIMAL(15,2),
    stock_symbol VARCHAR(10) UNIQUE NOT NULL
);

-- Traders Table
CREATE TABLE Traders (
    trader_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    balance DECIMAL(15,2) DEFAULT 100000.00
);

-- Stocks Table
CREATE TABLE Stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    price_per_share DECIMAL(10,2),
    available_quantity INT,
    FOREIGN KEY (company_id) REFERENCES Companies(company_id)
);

-- Transactions Table
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    trader_id INT NOT NULL,
    stock_id INT NOT NULL,
    transaction_type ENUM('BUY','SELL') NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trader_id) REFERENCES Traders(trader_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- Portfolio Table (optional, can be updated with triggers or manually)
CREATE TABLE Portfolio (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    trader_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity_held INT DEFAULT 0,
    FOREIGN KEY (trader_id) REFERENCES Traders(trader_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- 3. Insert Sample Data

-- Companies
INSERT INTO Companies (company_name, sector, market_cap, stock_symbol) VALUES
('Apple Inc.', 'Technology', 2500000000000, 'AAPL'),
('Tesla Inc.', 'Automobile', 900000000000, 'TSLA'),
('Amazon.com', 'E-Commerce', 1700000000000, 'AMZN'),
('Microsoft Corp.', 'Technology', 2200000000000, 'MSFT'),
('Google LLC', 'Technology', 1500000000000, 'GOOGL');

-- Traders
INSERT INTO Traders (first_name, last_name, email, balance) VALUES
('John', 'Doe', 'john.doe@example.com', 150000.00),
('Alice', 'Smith', 'alice.smith@example.com', 200000.00),
('Bob', 'Johnson', 'bob.johnson@example.com', 120000.00),
('Emma', 'Brown', 'emma.brown@example.com', 180000.00),
('David', 'Lee', 'david.lee@example.com', 250000.00);

-- Stocks
INSERT INTO Stocks (company_id, price_per_share, available_quantity) VALUES
(1, 150.00, 10000),
(2, 700.00, 5000),
(3, 3300.00, 2000),
(4, 280.00, 8000),
(5, 2800.00, 1500);

-- Transactions
INSERT INTO Transactions (trader_id, stock_id, transaction_type, quantity, price) VALUES
(1, 1, 'BUY', 100, 150.00),
(1, 2, 'BUY', 50, 700.00),
(2, 3, 'BUY', 10, 3300.00),
(3, 4, 'BUY', 200, 280.00),
(4, 5, 'BUY', 5, 2800.00),
(1, 1, 'SELL', 50, 155.00),
(2, 3, 'SELL', 5, 3400.00);

-- Portfolio (initial holdings)
INSERT INTO Portfolio (trader_id, stock_id, quantity_held) VALUES
(1, 1, 50),
(1, 2, 50),
(2, 3, 5),
(3, 4, 200),
(4, 5, 5);

-- =========================================
-- PRACTICE QUESTIONS
-- =========================================

-- 1. Basic SELECT Queries

-- List all companies along with their stock symbols and sectors
SELECT company_name, stock_symbol, sector FROM Companies;

-- Show all traders with a balance greater than 150,000
SELECT * FROM Traders WHERE balance > 150000;

-- List all stocks with their current price and available quantity
SELECT s.stock_id, c.company_name, s.price_per_share, s.available_quantity
FROM Stocks s
JOIN Companies c ON s.company_id = c.company_id;

-- Display all transactions where the trader bought stocks
SELECT * FROM Transactions WHERE transaction_type = 'BUY';

-- 2. Filtering and Sorting

-- List traders whose first name starts with "A"
SELECT * FROM Traders WHERE first_name LIKE 'A%';

-- Find stocks with a price per share greater than 500 and sort by price descending
SELECT s.stock_id, c.company_name, s.price_per_share
FROM Stocks s
JOIN Companies c ON s.company_id = c.company_id
WHERE s.price_per_share > 500
ORDER BY s.price_per_share DESC;

-- Show transactions that happened after 2025-01-01
SELECT * FROM Transactions WHERE transaction_date > '2025-01-01';

-- List companies with market cap greater than 1 trillion
SELECT * FROM Companies WHERE market_cap > 1000000000000;

-- 3. Aggregate Functions

-- Find the total number of shares sold for each stock
SELECT s.stock_id, c.company_name, SUM(t.quantity) AS total_sold
FROM Transactions t
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id
WHERE t.transaction_type = 'SELL'
GROUP BY s.stock_id, c.company_name
ORDER BY total_sold DESC;

-- Calculate the total amount spent by each trader on BUY transactions
SELECT t.trader_id, tr.first_name, tr.last_name, SUM(t.quantity * t.price) AS total_spent
FROM Transactions t
JOIN Traders tr ON t.trader_id = tr.trader_id
WHERE t.transaction_type = 'BUY'
GROUP BY t.trader_id, tr.first_name, tr.last_name;

-- Find the average stock price per company sector
SELECT c.sector, AVG(s.price_per_share) AS avg_price
FROM Stocks s
JOIN Companies c ON s.company_id = c.company_id
GROUP BY c.sector;

-- Show the highest and lowest stock prices in the market
SELECT MAX(price_per_share) AS highest_price, MIN(price_per_share) AS lowest_price FROM Stocks;

-- 4. JOIN Queries

-- Show all transactions with trader name, company name, transaction type, quantity, and price
SELECT t.transaction_id, tr.first_name, tr.last_name, c.company_name, t.transaction_type, t.quantity, t.price
FROM Transactions t
JOIN Traders tr ON t.trader_id = tr.trader_id
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id;

-- List portfolio holdings with trader name, company name, and quantity held
SELECT p.trader_id, tr.first_name, tr.last_name, c.company_name, p.quantity_held
FROM Portfolio p
JOIN Traders tr ON p.trader_id = tr.trader_id
JOIN Stocks s ON p.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id;

-- Find total value of portfolio per trader
SELECT tr.trader_id, tr.first_name, tr.last_name, SUM(p.quantity_held * s.price_per_share) AS portfolio_value
FROM Portfolio p
JOIN Traders tr ON p.trader_id = tr.trader_id
JOIN Stocks s ON p.stock_id = s.stock_id
GROUP BY tr.trader_id, tr.first_name, tr.last_name;

-- List traders who have bought shares from the Technology sector
SELECT DISTINCT tr.trader_id, tr.first_name, tr.last_name
FROM Transactions t
JOIN Traders tr ON t.trader_id = tr.trader_id
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id
WHERE c.sector = 'Technology' AND t.transaction_type = 'BUY';

-- 5. Advanced SQL Features

-- a) Views

-- Create a view TraderPortfolioView
CREATE VIEW TraderPortfolioView AS
SELECT tr.trader_id, tr.first_name, tr.last_name, c.company_name, p.quantity_held, s.price_per_share,
       (p.quantity_held * s.price_per_share) AS portfolio_value
FROM Portfolio p
JOIN Traders tr ON p.trader_id = tr.trader_id
JOIN Stocks s ON p.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id;

-- Create a view DailyTransactions for a specific date
CREATE VIEW DailyTransactions AS
SELECT t.transaction_id, t.transaction_date, tr.first_name, tr.last_name, c.company_name, t.transaction_type, t.quantity, t.price
FROM Transactions t
JOIN Traders tr ON t.trader_id = tr.trader_id
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id;

-- b) Indexes

-- Create an index on Stocks(price_per_share)
CREATE INDEX idx_price ON Stocks(price_per_share);

-- Create a composite index on Transactions(trader_id, transaction_type)
CREATE INDEX idx_trader_type ON Transactions(trader_id, transaction_type);

-- c) Filters / WHERE Clauses

-- Show all traders with a portfolio value greater than 100,000
SELECT tr.trader_id, tr.first_name, tr.last_name, SUM(p.quantity_held * s.price_per_share) AS portfolio_value
FROM Portfolio p
JOIN Traders tr ON p.trader_id = tr.trader_id
JOIN Stocks s ON p.stock_id = s.stock_id
GROUP BY tr.trader_id, tr.first_name, tr.last_name
HAVING portfolio_value > 100000;

-- Find stocks with less than 2000 available shares
SELECT s.stock_id, c.company_name, s.available_quantity
FROM Stocks s
JOIN Companies c ON s.company_id = c.company_id
WHERE s.available_quantity < 2000;

-- List all SELL transactions where the price per share was above 1500
SELECT t.transaction_id, tr.first_name, tr.last_name, c.company_name, t.quantity, t.price
FROM Transactions t
JOIN Traders tr ON t.trader_id = tr.trader_id
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id
WHERE t.transaction_type = 'SELL' AND t.price > 1500;

-- d) Logs / Audit

-- Insert a log entry for a BUY transaction (example)
INSERT INTO StockLog (stock_id, change_type, quantity_changed, old_price, new_price)
SELECT stock_id, 'BUY', quantity, price, price FROM Transactions
WHERE transaction_type = 'BUY';

-- =========================================
-- END OF SHARE MARKET SQL PRACTICE SCRIPT
-- =========================================
