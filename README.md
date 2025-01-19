# Exploratory-Data-Analysis-with-MySQL

## Overview
This project focuses on performing exploratory data analysis (EDA) using MySQL. Before diving into EDA, I cleaned and prepared the raw dataset, which is documented in a separate repository: [Data Cleaning with MySQL](https://github.com/mi7773/Data-Cleaning-with-MySQL). The goal of this project was to build on the cleaned dataset and uncover actionable insights through SQL queries and techniques.

This project was inspired by a [YouTube tutorial](https://youtu.be/QYd-RtK58VQ) and served as an excellent opportunity to refine my EDA skills while leveraging MySQL.

## Key Features

- Leveraging SQL to compute descriptive statistics and identify trends.
- Applying advanced SQL techniques to summarize and visualize data.
- Building on the cleaned dataset for robust analysis.

## Skills Gained

- Mastery of SQL for exploratory data analysis.
- Insights into the importance of data exploration before advanced analytics.
- Experience in using SQL to investigate trends and patterns.

## Project Files

| File Name                       | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| `README.md`                     | Comprehensive documentation for the project.                                |
| `exploratory_data_analysis.sql` | Queries to identify trends and patterns and compute descriptive statistics. |

## Sample Queries

### Descriptive Statistics

```sql
-- company & year laid off (top 5)
WITH Company_Year (company, years, total_laid_off) AS
(
	SELECT
		company,
        YEAR(`date`),
        SUM(total_laid_off)
	FROM layoffs_staging_02
    GROUP BY 
		company,
        YEAR(`date`)
),
Ranked_Company_Year AS
(
	SELECT
		*,
        DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
	FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT *
FROM Ranked_Company_Year
WHERE ranking <= 5
ORDER BY years, ranking;
```

## Connect with Me

- [LinkedIn](https://www.linkedin.com/in/mi7773/)
- [GitHub](https://github.com/mi7773)
- [X](https://x.com/mi7773)
- [Discord](https://discordapp.com/users/1106153071706394677)
- [Email](mailto:mahmoudismailabdelrazek@gmail.com)
- [WhatsApp](https://wa.me/201282244419)

## Acknowledgments  
I would like to thank [Alex The Analyst](https://www.youtube.com/@AlexTheAnalyst) for their insightful tutorial, which served as the foundation for this project. Their guidance made learning data cleaning with MySQL much easier and more enjoyable.
