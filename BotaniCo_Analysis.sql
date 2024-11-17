CREATE DATABASE BotaniCo_Analysis;
--Then Import the Dataset

--THREE TABLES IN THIS DATA
SELECT*
FROM Accounts;

SELECT*
FROM Sales;

SELECT*
FROM Products;

--DATA CLEANING
--CHECKING FOR DUPLICATES IN ACCOUNTS TABLE 

WITH Duplicate_CTE AS
   (SELECT
      *,
      ROW_NUMBER() OVER(PARTITION BY country_code, Account, Master_id,
	                                 Account_id,latitude2,longitude,country2,
									 Postal_code,street_name,Street_number
						ORDER BY country_code, Account, Master_id,
	                             Account_id,latitude2,longitude,country2,
							     Postal_code,street_name,Street_number) AS row_num
    FROM Accounts) 
SELECT*
FROM 
   Duplicate_CTE
WHERE 
   row_num > 1; -- No duplicates found

/* HANDLING NULL VALUES BY REMOVING NULL DATA FROM PRIMARY KEY(Account_id) ON THE ACCOUNTS TABLE */
DELETE FROM Accounts
WHERE Account_id IS NULL;

/* FORMATING ACCOUNTS TABLE TO 620 ROWS INSTEAD of 948, EACH NAME TO ONE Id AND CREATING A NEW TABLE */
WITH Duplicate_Cte as (
                       SELECT Account as Customer, country_code as Country_Code, Account_id as Customer_Id, 
                              latitude2 as Latitude, longitude as Longtitude, country2 as Country,
                              ROW_NUMBER() over(partition by Account order by Account) as Row_Num
                       FROM Accounts) 
select*
INTO Customers
from Duplicate_Cte
where Row_Num = 1;

ALTER TABLE Customers
Drop Column Row_Num;

SELECT*
FROM Customers;

/* SALES TABLE HAS 2,440 ROWS. NOW WE CREATE A NEW TABLE THAT HAS SAME DATA BUT WITH CHANGES TO THE
   Account_id COLUMN AND RECREATING IT AS Customer_ID */
SELECT 
      Product_id AS Product_Id, Sales_USD AS Revenue, quantity AS Quantity, 
	  Price_USD AS Unit_Price, COGS_USD AS Cost_of_Goods, Date_Time, Customer_Id
INTO 
      Fact_Sales
FROM 
      Sales S
JOIN 
      Accounts A
ON 
      S.Account_id = A.Account_id
JOIN 
      Customers C
ON 
      C.Customer = A.Account;

SELECT*
FROM Fact_Sales;

DROP TABLE Sales

DROP TABLE Accounts

SELECT*
FROM Customers; -- This Table replaced Accounts Table

SELECT*
FROM Sales; -- RENAME Fact_Sales Table as Sales

-- Correcting Column Header
ALTER TABLE Products
ADD Product_Type varchar(50);

UPDATE Products
SET Product_Type = Produt_Type;

ALTER TABLE Products
DROP COLUMN Produt_Type;

SELECT*
FROM Products; -- Already Checked for Duplicates, Primary Key is Distinct

/* CALCULATING KEY METRICS
   Adding Gross Profit column to Sales table */
ALTER TABLE Sales
ADD Gross_Profit DECIMAL(18, 2);

UPDATE Sales
SET Gross_Profit = Revenue - Cost_of_Goods;

-- Aggregation of Revenue and Gross Profit by Year
SELECT
    YEAR(Date_Time) Year,
	SUM(Revenue) AS Total_Revenue,
	SUM(Gross_Profit) as Gross_Profit
FROM 
    Sales
GROUP BY
    YEAR(Date_Time)
ORDER BY
	Total_Revenue DESC;

-- Monthly aggregation of Revenue and Gross Profit
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

-- SALES SEASONALITY ANALYSIS excluding 2024 because it's not a full year
SELECT
    FORMAT(Date_Time,'MMMM') AS Month,
    SUM(Revenue) AS Monthly_Revenue,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) AS Revenue_Rank
FROM 
    Sales
WHERE
    YEAR(Date_Time) != 2024
GROUP BY 
    FORMAT(Date_Time,'MMMM');

-- Revenue and Gross Profit by Product Size and Category
SELECT *
FROM Products;

SELECT 
   P.Product_Size,
   P.Produt_Type,
   COUNT(S.Revenue) Purchase_Count,
   SUM(S.Revenue) Revenue,
   SUM(S.Gross_Profit) Gross_Profit
FROM 
   Sales S
JOIN 
   Products P
ON 
   S.Product_id = P.Product_Name_id
GROUP BY
   P.Product_Size,
   P.Produt_Type
ORDER BY
   Revenue DESC;

