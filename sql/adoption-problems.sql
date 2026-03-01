-- problem in adoption
SELECT model_year, COUNT(vin)
FROM evpd_staging
GROUP BY model_year
ORDER BY model_year DESC;

-- cafv eligibility record by category
SELECT 
    cafv_eligibility, 
    COUNT(*) AS cafv_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS cafv_pct
FROM evpd_staging
GROUP BY cafv_eligibility
ORDER BY cafv_count DESC;

-- ev makers with the most 'unknown' eligibility 
-- due to 0 electric range 
SELECT 	model_year, maker, count(*) as rec_count
FROM evpd_staging
WHERE model_year between 2015 and 2025
GROUP BY model_year, maker
HAVING cafv_eligibility = 'Unknown'
ORDER BY rec_count DESC;

-- ev makers with the most ineligible vehicles
SELECT 	model_year, maker, count(*) as rec_count
FROM evpd_staging
WHERE model_year between 2015 and 2025
GROUP BY model_year, maker
HAVING cafv_eligibility = 'Not Eligible'
ORDER BY rec_count DESC;

-- ev model with the most unknown records
SELECT 	model_year, maker, model, count(*) as rec_count
FROM evpd_staging
WHERE model_year between 2015 and 2025
GROUP BY model_year, maker, model
HAVING cafv_eligibility = 'Unknown'
ORDER BY rec_count DESC;

-- ev model with the most ineligible records
SELECT 	model_year, maker, model, count(*) as rec_count
FROM evpd_staging
WHERE model_year between 2015 and 2025
GROUP BY model_year, maker, model
HAVING cafv_eligibility = 'Not Eligible'
ORDER BY rec_count DESC;