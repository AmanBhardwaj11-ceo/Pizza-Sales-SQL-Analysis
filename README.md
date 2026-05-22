# 🍕 Pizza Sales Performance Analysis (SQL Server)

## 📌 Project Overview
This project presents a comprehensive, data-driven analysis of a restaurant's pizza sales transactions using *SQL Server (T-SQL)*. The objective was to transform raw operational data into actionable business intelligence, focusing on core financial KPIs, operational efficiency (peak hours), menu optimization (product performance), and supply chain insights (ingredient analysis). 

By structuring the analysis from foundational metrics to advanced analytical queries, this project provides a clear blueprint for stakeholders to optimize staffing, manage inventory, and drive higher revenue.

---

## 💾 Dataset & Database Schema
The dataset consists of a year's worth of pizza sales transactions containing *48,000+ rows*. The relational table structure includes the following columns:

| Column Name | Data Type | Description |
|---|---|---|
| Pizza_id | INT (Primary Key) | Unique identifier for each pizza sold in a line item. |
| Order_id | INT | Unique identifier for the overall customer order. |
| Pizza_name_id | VARCHAR | Short standardized code for the specific pizza type. |
| Quantity | INT | Total number of that specific pizza ordered in the line item. |
| Order_date | DATE | Date when the order was placed. |
| Order_time | TIME | Time when the order was placed. |
| Unit_price | DECIMAL(10,2) | Price per individual pizza. |
| Total_price | DECIMAL(10,2) | Calculated as Quantity * Unit_price. |
| Pizza_category | VARCHAR | Category classification (Classic, Veggie, Supreme, Chicken). |
| Pizza_size | VARCHAR | Size of the pizza (S, M, L, XL, XXL). |
| Pizza_ingredients| VARCHAR | Comma-separated text list of ingredients used. |
| Pizza_name | VARCHAR | Full formal name of the pizza. |

---

## 🛠️ Technical Stack Used
*   *Database Engine:* Microsoft SQL Server
*   *Query Tool:* SQL Server Management Studio (SSMS) 
*   *SQL Concepts Applied:* Common Table Expressions (CTEs), Window Functions (DENSE_RANK, LAG), Aggregations, String Manipulation (STRING_SPLIT, CROSS APPLY), and Data Type Casting.

---

## 📈 Key Business Insights & Findings

### 1. Financial Performance (Executive Summary)
*   *Average Order Value (AOV):* The business maintains a healthy baseline order average. Strategies focusing on bundling or upselling sides during checkout could further maximize this metric.
*   *Category Dominance:* The *Classic* category consistently drives the highest volume of transactions, making it the bedrock of the menu's stability.

### 2. Operational Efficiency & Staffing Optimization
*   *The Rush Hour Bottleneck:* Order volume sharply spikes between *6:00 PM and 9:00 PM*. 
    *   Recommendation: Increase kitchen staffing allocations by 25% during this tight 3-hour evening window to reduce order fulfillment delays and improve customer satisfaction.
*   *Weekly Trends:* Peak order volumes concentrate heavily on *Fridays and Saturdays*, highlighting the ideal timeline for running weekend promotions.

### 3. Menu & Inventory Intelligence
*   *Size Preferences:* Large (*L) size pizzas account for nearly **45% of total sales volume*, reinforcing that customers perceive larger options as higher value-for-money.
*   *Ingredient Demand & Procurement:* Parsing out the Pizza_ingredients text revealed that *Cheese and Garlic* are the most frequently used items across the entire menu. 
    *   Recommendation: Supply chain managers can leverage these high-frequency counts to negotiate bulk-pricing contracts with raw material vendors, directly cutting food costs.

---
## 📂 Repository Structure

The project directory is structured modularly to isolate data cleaning, core analysis, visual assets, and raw data files:

```text
├── 📁 Data_Cleaning&Transformation/
│   ├── 📄 Cleaning_data.sql                # SQL scripts handling missing data, type casting, and validation
│   └── 📄 creation&Transform_table.sql      # Schema definitions, primary/foreign keys, and staging setups
│
├── 📁 datasets/
│   ├── 📊 pizza_sales.csv                   # Raw transnational dataset utilized for the project
│                     
│
├── 📁 documents/
│   ├── 🖼️ Category_analysis.png             # Visualizations displaying performance across pizza categories
│   ├── 🖼️ Cumulative_analysis.png           # Revenue running totals and growth accumulation plots
│   ├── 🖼️ Metrics_analysis.png              # Charts summarizing core KPIs (AOV, Total Sales, Order Volumes)
│   ├── 🖼️ Slots_analysis.png                # Time-series plots showing peak ordering hours and days
│   
│
├── 📁 scripts/
│   ├── 📄 Advanced_Analysis.sql            # Complex queries involving advanced window functions and multi-level logic
│   ├── 📄 Change-over-time_analysis.sql    # Time-series calculations tracking performance over days, weeks, and months
│   ├── 📄 Data_segmentation analysis.sql   # Customer behavior breakdowns based on transaction volumes and group orders
│   ├── 📄 Magnitude_analysis.sql           # Identifying high-volume revenue drivers versus micro-transactions
│   ├── 📄 Measures_analysis.sql            # Core foundational aggregation scripts (Calculations for standard metrics)
│   ├── 📄 Ranking_analysis.sql             # SQL scripts focusing on Top/Bottom N product performers
│   
└── 📄 README.md                            # Comprehensive project documentation
