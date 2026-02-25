-- adoption velocity YoY
SELECT model_year, COUNT(vin)
FROM evpd_staging
GROUP BY model_year
ORDER BY model_year;

-- checking top ev models of year floor range
SELECT maker, model, ev_type, count(vin)
FROM evpd_staging
WHERE model_year = 2015
GROUP BY maker, model, ev_type
ORDER BY count(vin) DESC;

-- list of ev manufacturers
SELECT DISTINCT maker
FROM evpd_staging
ORDER BY 1;

-- adoption rate over year by the past decade
WITH ev_decade AS (
	SELECT model_year as year, CAST(COUNT(*) AS REAL) as ev_count
	FROM evpd_staging
	GROUP BY model_year
	HAVING model_year BETWEEN 2015 AND 2025
), 

adoption_calculation AS (
	SELECT
		year,
		ev_count,
		lag(ev_count) OVER (ORDER BY year) as prev_year
	FROM ev_decade
)

SELECT 
	year,
	ev_count,
	round((ev_count - prev_year)/prev_year, 4)*100 as adoption_rate
FROM adoption_calculation
ORDER BY year;

