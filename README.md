# 🛒 E-Commerce Sales Analysis using MySQL

A SQL-based E-Commerce Sales Analysis project focused on understanding customer behavior, product performance, pricing, discounts, sales, and delivery patterns.

The analysis was performed on **249,995 sales records** and **40,000 customer records** using MySQL.

---

## 🎯 Project Objective

To use SQL to answer practical business questions and identify patterns that can support decisions related to:

- Customer segmentation and purchasing behavior
- Product and brand performance
- Pricing and discount strategies
- Sales and payment patterns
- Returns and delivery performance

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data analysis |
| MySQL Workbench | Query development & execution |
| SQL | Business analysis |
| GitHub | Project documentation |

---

## 🗄️ Database Structure

The project contains two related tables connected using `Customer_ID`.

| Table | Rows | Columns | Primary Key | Foreign Key |
|---|---:|---:|---|---|
| `customers` | 40,000 | 9 | `Customer_ID` | — |
| `sales` | 249,995 | 20 | `Order_ID` | `Customer_ID` |

**Relationship:** `customers` 1 → many `sales`

### Customers

| Column | Description |
|---|---|
| Customer_ID | Unique customer ID (PK) |
| Customer_Name | Customer name |
| Gender | Gender |
| Age | Customer age |
| Age_Group | Age category |
| City | Customer city |
| State | Customer state |
| Registration_Date | Registration date |
| Customer_Tier | Customer segment |

### Sales

| Column | Description |
|---|---|
| Order_ID | Unique order ID (PK) |
| Customer_ID | Customer ID (FK) |
| Product_Name | Purchased product |
| Category | Product category |
| Brand | Product brand |
| Original_Price | Original price |
| Discount_Percent | Discount percentage |
| Discount_Amount | Discount amount |
| Selling_Price | Selling price |
| Order_Date | Order date |
| Order_Time | Order time |
| Delivery_Date | Delivery date |
| Quantity | Quantity purchased |
| Unit_Price | Price per unit |
| Shipping_Cost | Shipping cost |
| Coupon_Discount | Coupon discount |
| Total_Amount | Total order amount |
| Payment_Mode | Payment method |
| Order_Status | Order status |
| Rating | Customer rating |

---

## 🔍 Key Business Questions

The project contains **22 business questions**. Some of the key analyses include:

1. Which customer tier has more customers who make repeat purchases?
2. Which brand is purchased most frequently by customer gender?
3. For each category, which brand is purchased most frequently?
4. Which product category has the highest return rate?
5. Which product category takes the longest to be delivered?
6. Do expensive products receive more discounts than lower-priced products?
7. Which products have both high customer ratings and high purchase frequency?
8. Is delivery time associated with customer ratings?

---

## 💡 Key Insights

- **Platinum customers** account for the largest number of orders and repeat purchasers.
- **Puma** has the highest purchase count among female customers, while **Nike** leads among male customers.
- **Books** have the highest return rate at approximately **5.13%**.
- **Sports** has the longest average delivery time at approximately **4.52 days**.
- **Electronics** has the largest gap between average original price and average selling price.
- Products classified as **expensive** receive substantially higher average discounts than lower-priced products in this dataset.
- **UPI** is the most frequently used payment method.
- Average customer ratings are very similar across fast, medium, and slow delivery groups.

---

## 🧠 SQL Concepts Used

- SELECT, WHERE, GROUP BY, ORDER BY
- Aggregate Functions
- INNER JOIN
- CASE WHEN
- CTEs
- Subqueries
- Window Functions & RANK()
- Date & Time Functions
- String Functions
- SQL Views

---

## 📁 Project Files

| File | Description |
|---|---|
| `E-commerce sales project.sql` | SQL queries for the complete analysis |
| `customers.csv` | Customer dataset |
| `sales.zip` | Compressed sales dataset |
| `README.md` | Project documentation |

---

## 📌 Outcome

This project helped me apply SQL to a real-world style dataset and translate business questions into data-driven analysis using relational data, aggregations, CTEs, window functions, subqueries, and views.

### 👩‍💻 Author

**Anupama**  
Aspiring Data Analyst | SQL | Python | Excel | Power BI
