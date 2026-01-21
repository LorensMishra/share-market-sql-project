# 📈 Share Market SQL Project

A **Share Market Database Management System** built using **MySQL**, designed to simulate real-world stock trading, portfolio management, and transaction analysis.  
This project demonstrates strong skills in **SQL database design, querying, and financial data analysis**.

🔗 **GitHub Repository:**  
https://github.com/LorensMishra/share-market-sql-project

---

## 🚀 Project Overview

This project models a simplified **stock market system**, including:
- Companies listed on the market
- Traders performing buy/sell operations
- Stock price management
- Portfolio tracking
- Transaction history analysis

It is ideal for **SQL practice**, **interview preparation**, and **finance-based data analysis projects**.

---

## 🧩 Database Schema

### Tables Included
- **Companies** – Company details and market capitalization
- **Traders** – Trader information and account balance
- **Stocks** – Stock prices and available quantities
- **Transactions** – Buy and sell history
- **Portfolio** – Trader stock holdings

### Key Design Concepts
- Primary Keys & Foreign Keys
- One-to-Many relationships
- Data integrity with constraints
- Real-world financial modeling

---

## 🛠 Technologies Used

- **Database:** MySQL  
- **SQL Concepts:**
  - SELECT, INSERT, UPDATE, DELETE  
  - JOIN (INNER)  
  - GROUP BY, HAVING  
  - Subqueries  
  - ENUM  
  - Views  
  - Indexes  

---

## 📊 Features & Analysis

### 🔹 Core Features
- Trader portfolio tracking
- Buy & sell transaction management
- Stock availability tracking
- Portfolio value calculation

### 🔹 SQL Analysis
- Total investment per trader
- Stock-wise buy/sell volume
- Sector-wise price analysis
- High-value portfolio identification

---

## 👁️ Views

### 1️⃣ TraderPortfolioView
Provides a summarized view of:
- Trader details
- Company name
- Quantity held
- Current stock price
- Total portfolio value

### 2️⃣ DailyTransactions
Simplifies daily transaction reporting with:
- Trader name
- Company name
- Transaction type
- Quantity and price

---

## ⚡ Performance Optimization

- Index on `Stocks(price_per_share)`
- Composite index on `Transactions(trader_id, transaction_type)`
- Optimized JOIN and GROUP BY queries

---

## 🧪 Sample SQL Queries

```sql
-- Total portfolio value per trader
SELECT tr.trader_id, tr.first_name, tr.last_name,
       SUM(p.quantity_held * s.price_per_share) AS portfolio_value
FROM Portfolio p
JOIN Traders tr ON p.trader_id = tr.trader_id
JOIN Stocks s ON p.stock_id = s.stock_id
GROUP BY tr.trader_id, tr.first_name, tr.last_name;
```

```sql
-- Total shares sold per company
SELECT c.company_name, SUM(t.quantity) AS total_sold
FROM Transactions t
JOIN Stocks s ON t.stock_id = s.stock_id
JOIN Companies c ON s.company_id = c.company_id
WHERE t.transaction_type = 'SELL'
GROUP BY c.company_name;
```

```structure
# 📂 Project Structure
share-market-sql-project/
│
├── share_market.sql   # Database schema, sample data & queries
├── README.md          # Project documentation
└── docs/              # (Optional) ER diagrams or screenshots
```

# 🎯 Learning Outcomes

* Strong understanding of relational database design
* Hands-on experience with financial datasets
* Advanced SQL querying and performance tuning
* Practical exposure to portfolio and trading analytics

# 🔮 Future Enhancements

* Add TRIGGERS for automatic portfolio updates
* Implement stored procedures
* Add user authentication simulation
* Integrate with Power BI / Tableau dashboards

# 👨‍💻 Author

**Lorens Mishra**
🎓 **Junior Software Engineer** | MCA | SQL | Data Analytics | Python


🔗 GitHub: [https://github.com/LorensMishra](https://github.com/LorensMishra)

⭐ *If you find this project useful, please give it a star!*


