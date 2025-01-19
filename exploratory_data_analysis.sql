-- Exploratory Data Analysis

-- max. laid off and max. percentage
SELECT 
	MAX(total_laid_off) AS max_laid_off,
    MAX(percentage_laid_off) AS max_percentage
FROM layoffs_staging_02;

-- 100% percentage laid off ordered by total laid off
SELECT *
FROM layoffs_staging_02
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- 100% percentage laid off ordered by funds raised millions
SELECT *
FROM layoffs_staging_02
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- sum. company total laid off 
SELECT 
	company,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY company
ORDER BY sum_laid_of DESC;

-- max. and min. date
SELECT
	MIN(`date`) AS min_date,
    MAX(`date`) AS max_date
FROM layoffs_staging_02;

-- sum. industry total laid off
SELECT
	industry,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY industry
ORDER BY sum_laid_off DESC;

-- sum. country total laid off
SELECT
	country,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY country
ORDER BY sum_laid_off DESC;

-- sum. date total laid off (by sum.)
SELECT
	`date`,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY `date`
ORDER BY sum_laid_off DESC;

-- sum. date total laid off (by date)
SELECT
	`date`,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY `date`
ORDER BY `date` DESC;

-- sum. year total laid off (by year)
SELECT
	YEAR(`date`) AS date_year,
    SUM(total_laid_off) AS sum_laid_off
FROm layoffs_staging_02
GROUP BY date_year
ORDER BY date_year DESC;

-- sum. stage total laid off (by stage)
SELECT
	stage,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY stage
ORDER BY stage DESC;

-- sum. stage total laid off (by date)
SELECT
	stage,
    SUM(total_laid_off) AS sum_laid_off
FROM layoffs_staging_02
GROUP BY stage
ORDER BY sum_laid_off DESC;

-- avg. company total laid off
SELECT
	company,
    AVG(percentage_laid_off) as avg_percent
FROM layoffs_staging_02
GROUP BY company
HAVING avg_percent != 1
ORDER BY avg_percent DESC;

-- rolling sum of total laid off (by month)
WITH Rolling_Total AS
(
	SELECT
		SUBSTRING(`date`, 1, 7) AS `MONTH`,
		SUM(total_laid_off) AS total_off
	FROM layoffs_staging_02
	WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
	GROUP BY `MONTH`
	ORDER BY `MONTH` ASC
)
SELECT
	`MONTH`,
    total_off,
    SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- company & year laid off
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
)
SELECT
	*,
    DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY ranking ASC;

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