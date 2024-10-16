-- Data Exploratory

SELECT *
FROM us_household_project.us_household_income;

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;

SELECT *
FROM us_household_project.us_household_income u
RIGHT JOIN us_household_project.us_household_income_statistics us
	ON u.id = us.id
WHERE u.id IS NULL;

SELECT *
FROM us_household_project.us_household_income u
JOIN us_household_project.us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;

SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_project.us_household_income u
INNER JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0;

SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_project.us_household_income u
INNER JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0;

SELECT u.State_Name, ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_project.us_household_income u
INNER JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC #2 #DESC
LIMIT 10;

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_project.us_household_income u
INNER JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 3 DESC #4
LIMIT 20;

SELECT *
FROM us_household_income
WHERE Type = 'Community';

SELECT Type, COUNT(Type), ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_project.us_household_income u
INNER JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20;

SELECT u.State_Name, City, ROUND(AVG(Mean), 1), ROUND(AVG(Median), 1)
FROM us_household_project.us_household_income u
JOIN us_household_project.us_household_income_statistics us
ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean), 1) DESC;

