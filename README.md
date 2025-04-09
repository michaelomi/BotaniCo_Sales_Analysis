# BotaniCo Sales Analysis : 2022 - 2024

![dashboard to show all metrics.](https://imgur.com/frzuzox.png)

Interactive Power BI Dashboard can be found [here](https://app.powerbi.com/view?r=eyJrIjoiYTIxMzZkYjktYTYwOC00MWZjLWEyODAtOWE0MjlkNDlhM2E0IiwidCI6IjA1ODU3NTFmLTRiNDctNDUzOS04YmMzLWJmODNlMmVlMWQzZiJ9)

# Table of Contents
  <a id = "table_of_contents"></a><br>
- [Project Summary](#project-summary)
- [Part 1: Data Analysis (SQL)](#data-analysis-sql)
- [Part 2: Visualizations (Power BI)](#visualizations-power-bi)
- [Part 3: Recommendations & Next Steps](#recommendations-next-steps)
- [Addendum: Data Cleaning Notes](#data-cleaning-notes)

<a id ="project-summary"></a><br>
## Project Summary
[(Back to Table of Contents)](#table_of_contents)

BotaniCo is a fictional company specializing in organic products. This project analyzes sales trends, customer behavior, and product performance, leveraging data from the following tables:
1. **Accounts**: Contains customer information.
2. **Products**: Catalog of products sold.
3. **Sales**: Includes details like sales, quantity, unit price, and cost of goods sold.

Key objectives include:
- Understanding sales growth and seasonal trends.
- Identifying high-performing products and customer segments.
- Recommending actionable business strategies.

Here is the Entity Relationship Diagram (ERD) after various Data Manipulation and Definition:

![Entity Relationship Diagram](https://imgur.com/O7C2fHt.png)

<a id='data-analysis-sql'></a>
## Part 1: Data Analysis (SQL)
[(Back to Table of Contents)](#table_of_contents)

### 🚀 Highlights
- The first year (2022) recorded the highest revenue and gross profit, totaling $13.5 million and $5.41 million, respectively.
- November 2022 was the month with the highest revenue and gross profit, achieving $1.38 million and $543,000.
- The Large Outdoor plant category had the highest sales and revenue figures.
- **Veronica Prostrata** generated the most revenue, while **Piper Dilatatum** had the highest sales volume.
- Customers from China contributed the most to our revenue, accounting for 33.7% of the total.
- **Labadie Group** leads in customer lifetime value.

📅 Seasonality:
- Excluding 2024, as it does not represent a full year of data, November-December rank among the top four months for revenue, while March-April-May are in the top five.

### 🔧 Technical Analysis:

In this analysis, I utilized Microsoft SQL Server Management Studio (SSMS) to create the **BotaniCo_Analysis** database and import datasets for **Accounts**, **Sales**, and **Products**. I performed data cleaning by removing duplicates and handling NULL values, then created a consolidated **Customers** table and transformed the **Sales** table into a **Fact_Sales** table. I calculated key metrics such as **gross profit**, analyzed **sales seasonality**, and segmented customers based on **revenue**. Additionally, I evaluated **customer lifetime value (CLTV)** and retention, while summarizing customer counts by month for 2023.

All SQL queries are [here](https://github.com/michaelomi/BotaniCo_Sales_Analysis/blob/main/BotaniCo_Analysis.sql).

📊 Here is a simple example of an SQL query:

This query retrieves the top five months by total revenue, displaying the year, month, total revenue, and gross profit from the Sales table.

```sql
SELECT TOP 5
    YEAR(Date_Time) Year,
	FORMAT(Date_Time,'MMM') Month,
	SUM(Revenue) AS Total_Revenue,
	SUM(Gross_Profit) as Gross_Profit
FROM 
    Sales
GROUP BY
    YEAR(Date_Time),
	FORMAT(Date_Time,'MMM')
ORDER BY
	Total_Revenue DESC;
```

Result;

|Year   | Month   | Total_Revenue | Gross_Profit  |
|:------|:-------:| :------------:| :------------:|
|2022   | Nov	  | 1383639.02	  | 543093.07     |
|2023	| Apr	  | 1342504.86	  | 531972.38     |
|2023	| Mar	  | 1194088.05	  | 482197.13     |
|2022	| Jan	  | 1193470.25	  | 468952.34     |
|2023	| Nov	  | 1191950.57	  | 499429.63     |

<a id='visualizations-power-bi'></a>
## Part 2: Visualizations (Power BI)
[(Back to Table of Contents)](#table_of_contents)

### 📊 **Summary of Insights**  

🛒 **Sales Performance**  
- **Year-to-Date (YTD) vs Previous Year-to-Date (PYTD)** Revenue for 2023 was **-3.94%**, reflecting a decline in growth compared to previous year.
- **Gross Profit Percentage (GP%)** for 2023 was **39.62%**, a **-1.15% decrease** compared to **40.09%** in the previous year.  
- The most significant **YTD vs PYTD revenue increase** occurred in **June 2023**, while **February 2023** saw the sharpest decline.  
- **China** ranked the lowest in YTD vs PYTD revenue performance by country for 2023.  

🌱 **Product Analysis**  
- The **Small Outdoor Plants** category generated the **highest revenue** for 2023, outperforming other product categories.  

👥 **Customer Behavior**  
- **Total customers** increased by **0.41%** in 2023, with **loyal customers** making up **52%** of the customer base.  
- The **return rate** increased slightly by **0.04%**, peaking in **September 2023** at **98.65%**.  
- The highest influx of customers occurred in **April 2023**.  

🏆 **Top Customers**  
- **Moore-Rolfson** had the **highest average order value** at **1,075.47**.  
- **Labadie Group** led in both **total orders** and **total revenue** for 2023.  

📈 This analysis provides actionable insights into revenue trends, product performance, customer behavior, and top contributors. These findings form a strategic foundation for future decision-making.  

This report provides actionable insights, empowering businesses to make data-driven decisions across sales, customer retention, and profitability.

### Technical Analysis:

In this section, I utilized Power BI for data visualization, while SQL was used to create the dataset. The Power BI dashboard includes various visuals such as line and column graphs, bar charts, and tables, with filters applied for metrics like revenue, gross profit, and quantity.

Here’s a preview of the Power BI dashboard that showcases the insights and metrics from this analysis:

![Dashboard Page 1](https://imgur.com/frzuzox.png)
![Dashboard Page 2](https://imgur.com/B2JcSJf.png)
![Dashboard Page 3](https://imgur.com/tClYTeD.png)

Explore the interactive Power BI dashboard to view key metrics such as revenue, gross profit, and quantity, and see how they impact products and customer trends. Filter data by year to gain deeper insights [here](https://app.powerbi.com/view?r=eyJrIjoiYTIxMzZkYjktYTYwOC00MWZjLWEyODAtOWE0MjlkNDlhM2E0IiwidCI6IjA1ODU3NTFmLTRiNDctNDUzOS04YmMzLWJmODNlMmVlMWQzZiJ9)

<a id='recommendations-next-steps'></a>
## Part 3: Recommendations & Next Steps
[(Back to Table of Contents)](#table_of_contents)

### 📊 Recommendations

1. **Expand High-Performing Product Lines**
   - Focus on the categories that are driving the most revenue, such as **Small Outdoor Plants** and **Veronica Prostrata**.
   - Further investment in **Large Outdoor Plants** can help maintain and grow the revenue generated from this high-performing category.

2. **Enhance Customer Retention**
   - Implement **loyalty programs** targeting the top **10% of customers**. This could involve providing special offers and rewards for repeat purchases, particularly for high-value customers like **Labadie Group**.
   - Investigate the reasons behind the **increase in return rates** in 2023, especially in September, and address the underlying causes to reduce returns and improve retention.

3. **Improve Marketing Efficiency**
   - Optimize marketing campaigns around seasonal trends, especially during **November-December** when revenue peaks.
   - Focus on **March-April-May**, which are in the top five months for revenue, by launching campaigns targeted at customers who are most likely to purchase during these months.
   - Leverage the **top countries** contributing to revenue, particularly **China**, to expand market share through targeted regional campaigns.


### 🚀 Next Steps

1. **Integrate Financial Metrics**
   - Integrate more **financial metrics** like **profit margins** into the analysis to refine recommendations. This will help optimize product pricing, identify cost-effective products, and improve profitability.
   - Use metrics such as **Customer Lifetime Value (CLTV)** to assess the long-term impact of customer relationships on overall business growth.

2. **Explore Supply Chain Data**
   - Dive into **supply chain data** to identify areas where cost-saving opportunities exist. Streamlining logistics, reducing stock-outs, and improving supplier relationships could further enhance profitability and operational efficiency.

3. **Monitor Customer Return Behavior**
   - Conduct a deeper investigation into the **return rate**, especially during peak return months like **September**, to understand whether return policies are contributing to the high return rate. Analyzing this data could help in designing better return policies or improving product quality to reduce returns.

These recommendations are geared toward driving revenue growth, improving customer satisfaction, and ensuring long-term sustainability. By focusing on high-performing products, enhancing customer retention, and optimizing marketing campaigns, BotaniCo can unlock new avenues for success.

<a id='data-cleaning-notes'></a>
## 🔍 Addendum: Data Cleaning Notes
[(Back to Table of Contents)](#table_of_contents)

In preparing the dataset for analysis, several data cleaning steps were performed to ensure accuracy and consistency:

1. **Accounts Table Cleaning**
   - Initially, the **Accounts** table contained **1,745 rows**. After removing **null values** from the primary key, the row count was reduced to **948**.
   - Further cleaning was done by **properly formatting the ID column**, ensuring it was unique for each customer. This reduced the row count to **620**.
   - The **Accounts** table was then **renamed to Customers** in SQL to reflect its role in the analysis as a customer-centric table.

2. **Foreign Keys**
   - The **Sales** table’s foreign keys were updated to match the newly cleaned **Customers** table, ensuring proper relational integrity across the database.

3. **Product Table**
   - A minor correction was made to the **Product Table**, where the **column header** was updated to ensure clarity and consistency across all tables.

By addressing these data quality issues, the dataset is now structured for accurate and reliable analysis, ensuring the integrity of the insights derived from the Power BI dashboard and SQL queries.
