# BotaniCo Sales Analysis : 2022 - 2024

![dashboard to show all metrics.](https://imgur.com/KES4BRc.png)

Analyzing BotaniCo Sales from 2022 to 2024. Interactive Power BI Dashboard can be found [here](https://github.com/michaelomi/BotaniCo_Sales_Analysis/blob/main/BotaniCo_Dashboard.pbix).

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

### Highlights
- The first year (2022) recorded the highest revenue and gross profit, totaling $13.5 million and $5.41 million, respectively.
- November 2022 was the month with the highest revenue and gross profit, achieving $1.38 million and $543,000.
- The Large Outdoor plant category had the highest sales and revenue figures.
- **Veronica Prostrata** generated the most revenue, while **Piper Dilatatum** had the highest sales volume.
- Customers from China contributed the most to our revenue, accounting for 33.7% of the total.
- **Labadie Group** leads in customer lifetime value.

Seasonality:
- Excluding 2024, as it does not represent a full year of data, November-December rank among the top four months for revenue, while March-April-May are in the top five.

### Technical Analysis:

In this analysis, I utilized Microsoft SQL Server Management Studio (SSMS) to create the **BotaniCo_Analysis** database and import datasets for **Accounts**, **Sales**, and **Products**. I performed data cleaning by removing duplicates and handling NULL values, then created a consolidated **Customers** table and transformed the **Sales** table into a **Fact_Sales** table. I calculated key metrics such as **gross profit**, analyzed **sales seasonality**, and segmented customers based on **revenue**. Additionally, I evaluated **customer lifetime value (CLTV)** and retention, while summarizing customer counts by month for 2023.

All SQL queries are [here](https://github.com/michaelomi/BotaniCo_Sales_Analysis/blob/main/BotaniCo_Analysis.sql).

Here is a simple example of an SQL query:

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



