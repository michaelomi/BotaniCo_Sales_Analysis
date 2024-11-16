# BotaniCo Sales Analysis : 2022 - 2024

![dashboard to show all metrics.](https://imgur.com/KES4BRc.png)

Analyzing BotaniCo Sales from 2022 to 2024. Interactive Dashboard [here](https://github.com/michaelomi/BotaniCo_Sales_Analysis/blob/main/BotaniCo_Dashboard.pbix).

# Table of Contents
  <a id = "table_of_contents"></a><br>
- [Project Summary](#project-summary)
- [Part 1: Data Analysis (SQL)](#data-analysis-sql)
- [Part 2: Visualizations (Power BI)](#visualizations-power-bi)
- [Part 3: Recommendations & Next Steps](#recommendations-next-steps)
- [Addendum: Data Cleaning Notes](#data-cleaning-notes)

---

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

---

<a id='data-analysis-sql'></a>
## Part 1: Data Analysis (SQL)
[(Back to Table of Contents)](#table_of_contents)

### Highlights
- First Year (2022) saw the highest revenue and gross profit at $13.5M and $5.41M respectively.
- November 2022 is the month with highest revenue and gross profit ($1.38M and $543k).
- Large Outdoor plant category are the highest purchased, also top on revenue.
- **Veronica Prostrata** is the product with highest revenue while **Piper Dilatatum** has the most quantity sold.
- Customers from China are the top revenue country amounting 33.7% of our total revenue.

Seasonality:
- Excluding 2024 because it's not a full year in the data; November-December are among the the Top 4 ranked months by revenue, March-April-May are in the Top 5.

### Technical Analysis:

I used Microsoft SQL Server via SQL Server Management Studio (SSMS) for this analysis. I used Data Manipulation and Definition Languages to query, modify, and define the data. Such as aggregation functions, window functions, joins, filtering, CASE expressions, common table expressions (CTEs), and tempoarary tables.

#### Example SQL Query
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

|Year |	Month	| Total_Revenue | Gross_Profit  |
|:----|:-----:| :------------:| :------------:|
|2022 | Nov	  | 1383639.02	  | 543093.07     |
|2023	| Apr	  | 1342504.86	  | 531972.38     |
|2023	| Mar	  | 1194088.05	  | 482197.13     |
|2022	| Jan	  | 1193470.25	  | 468952.34     |
|2023	| Nov	  | 1191950.57	  | 499429.63     |



