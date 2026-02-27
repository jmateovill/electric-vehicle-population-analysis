-- most popular ev maker/model
SELECT model_year, maker, model, count(*) as ev_count
FROM evpd_staging
GROUP BY model_year, maker, model
HAVING model_year BETWEEN 2015 AND 2025
ORDER by ev_count DESC;

-- checking the most ev count per model year
SELECT model_year, maker, model, count(*)
FROM evpd_staging
WHERE model_year = 2025
GROUP BY model_year, maker, model
ORDER BY count(*) DESC;

-- most popular ev per production year
WITH ev_popularity AS (
	SELECT model_year, maker, model, count(*) as ev_count
	FROM evpd_staging
	WHERE model_year BETWEEN 2015 AND 2025
	GROUP BY model_year, maker, model
)

SELECT model_year, maker, model, ev_count
FROM (
	SELECT 
		model_year, 
		maker, 
		model, 
		ev_count,
		row_number() OVER (PARTITION BY model_year 
					ORDER BY ev_count DESC) as rownum
	FROM ev_popularity
)
WHERE rownum = 1;



