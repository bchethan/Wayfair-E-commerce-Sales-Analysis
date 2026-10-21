# Wayfair E-Commerce Sales Analysis

## Table of Contents

1. [Project Overview](#project-overview)
2. [Objectives](#objectives)
3. [Tools & Technologies](#tools--technologies)
4. [Dataset Summary](#dataset-summary)
5. [Project Workflow](#project-workflow)
   - [Data Cleaning & Exploratory Data Analysis](#1-data-cleaning--exploratory-data-analysis)
   - [SQL Analysis](#2-sql-analysis)
   - [Power BI Dashboard](#3-power-bi-dashboard)
6. [Key Findings](#key-findings)
7. [Business Recommendations](#business-recommendations)
8. [Project Structure](#project-structure)
9. [How to Run the Project](#how-to-run-the-project)
10. [Skills Demonstrated](#skills-demonstrated)
11. [Conclusion](#conclusion)

---

## Project Overview

This project analyzes e-commerce sales data from a Wayfair dataset to understand sales performance, customer acquisition, product demand, and order outcomes.

Using **Python, MySQL, and Power BI**, the project covers data cleaning, exploratory analysis, SQL-based business analysis, and interactive dashboard development to generate actionable business insights.

## Objectives

- Analyze revenue by product category and customer acquisition channel.
- Compare monthly revenue between 2024 and 2025.
- Identify best-selling products by units sold and revenue.
- Evaluate product category return and cancellation rates.
- Calculate Average Order Value (AOV).
- Build an interactive Power BI dashboard to communicate key findings.

## Tools & Technologies

- **Python:** Data cleaning and exploratory data analysis
- **Pandas:** Data manipulation and missing-value handling
- **MySQL:** Data querying and business analysis
- **Power BI:** Interactive dashboard and data visualization
- **Jupyter Notebook:** Python analysis and documentation

## Dataset Summary

The project uses four CSV files containing customer, order, product, and transaction data.

| Dataset | Description |
|---|---|
| `customers.csv` | Customer information, signup dates, states, and acquisition channels |
| `orders.csv` | Order dates, order status, payment methods, discount codes, and shipping fees |
| `order_items.csv` | Product IDs, quantities, unit prices, and discount amounts |
| `products.csv` | Product names, categories, list prices, and unit costs |

- **CSV Files:** 4
- **Total Rows:** 28,543 across all files
- **Total Columns:** 21 across all files
- **Missing Values:** 8,033 initially identified across `unit_price` and `discount_code`
- **Duplicates:** 38 duplicate rows reported in `orders.csv`

## Project Workflow

### 1. Data Cleaning & Exploratory Data Analysis

Python and Pandas were used to inspect the datasets and prepare them for analysis.

Key tasks:
- Examined dataset structure using `info()` and `describe()`.
- Identified missing values and duplicate records.
- Filled missing unit prices using the corresponding product list prices.
- Standardized inconsistent product category names.
- Replaced blank discount codes with `No Discount`.
- Prepared the cleaned data for MySQL analysis.

### 2. SQL Analysis

MySQL was used to investigate business questions using joins, aggregations, Common Table Expressions (CTEs), conditional aggregation, and window functions.

The analysis included:

1. **Revenue by Acquisition Channel:** Compared customers, orders, orders per customer, and total purchase value across acquisition channels.
2. **Category Performance:** Evaluated units sold and revenue by product category.
3. **Order Status Analysis:** Examined returned and canceled orders across categories.
4. **Year-over-Year Comparison:** Compared monthly revenue between 2024 and 2025.
5. **Best-Selling Products:** Ranked products by units sold and revenue.
6. **Return and Cancellation Rates:** Calculated category-level return and cancellation percentages.
7. **Average Order Value:** Calculated average order value using order-level sales.

### 3. Power BI Dashboard

An interactive dashboard was developed to present the results visually.

**Key Performance Indicators (KPIs):**
- Total Customers
- Total Revenue
- Average Order Value
- Return Rate
- Cancellation Rate

**Dashboard Visualizations:**
- Revenue by state
- Revenue by acquisition channel
- Revenue by product category
- Revenue by payment method
- Revenue trends by year and month

**Interactive Filters:**
- Discount Code
- Payment Method
- Order Status
- Acquisition Channel

## Key Findings

- **Category Performance:** Furniture generated the highest reported category revenue despite having the lowest unit sales among the eight categories.
- **Acquisition Channels:** Referral recorded 5.29 orders per customer, while Paid Social recorded 2.98 and Affiliate recorded 3.40.
- **Returns:** Furniture showed the highest reported category return rate at 11.77%.
- **Cancellations:** Bath recorded the highest reported category cancellation rate at 4.43%.
- **Sales Trends:** Monthly revenue was compared between 2024 and 2025 to examine changes in sales performance.
- **Average Order Value:** The project report recorded an AOV of 220.21.

## Business Recommendations

- **Reduce Returns:** Investigate Furniture first to identify potential product quality, description, or customer expectation issues.
- **Reduce Cancellations:** Examine Bath and other categories with elevated cancellation rates to identify potential operational problems.
- **Optimize Acquisition Channels:** Investigate repeat purchases and customer value for Paid Social and Affiliate before changing marketing budgets.
- **Improve Category Sales:** Investigate low unit sales in Furniture, Lighting, Outdoor, Bath, and Storage.
- **Promote Best-Selling Products:** Use product-level sales and revenue analysis to guide product positioning and marketing campaigns.

## Project Structure

```text
Wayfair-Ecommerce-Sales-Analysis/
│
├── customers.csv
├── orders.csv
├── order_items.csv
├── products.csv
│
├── WayFair E-Commerce Sales Analysis.ipynb
├── sales_analysis.sql
├── ecommerce_sales_analysis.pbix
│
└── README.md
```

## How to Run the Project

### Prerequisites

- Python 3.x
- Jupyter Notebook
- Pandas
- MySQL
- Power BI Desktop

### Steps

1. Clone or download this repository.
2. Install the required Python dependencies:

   ```bash
   pip install pandas jupyter mysql-connector-python
   ```

3. Place the four CSV files in the appropriate project directory.
4. Open the Jupyter Notebook and run the data inspection and cleaning steps.
5. Configure your local MySQL connection and load the cleaned tables into the database.
6. Execute the queries in `sales_analysis.sql` to reproduce the business analysis.
7. Open the `.pbix` file in Power BI Desktop and configure the data source if required.

**Important:** Keep database credentials outside the notebook and never commit passwords or other secrets to GitHub.

## Skills Demonstrated

- Data cleaning and preprocessing
- Exploratory data analysis
- SQL joins and aggregations
- CTEs and window functions
- Revenue and KPI analysis
- Customer acquisition channel analysis
- Data visualization and dashboard development
- Business insight generation and recommendations

## Conclusion

This project demonstrates an end-to-end data analytics workflow, from preparing raw e-commerce data to querying business metrics and presenting findings in an interactive dashboard.

It highlights how Python, SQL, and Power BI can be used together to analyze sales performance, identify operational issues, and support data-driven business decisions.


## Author

**Chethan Reddy**

GitHub: [bchethan](https://github.com/bchethan)
