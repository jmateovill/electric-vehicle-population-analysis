-- create mirror table
CREATE TABLE "ev_pop_data" (
	"VIN (1-10)"	TEXT,
	"County"	TEXT,
	"City"	TEXT,
	"State"	TEXT,
	"Postal Code"	INTEGER,
	"Model Year"	INTEGER,
	"Maker"	TEXT,
	"Model_final"	TEXT,
	"Model"	TEXT,
	"Electric Vehicle Type"	TEXT,
	"CAFV Eligibility"	TEXT,
	"Validated Eligibility"	TEXT,
	"Electric Range"	INTEGER,
	"Legislative District"	INTEGER,
	"DOL Vehicle ID"	INTEGER,
	"Vehicle Location"	TEXT,
	"Primary Electric Utility"	TEXT,
	"2020 Census Tract"	INTEGER
);

-- insert values
INSERT INTO ev_pop_data
SELECT *
FROM Electric_Vehicle_Population_Data_clean;

-- check data
SELECT *
FROM ev_pop_data;

SELECT COUNT(*)
FROM ev_pop_data;

-- staged table with renamed colnames
CREATE TABLE "evpd_staging" (
	"vin"	TEXT,
	"county"	TEXT,
	"city"	TEXT,
	"state"	TEXT,
	"postal_code"	INTEGER,
	"model_year"	INTEGER,
	"maker"	TEXT,
	"model"	TEXT,
	"model_raw"	TEXT,
	"ev_type"	TEXT,
	"cafv_eligibility"	TEXT,
	"validated_eligibility"	TEXT,
	"electric_range"	INTEGER,
	"legislative_district"	INTEGER,
	"dol_vehicle_id"	INTEGER,
	"vehicle_loc"	TEXT,
	"primary_elec_util"	TEXT,
	"census_trac_2020"	INTEGER
);

-- insert values
INSERT INTO evpd_staging
SELECT *
FROM ev_pop_data;

-- check data
SELECT *
FROM evpd_staging;

SELECT COUNT(*)
FROM evpd_staging;

-- adding a view for power bi-ready table
DROP VIEW IF EXISTS vw_EV_PowerBI_Ready;

CREATE VIEW vw_EV_PowerBI_Ready AS
SELECT 
    vin,
    maker,
    model,
    model_year,
    ev_type,
    -- Rule: Standardize and Shorten labels for UI
    CASE 
        WHEN ev_type LIKE '%BEV%' AND model_year BETWEEN 2021 AND 2025 
        THEN 'Eligible'
        WHEN cafv_eligibility LIKE '%Not Eligible%' 
        THEN 'Not Eligible'
        ELSE 'Unknown'
    END AS validated_eligibility,
    -- Rule: Set 0 to NULL so Power BI averages correctly
    CASE 
        WHEN electric_range = 0 THEN NULL 
        ELSE electric_range 
    END AS clean_range,
    county,
    city,
    primary_elec_util
FROM evpd_staging
WHERE model_year BETWEEN 2015 AND 2025;
