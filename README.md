# Amazon-Counterfeit-Product-Management
A fully normalized relational database system for managing Amazon’s brand protection and counterfeit product tracking lifecycle. Includes schema design, 3NF, EER diagrams, SQL scripts, and data-driven insights with performance queries and risk assessments.

# 🔍 Amazon Counterfeit Product Management Database

📦 **Project Type**: Database Design | SQL Querying | Data Modeling  
🎓 **Course**: ISYS 864 – Data Management for Analytics  
👩‍💻 Author: Padmasree Sappa  
🛠 Tools Used: MySQL, Mockaroo, Excel, SQL, EER Diagrams  

---

## 🧠 Project Overview

Amazon faces major challenges from counterfeit products that damage consumer trust and brand reputation. This project designs and implements a relational database to manage the lifecycle of counterfeit product reporting and resolution. It captures:

- Brand registration & product tracking  
- Complaint management & investigation  
- Enforcement actions (Legal + Operational)  
- Risk assessment dashboards via SQL insights  

The system includes **14 fully normalized tables**, subtype/supertype hierarchies, and advanced SQL queries for real-time analytics and fraud tracking.

---

## 🎯 Key Objectives

1. Model entities related to Amazon’s Brand Protection process  
2. Implement 3NF-compliant schema for brands, products, complaints, and actions  
3. Populate data using Mockaroo and Excel  
4. Extract insights on complaint patterns, resolution efficiency, and fraud hotspots  
5. Enable SQL-based assessment dashboards and KPI reporting

---

## 🧩 Schema Features

- ✅ 14 interrelated tables  
- 📊 Includes subtype tables: Electronics, Clothing, Furniture, Legal & Operational Actions  
- 🔁 EER Diagram and 3NF model  
- 🔐 Primary/Foreign keys and constraints  
- ⚖️ Business rules enforcing brand-product, product-complaint, complaint-investigation, etc.

---

## 📂 Files in This Repository

| File Name | Description |
|-----------|-------------|
| [counterfeit_schema.sql](https://github.com/dsappa7196/Amazon-Counterfeit-Product-Management/blob/main/Amazon_Counterfeit_Database_SQL_Script.sql) | SQL schema to create all 14 normalized tables and Complete code |
| [counterfeit_report.docx](https://github.com/dsappa7196/Amazon-Counterfeit-Product-Management/blob/main/Database%20For%20Counterfiet%20Product%20Management.pdf) | Full project documentation with ERD, queries, and insights |
| [counterfeit_ppt.pptx](https://github.com/dsappa7196/Amazon-Counterfeit-Product-Management/blob/main/ISYS864%20Presentation%202024.pptx) | Slide Deck of Presentation|
| [README.md](./README.md) | This file |

---

## 🔍 Insights Uncovered

### 1️⃣ Fraud-Prone Categories  
- Highest complaint rate: **Clothing** and **Electronics**

### 2️⃣ Seasonal Complaint Trends  
- Peaks around holidays → fraud surges during sales

### 3️⃣ Top Offenders  
- “Lulu Lemonade” & “Real Amazon” triggered 100K+ complaints

### 4️⃣ Risk Product Flag  
- Products with complaint rate >5% & >50 complaints are auto-flagged

### 5️⃣ Enforcement Insights  
- 70% investigation closure rate  
- Only 50% complaint resolution rate  
- Avg. resolution time: 19 days

---

## 📊 Counterfeit KPIs (SQL Results)

| KPI | Value |
|-----|-------|
| High-Risk Product % | 11.76% |
| Resolution Efficiency | 50% |
| Avg. Resolution Time | 19 days |
| Investigation Completion Rate | 70% |
| Top Complaint Brand | Lulu Lemonade |

> These indicators show real business risk and highlight where action is needed in Amazon's ecosystem.

---

## ⚙️ Technologies Used

- SQL (DDL & DML)  
- MySQL Workbench (EERD Modeling)  
- Mockaroo (Data Generation)  
- Excel (Data tweaking & automation)  
- Data Integrity constraints and normalization  

---

## 🧠 What We Learned

- Entity Relationship Design & normalization in real-world applications  
- Complex SQL query building for KPI reporting  
- Fraud detection patterns using relational joins & calculations  
- Importance of database structure in large-scale operations

---

## 🧭 Recommendations

- Add complaint categorization (e.g., counterfeit, defect, delay) for granularity  
- Extend customer profile (age, region) for segmentation analysis  
- Implement triggers for real-time fraud flagging  
- Integrate with Amazon’s Transparency Program APIs  

---

> _“This project illustrates how smart databases don’t just store data — they protect brands, flag risk, and enable real-time decisions.”_
