# HouseHoldIncomeUS
# Introduction
🤖 **Advanced SQL Automation and Data Processing**: This project focuses on automating complex data processes using SQL. It includes cleaning, exploring, and automating insights derived from large datasets. The primary dataset used here is related to US Household Income, and automation was implemented to generate faster insights and reduce manual query work.

🔍 Curious about the SQL queries used in this analysis? You can explore them here: [project_sql folder](/project_sql/)

# Background
The goal of this project is to showcase advanced SQL techniques for automating data extraction, cleaning, and exploration processes. The automation allows for quicker data analysis and insights generation, particularly when dealing with large datasets. 

### Key Questions Addressed:
1. **How can SQL automation streamline data cleaning and exploration?**
2. **What insights can be drawn from the US Household Income dataset?**
3. **How can advanced SQL techniques be applied to automate repetitive tasks?**
4. **What patterns and trends can be identified in US Household Income over time?**

# Tools I Used
For this project, the following tools were essential:
- **MySQL:** The core of the project, used for executing and automating advanced queries.
- **Visual Studio Code:** Utilized for writing SQL code in a structured environment.
- **CSV Data (US Household Income):** The primary dataset for analysis and automation.

# The Analysis
This project was broken down into several parts: **data cleaning**, **data exploration**, and **advanced SQL automation** to streamline insights extraction.

### 1. Data Cleaning
The first step involved cleaning the raw data from the US Household Income dataset, which contained several inconsistencies such as missing values and duplicates.

```sql
-- Remove any duplicate entries
DELETE FROM us_household_income
WHERE Row_ID IN (
    SELECT Row_ID
    FROM (
        SELECT Row_ID, 
        ROW_NUMBER() OVER (PARTITION BY Household_ID ORDER BY Household_ID) AS Row_Num
        FROM us_household_income
    ) AS Row_table
    WHERE Row_Num > 1
);
```

This query removes any duplicates in the dataset based on the unique **Household_ID**.

### 2. Filling Missing Data
Some entries in the dataset had missing or incomplete data, which needed to be filled by calculating averages or using similar data points.

```sql
-- Fill missing household income data based on average of similar entries
UPDATE us_household_income t1
JOIN (
    SELECT State, AVG(Household_Income) AS avg_income
    FROM us_household_income
    WHERE Household_Income IS NOT NULL
    GROUP BY State
) t2 ON t1.State = t2.State
SET t1.Household_Income = t2.avg_income
WHERE t1.Household_Income IS NULL;
```

This query fills in missing household income data by calculating the average household income for each state and applying it to the missing entries.

### 3. Exploratory Data Analysis
Once the data was cleaned, it was time to explore the US Household Income dataset to identify trends and patterns.

- **Income Distribution by State**:

```sql
SELECT State, ROUND(AVG(Household_Income), 2) AS Avg_Income
FROM us_household_income
GROUP BY State
ORDER BY Avg_Income DESC;
```

This query provides an overview of the average household income per state, allowing us to identify states with higher and lower average incomes.

- **Income Trend Over Time**:

```sql
SELECT Year, ROUND(AVG(Household_Income), 2) AS Avg_Income
FROM us_household_income
GROUP BY Year
ORDER BY Year;
```

This analysis highlights the trend of average household income over time, helping us understand how income levels have changed historically.

### 4. SQL Automation for Insights
To further streamline the process of generating insights, advanced SQL automation was employed to automate the generation of income statistics and insights on a recurring basis.

- **Automating Income Statistics Generation**:

```sql
CREATE PROCEDURE Generate_Income_Statistics()
BEGIN
    -- Generate statistics for each state
    INSERT INTO income_statistics (State, Avg_Income, Max_Income, Min_Income, Report_Date)
    SELECT State, 
        ROUND(AVG(Household_Income), 2) AS Avg_Income, 
        MAX(Household_Income) AS Max_Income, 
        MIN(Household_Income) AS Min_Income, 
        CURDATE() AS Report_Date
    FROM us_household_income
    GROUP BY State;

    -- Output success message
    SELECT 'Income statistics generated successfully for each state';
END;
```

This stored procedure automatically generates income statistics such as the average, maximum, and minimum income for each state, and logs the report generation date.

- **Scheduled Automation**:

```sql
CREATE EVENT Generate_Statistics_Daily
ON SCHEDULE EVERY 1 DAY
DO
    CALL Generate_Income_Statistics();
```

This event scheduler automates the income statistics generation every day, ensuring that the database always has up-to-date income statistics without manual intervention.

# Additional SQL Queries
To further enhance the automation process, here are two additional advanced SQL queries that could be integrated into this project:

1. **Income Growth Rate Calculation**:

```sql
-- Calculate income growth rate between consecutive years for each state
SELECT State, Year,
    ROUND((Household_Income - LAG(Household_Income) OVER (PARTITION BY State ORDER BY Year)) / LAG(Household_Income) OVER (PARTITION BY State ORDER BY Year) * 100, 2) AS Growth_Rate
FROM us_household_income;
```

This query calculates the year-over-year income growth rate for each state, providing valuable insights into how household incomes are growing or shrinking.

2. **Income Disparity Between States**:

```sql
-- Calculate the income disparity between the highest-income and lowest-income states
WITH State_Income AS (
    SELECT State, AVG(Household_Income) AS Avg_Income
    FROM us_household_income
    GROUP BY State
)
SELECT MAX(Avg_Income) - MIN(Avg_Income) AS Income_Disparity
FROM State_Income;
```

This query calculates the income disparity by finding the difference between the highest and lowest average household incomes across all states.

# What I Learned
This project deepened my understanding of advanced SQL automation and data processing techniques:

🧩 **Automation with SQL Procedures and Events**: I learned how to implement stored procedures and event schedulers to automate data processing and insights generation, reducing manual work.

📊 **Advanced Data Aggregation**: I improved my skills in using complex aggregation techniques to calculate statistics like average income, growth rates, and income disparities.

💡 **Real-World Automation**: I explored how SQL automation can be applied to real-world scenarios, helping businesses maintain up-to-date insights without requiring constant manual intervention.

# Conclusions

### Key Insights:
1. **Income Trends**: The data analysis revealed significant trends in household income across various states and years, providing a clearer picture of income distribution in the US.
2. **Automation Benefits**: SQL automation greatly reduces the time and effort required to generate important insights, making data analysis more efficient and scalable.
3. **Income Disparities**: There are significant disparities in household income between different states, which highlights potential areas of economic inequality.
4. **Growth Rates**: By analyzing income growth rates, we can see how different states have progressed or regressed in terms of income over time.
