# Data Analysis Hackathon 2025: E-commerce Sales and Customer Insights

#### **May, 2025** 
#### **By Mr. Jefferson Mwatati**
I designed this hackathon to empower my university learners with hands-on experience in data analysis using tools like Excel, SQL, Python, and Power BI. Learners will analyze an E-commerce Sales and Customer Insights Dataset to uncover trends, answer key business questions, and create actionable insights.

## Introduction
The dataset provides information on sales, customer demographics, and order details. It comprises 12 columns: CustomerID, Gender, Region, Age, ProductName, Category, UnitPrice, Quantity, TotalPrice, ShippingFee, ShippingStatus, and OrderDate. Your task is to analyze this dataset, answer the provided questions, and uncover additional insights.

Dataset source: [E-commerce Sales Analysis Hackathon](https://github.com/jeffersonmwatati/E-commerce-Sales-Analysis-Hackathon/blob/64527b0963ecab250ac30d546b2417a0cdfe6f42/raw-dataset-e-commerce-sales-and-customer-insights-dataset.csv)

**Hackathon Questions**<br/>
 <br/>
***Sales Analysis***<br/>
    1. What are the total sales by region?<br/>
    2. Which product category generates the highest revenue?<br/>
    3. What is the average shipping fee by region?<br/>
    <br/>
***Customer Behaviour***<br/>
    1. How does customer age impact purchasing behavior?<br/>
    2. What is the most popular product by gender?<br/>
    <br/>
***Order Fulfillment***<br/>
    1. What is the order fulfillment rate (delivered vs. returned)?<br/>
    2. Are there any trends in shipping status over time?<br/>
    <br/>

## Data Cleaning Process
**Using Excel** <br/>
I began by renaming the dataset to a standardized name, **"ecommerce"**, for consistency. Next, I renamed the columns to remove spaces and ensure they followed a uniform naming convention. I then checked and corrected the data types of each column, ensuring accuracy. To maintain uniformity, all numerical columns were formatted to remove decimal places.

To handle missing data, I used Excel’s **Filter function** to identify and remove partially empty columns. 

Initially, the dataset contained **1,000 records**. After removing columns with missing values, the final dataset had **810 records**.

**Using Python** <br/>
To ensure data integrity, I checked for duplicate records using Python. The results showed no duplicates in the dataset:
  - **Total records before: 810**
  - **Total records after: 810**
  - **Duplicates removed: 0**

**Using SQL** <br/>
After importing the dataset into a database, I needed to convert the **OrderDate** column from **text** to a **date** format. The rest of the columns already had the correct data types, ensuring smooth data processing.


## SQL Analysis
<p align="left"> <img src="img/01HighestLowestRevenueCategories.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/02YoungestOldestCustomerAge.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/03AverageOrderValuebyAgeGroup.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/04NumberofPurchasesbyAgeGroup.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/05PurchaseDistributionbyAgeGroupandCategory.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/06ProductPurchasesbyGender.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/07TopPurchasedProductbyGender.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/08OrderFulfillmentDeliveryPerformanceAnalysis.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/09MostExpensiveCheapestProducts.PNG" alt="SQL Analysis screenshot"> </p>

<p align="left"> <img src="img/10TotalProductsCategoriesOverview.PNG" alt="SQL Analysis screenshot"> </p>




## Python Analysis

<p align="left"> <img src="img/percentageoftotalsalesbygender.PNG" alt="Percentage of Total Sales by Gender"> </p>

<p align="left"> <img src="img/percentageoftotalsalesbycategory.PNG" alt="Percentage of Total Sales by Category"> </p>

<p align="left"> <img src="img/percentageoftotalsalesbyproductname.PNG" alt="Percentage of total sales by productname"> </p>

<p align="left"> <img src="img/percentageoftotalsalesbyshippingstatus.PNG" alt="Percentage of total sales by shipping status"> </p>

<p align="left"> <img src="img/shippingstatustrends.PNG" alt="Shipping status trends"> </p>

<p align="left"> <img src="img/monthlysalestrend.PNG" alt="Monthly sales trend"> </p>

<p align="left"> <img src="img/salesdistributionbyregion.PNG" alt="Sales distribution by region"> </p>

<p align="left"> <img src="img/salesdistributionbyproductcategory.PNG" alt="Sales distribution by product category"> </p>

<p align="left"> <img src="img/correlationbetweenageandtotalpurchaseamount.PNG" alt="Correlation between age and total purchase amount"> </p>





## Power BI Dashboard

<p align="left"> <img src="img/PowerBI-Dashboard02.PNG" alt="PowerBI Dashboard"> </p>

<p align="left"> <img src="img/PowerBI-Dashboard03.PNG" alt="PowerBI Dashboard"> </p>

<p align="left"> <img src="img/PowerBI-Dashboard04.PNG" alt="PowerBI Dashboard"> </p>

## Conclusion


