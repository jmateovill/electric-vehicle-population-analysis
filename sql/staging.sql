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