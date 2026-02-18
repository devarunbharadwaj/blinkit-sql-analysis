# Blinkit SQL Analysis (PostgreSQL)

End-to-end SQL analysis of a quick-commerce dataset using PostgreSQL.

---

## 📌 Project Objective

To analyze customer behavior, sales performance, delivery efficiency, and feedback sentiment using structured SQL queries.

The goal is to simulate real-world business intelligence analysis for a quick-commerce platform like Blinkit.

---

## 🗂 Dataset Overview

The dataset consists of 6 relational tables:

- customers
- orders
- order_items
- products
- delivery
- feedback

The dataset was optimized and structured for analytical clarity.

---

## 🛠 Tools Used

- PostgreSQL
- pgAdmin 4
- GitHub

---

## 🏗 Database Design

Relational schema includes:

- Primary & Foreign Keys
- Aggregation-based segmentation
- Join operations across multiple tables

Schema file: `queries/schema.sql`

---

## 📊 Business Analysis Performed

### 1️⃣ Order & Revenue Analysis
- Total orders
- Monthly revenue trend
- Monthly order growth

### 2️⃣ Customer Analysis
- Customer segmentation (High / Mid / Low value)
- Repeat customers
- Top spending customers

### 3️⃣ Product & Category Performance
- Top selling products
- Revenue by category
- Units sold analysis

### 4️⃣ Delivery Performance
- On-time vs delayed delivery rate
- Recurring delay reasons
- Traffic-based delays
- Partner-wise delay distribution

### 5️⃣ Sentiment Analysis
- Feedback sentiment breakdown
- Sentiment vs delivery status correlation

---

## 🔎 Key Insights

- Majority of customers place only 1 order (low retention opportunity)
- Traffic is the primary recurring cause of delays
- Mid-value customers generate most delayed orders
- Delivery distance does not significantly impact delay probability
- Dairy & Breakfast is the top revenue-generating category
- Bread is the highest selling product
- Neutral sentiment dominates feedback

---

## 📈 Advanced SQL Concepts Used

- GROUP BY & HAVING
- Subqueries
- CASE statements
- Aggregations (SUM, AVG, COUNT)
- JOIN operations
- ORDER BY & LIMIT
- Conditional filtering

---

## 📁 Project Structure

```
data/              → Raw CSV files
queries/           → All SQL scripts
README.md          → Documentation
```

---

## 🚀 How to Run This Project

1. Create database in PostgreSQL
2. Run `schema.sql`
3. Import CSV files
4. Run business and advanced analysis scripts

---

## 📬 Author

**Devarun Bharadwaj**
MSc Molecular & Cellular Biology  
Transitioning to Data Analytics  
