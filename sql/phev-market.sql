-- bev vs. phev
SELECT ev_type, count(*)
FROM evpd_staging
GROUP BY ev_type;

-- total count of registered phev's
SELECT count(*)
FROM evpd_staging
WHERE ev_type = "PHEV";

-- phev count each year in the past decade
SELECT model_year, count(*)
FROM evpd_staging
WHERE ev_type = "PHEV"
GROUP BY model_year
HAVING model_year BETWEEN 2015 AND 2025;

-- phev share on total ev count + phev adoption rate YoY
WITH phev_decade AS (
	SELECT 
		model_year as year, 
		CAST(sum(CASE WHEN ev_type = "BEV" THEN 1 ELSE 0 END) AS REAL) as bev_count,
		CAST(sum(CASE WHEN ev_type = "PHEV" THEN 1 ELSE 0 END) AS REAL) as phev_count,
		CAST(count(*) AS REAL) as total_ev_count
	FROM evpd_staging
	WHERE year BETWEEN 2015 AND 2025
	GROUP BY year
),

phev_calculation AS (
	SELECT 
		year,
		total_ev_count,
		bev_count,
		phev_count, 
		((phev_count/total_ev_count)*100) as phev_share,
		LAG(phev_count) OVER (ORDER BY year) as prev_phev_count
	FROM phev_decade
)

SELECT 
	year,
	total_ev_count,
	bev_count,
	phev_count,
	round(phev_share, 2) as phev_share,
	round(((phev_count - prev_phev_count)/prev_phev_count)*100, 2) as phev_adoption_rate
FROM phev_calculation;