-- Top Products based on Quantity Sold and Revenue
SELECT TOP 5
   P.Product_Name,
   SUM(quantity) Quantity,
   SUM(S.Revenue) Revenue
FROM 
   Sales S
JOIN 
   Products P
ON 
   S.Product_id = P.Product_Name_id
GROUP BY
   P.Product_Name
ORDER BY
   Quantity DESC;

--CUSTOMER SEGMENTATION
/* Quantity, Revenue, and Gross Profit by customers
   Ordering in descending order of Revenue */
SELECT 
   C.Customer AS Customer_Name,
   SUM(S.Quantity) Quantity,
   SUM(S.Revenue) Revenue,
   SUM(S.Gross_Profit) Gross_Profit
FROM 
   Sales S
JOIN 
   Customers C
ON 
   S.Customer_Id = C.Customer_Id
GROUP BY
   C.Customer
ORDER BY
   Revenue DESC;

--Customers Country by Revenue and %
SELECT 
   C.Country,
   SUM(S.Revenue) Revenue,
   ROUND((SUM(S.Revenue) * 100.0) / SUM(SUM(S.Revenue)) OVER (),1) AS PercentageOfTotal
FROM 
   Sales S
JOIN 
   Customers C
ON 
   S.Customer_Id = C.Customer_Id
GROUP BY
   C.Country
ORDER BY
   Revenue DESC;

-- Segmenting Customers by Revenue
SELECT 
   C.Customer AS Customer_Name,
   SUM(S.Revenue) Revenue,
   CASE 
       WHEN SUM(S.Revenue) > 100000 THEN 'High'
	   WHEN SUM(S.Revenue) > 50000 THEN 'Medium'
	   ELSE 'Small'
   END AS Spend_Segment
FROM 
   Sales S
JOIN 
   Customers C
ON 
   S.Customer_Id = C.Customer_Id
GROUP BY
   C.Customer
ORDER BY
   Revenue DESC;

-- Calculating Customer Lifetime Value (CLTV)
SELECT 
    C.Customer AS Customer_Name,
    COUNT(S.Revenue) AS Purchase_Frequency,
    ROUND(AVG(S.Revenue),2) AS Avg_Purchase_Value,
	ROUND(SUM(S.Revenue/S.Quantity),2) AS Average_Order_Value,
    (COUNT(S.Revenue) * AVG(S.Revenue)) AS CLTV
FROM 
   Sales S
JOIN 
   Customers C
ON 
   S.Customer_Id = C.Customer_Id
GROUP BY
   C.Customer
ORDER BY
   CLTV DESC;

-- Customer Retention Analysis
SELECT 
   C.Customer,
   COUNT(DISTINCT FORMAT(Date_Time, '%Y-%m-%d')) AS Active_Days,
   CASE 
        WHEN COUNT(DISTINCT FORMAT(Date_Time, '%Y-%m-%d')) >= 4 THEN 'Loyal'
        WHEN COUNT(DISTINCT FORMAT(Date_Time, '%Y-%m-%d')) >= 2 THEN 'Occasional'
        ELSE 'New'
    END AS Customer_Type,
	CASE 
        WHEN COUNT(DISTINCT FORMAT(Date_Time, '%Y-%m-%d')) > 1 THEN 'Returning'
		ELSE 'No Return'
	END AS Customer_Return,
	ROUND(SUM(S.Revenue/S.Quantity),2) AS Average_Order_Value
INTO 
    #Customer_Segmentation
FROM 
   Sales S
JOIN 
   Customers C
ON 
   S.Customer_Id = C.Customer_Id
GROUP BY
   C.Customer
ORDER BY
   Active_Days DESC;

--Created a temporary table above, used it to add columns to the Customers table
SELECT*
FROM #Customer_Segmentation

SELECT*
FROM Customers;

ALTER TABLE Customers
ADD Customer_Type varchar (50)

ALTER TABLE Customers
ADD Customer_Return varchar (50)

UPDATE Customers 
SET Customer_Type = CS.Customer_Type
FROM Customers C
JOIN #Customer_Segmentation CS
ON C.Customer = CS.Customer;

UPDATE Customers 
SET Customer_Return = CS.Customer_Return
FROM Customers C
JOIN #Customer_Segmentation CS
ON C.Customer = CS.Customer; 
--After running this, remove the INTO function from the Customer Retention Retention Analysis

-- TOTAL CUSTOMERS BY MONTH
SELECT
    FORMAT(Date_Time,'MMMM') AS Month,
    COUNT(Customer) Customer_Count
FROM 
    Sales S
JOIN 
    Customers C
ON 
    S.Customer_Id = C.Customer_Id
WHERE 
    YEAR(Date_Time) = 2023
GROUP BY 
    FORMAT(Date_Time,'MMMM')
ORDER BY 
    Customer_Count DESC;