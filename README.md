

# 🧪 COVID-19 Data Exploration Project (SQL Server)

This project focuses on exploring a global COVID-19 dataset using **SQL Server**. The goal was to analyze the pandemic's progression, trends in cases and deaths, and key comparisons across countries and time periods using **structured SQL queries**.

This work demonstrates my ability to write clean, efficient SQL and perform real-world data exploration on large datasets.

---

## 📌 Objective

* Practice real-world data exploration using SQL
* Extract insights from time-series health data
* Understand the impact of COVID-19 globally and by region
* Demonstrate SQL techniques including aggregations, joins, CTEs, and window functions

---

## 🗃 Dataset Description

> 💾 *The dataset used was a global COVID-19 dataset containing daily case updates by country.*
> *(Due to file size limitations, the dataset is not included in the repository. Any public COVID-19 dataset can be used.)*

Typical columns include:

* `date`, `location`, `continent`, `population`
* `total_cases`, `new_cases`, `total_deaths`, `new_deaths`
* `people_vaccinated`, `people_fully_vaccinated`, `total_tests`

---

## 🔍 Key SQL Exploration Performed

* ✅ Total and daily case trends by country and continent
* ✅ Global death rate and its progression over time
* ✅ Top 10 countries by infection and death rates
* ✅ Percentage of population infected per country
* ✅ Rolling averages of cases and deaths using window functions
* ✅ Vaccination progress comparisons
* ✅ Use of CTEs, `CASE WHEN`, `JOIN`, and aggregate functions to combine and enrich insights

---

## 🧠 Sample Insights

* 🌍 **Highest total case counts** came from the US, India, and Brazil
* 📈 Some countries had **over 10% of their population infected**
* ⚰️ Countries with high population density showed **higher death-to-case ratios**
* 💉 Clear trend: **higher vaccination rates aligned with fewer new cases** post rollout
* 📊 Used window functions to calculate **7-day rolling averages** of new cases

---

## 🛠 Tools Used

* **SQL Server Management Studio (SSMS)**
* **SQL queries** using:

  * `JOIN`, `GROUP BY`, `ORDER BY`
  * `CTE` (Common Table Expressions)
  * `RANK()`, `ROW_NUMBER()`
  * `CASE WHEN` and conditional logic
  * `CAST`, `CONVERT`, and date handling

---

## 🏁 Summary

This project demonstrates my ability to work with SQL Server and use raw SQL to explore, transform, and analyze large datasets. It reflects real-world skills that can be applied to public health, finance, or any time-series-based domain.

---

## 📄 License

This project is intended for educational and portfolio demonstration purposes only.

