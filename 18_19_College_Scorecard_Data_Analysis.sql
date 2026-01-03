/*
Project Title: College Scorecard 2018–2019 Analysis
Author: Daniel Huang
Purpose: Analyze institution-level data for four-year, bachelor’s degree–granting U.S. universities.
*/

-- -----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------- CREATE TABLE & IMPORT DATA ---------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- Create College Scorecard 2018_2019 Data Table and Import the CSV Data
-- Import all data in TEXT format to handle the large numbers of "NAs"
CREATE TABLE college_scorecard_data.college_data_table_18_19 (
	UNITID TEXT,
	INSTNM TEXT,
	CITY TEXT,
	STABBR TEXT,
	ZIP TEXT,

	PREDDEG TEXT,
	HIGHDEG TEXT,
    CONTROL TEXT,
    REGION TEXT,

    ADM_RATE TEXT,
    SATVRMID TEXT,
    SATMTMID TEXT,
    SATWRMID TEXT,
    ACTCMMID TEXT,
    ACTENMID TEXT,
    ACTMTMID TEXT,
    ACTWRMID TEXT,

    UGDS TEXT,

    NPT4_PUB TEXT,
    NPT4_PRIV TEXT,
    NUM4_PUB TEXT,
    NUM4_PRIV TEXT,
    COSTT4_A TEXT,
    COSTT4_P TEXT,
    TUITIONFEE_IN TEXT,
    TUITIONFEE_OUT TEXT,

    PCTPELL TEXT,
    C150_4 TEXT,
	PFTFTUG1_EF TEXT,
    D150_4 TEXT,
	
	RET_FT4 TEXT,
	PCTFLOAN TEXT,
	DEBT_MDN TEXT,
	DEBT_N TEXT,
	FAMINC TEXT,
    MD_FAMINC TEXT,
    MEDIAN_HH_INC TEXT,

    COUNT_NWNE_1YR TEXT,
    COUNT_WNE_1YR TEXT,
    CNTOVER150_1YR TEXT,
    MD_EARN_WNE_1YR TEXT
);

-- Let's view the first 10 rows of the table
SELECT *
FROM college_scorecard_data.college_data_table_18_19
LIMIT 10;

-- How many institutions are included in the college scorecard data set?
SELECT COUNT(DISTINCT unitid) AS Numbers_of_Institutions
FROM college_scorecard_data.college_data_table_18_19;
-- There are 6807 institutions included in the data set

-- -----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------ CLEAN DATA -----------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

/* After observing the data of the table, here are the steps we will take to clean the data:
1. PREDDEG, HIGHDEG, CONTROL, REGION are categorical values represented by digits. Need to assign the actual values to the categories.
2. All the fields are stored as TEXT values. Need to convert fields into the correct data types. And be mindful of the "NA", " ", and "PS" values.
*/

-- Assign values to categorical values: PREDDEG, HIGHDEG, CONTROL, REGION
UPDATE college_scorecard_data.college_data_table_18_19
SET preddeg = 
	CASE 
	WHEN preddeg = '0' THEN 'Not Classified'
	WHEN preddeg = '1' THEN 'Predominantly certificate-degree granting'
	WHEN preddeg = '2' THEN 'Predominantly associates-degree granting'
	WHEN preddeg = '3' THEN 'Predominantly bachelors-degree granting'
	WHEN preddeg = '4' THEN 'Predominantly graduate-degree granting'
	ELSE 'NA' END;
	
UPDATE college_scorecard_data.college_data_table_18_19
SET highdeg = 
	CASE 
	WHEN highdeg = '0' THEN 'Non-degree-granting'
	WHEN highdeg = '1' THEN 'Certificate degree'
	WHEN highdeg = '2' THEN 'Associate degree'
	WHEN highdeg = '3' THEN 'Bachelors degree'
	WHEN highdeg = '4' THEN 'Graduate degree'
	ELSE 'NA' END;

UPDATE college_scorecard_data.college_data_table_18_19
SET control = 
	CASE 
	WHEN control = '1' THEN 'Public'
	WHEN control = '2' THEN 'Private nonprofit'
	WHEN control = '3' THEN 'Private for-profit'
	ELSE 'NA' END;

UPDATE college_scorecard_data.college_data_table_18_19
SET region = 
	CASE 
	WHEN region = '0' THEN 'U.S. Service Schools'
	WHEN region = '1' THEN 'New England'
	WHEN region = '2' THEN 'Mid East'
	WHEN region = '3' THEN 'Great Lakes'
	WHEN region = '4' THEN 'Plains'
	WHEN region = '5' THEN 'Southeast'
	WHEN region = '6' THEN 'Southwast'
	WHEN region = '7' THEN 'Rocky Mountains'
	WHEN region = '8' THEN 'Far West'
	WHEN region = '9' THEN 'Outlying Areas'
	ELSE 'NA' END;

-- Convert each column to its correct data type & Change all empty values, 'NA' values, and 'PS' values to NULL values.
UPDATE college_scorecard_data.college_data_table_18_19
SET unitid = 
	CASE WHEN TRIM(unitid) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(unitid) AS INTEGER) END,
	adm_rate =
	CASE WHEN TRIM(adm_rate) IN('','NA','PS')THEN NULL
	ELSE CAST(TRIM(adm_rate) AS FLOAT) END,
	satvrmid =
	CASE WHEN TRIM(satvrmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(satvrmid) AS FLOAT) END,
	satmtmid =
	CASE WHEN TRIM(satmtmid) IN('','NA','PS')THEN NULL
	ELSE CAST(TRIM(satmtmid) AS FLOAT) END,
	satwrmid =
	CASE WHEN TRIM(satwrmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(satwrmid) AS FLOAT) END,
	actcmmid =
	CASE WHEN TRIM(actcmmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(actcmmid) AS FLOAT) END,
	actenmid =
	CASE WHEN TRIM(actenmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(actenmid) AS FLOAT) END,
	actmtmid =
	CASE WHEN TRIM(actmtmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(actmtmid) AS FLOAT) END,
	actwrmid =
	CASE WHEN TRIM(actwrmid) IN('','NA','PS') THEN NULL
	ELSE CAST(TRIM(actwrmid) AS FLOAT) END, 
	ugds =
	CASE WHEN TRIM(ugds) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(ugds) AS INTEGER) END,
	npt4_pub =
	CASE WHEN TRIM(npt4_pub) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(npt4_pub) AS INTEGER) END,
	npt4_priv =
	CASE WHEN TRIM(npt4_priv) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(npt4_priv) AS INTEGER) END,
	num4_pub =
	CASE WHEN TRIM(num4_pub) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(num4_pub) AS INTEGER) END,
	num4_priv =
	CASE WHEN TRIM(num4_priv) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(num4_priv) AS INTEGER) END,
	costt4_a =
	CASE WHEN TRIM(costt4_a) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(costt4_a) AS INTEGER) END,
	costt4_p =
	CASE WHEN TRIM(costt4_p) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(costt4_p) AS INTEGER) END,
	tuitionfee_in =
	CASE WHEN TRIM(tuitionfee_in) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(tuitionfee_in) AS INTEGER) END,
	tuitionfee_out =
	CASE WHEN TRIM(tuitionfee_out) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(tuitionfee_out) AS INTEGER) END,
	pctpell =
	CASE WHEN TRIM(pctpell) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(pctpell) AS FLOAT) END,
	c150_4 =
	CASE WHEN TRIM(c150_4) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(c150_4) AS FLOAT) END,
	pftftug1_ef =
	CASE WHEN TRIM(pftftug1_ef) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(pftftug1_ef) AS FLOAT) END,
	d150_4 =
	CASE WHEN TRIM(d150_4) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(d150_4) AS INTEGER) END,	
	ret_ft4 =
	CASE WHEN TRIM(ret_ft4) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(ret_ft4) AS FLOAT) END,
	PCTFLOAN =
	CASE WHEN TRIM(PCTFLOAN) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(PCTFLOAN) AS FLOAT) END,	
	debt_mdn =
	CASE WHEN TRIM(debt_mdn) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(debt_mdn) AS FLOAT) END,	
	debt_n =
	CASE WHEN TRIM(debt_n) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(debt_n) AS INTEGER) END ,
	faminc =
	CASE WHEN TRIM(faminc) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(faminc) AS INTEGER) END ,
	md_faminc =
	CASE WHEN TRIM(md_faminc) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(md_faminc) AS INTEGER) END,
	median_hh_inc =
	CASE WHEN TRIM(median_hh_inc) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(median_hh_inc) AS INTEGER) END,
	count_nwne_1yr =
	CASE WHEN TRIM(count_nwne_1yr) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(count_nwne_1yr) AS INTEGER) END,
	count_wne_1yr =
	CASE WHEN TRIM(count_wne_1yr) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(count_wne_1yr) AS INTEGER) END,
	cntover150_1yr =
	CASE WHEN TRIM(cntover150_1yr) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(cntover150_1yr) AS INTEGER) END,
	md_earn_wne_1yr =
	CASE WHEN TRIM(md_earn_wne_1yr) IN ('','NA','PS') THEN NULL
	ELSE CAST(TRIM(md_earn_wne_1yr) AS INTEGER) END;

-- Apply the Data Type Change to the Table
ALTER TABLE college_scorecard_data.college_data_table_18_19
	ALTER COLUMN unitid TYPE INTEGER USING unitid::INTEGER,
	ALTER COLUMN adm_rate TYPE FLOAT USING adm_rate::FLOAT,
	ALTER COLUMN satvrmid TYPE FLOAT USING satvrmid::FLOAT,
	ALTER COLUMN satmtmid TYPE FLOAT USING satmtmid::FLOAT,
	ALTER COLUMN satwrmid TYPE FLOAT USING satmtmid::FLOAT,
	ALTER COLUMN actcmmid TYPE FLOAT USING actcmmid::FLOAT,
	ALTER COLUMN actenmid TYPE FLOAT USING actenmid::FLOAT,
	ALTER COLUMN actmtmid TYPE FLOAT USING actmtmid::FLOAT,	
	ALTER COLUMN actwrmid TYPE FLOAT USING actwrmid::FLOAT,
	ALTER COLUMN ugds TYPE INTEGER USING ugds::INTEGER,
	ALTER COLUMN npt4_pub TYPE INTEGER USING npt4_pub::INTEGER,
	ALTER COLUMN npt4_priv TYPE INTEGER USING npt4_priv::INTEGER,
	ALTER COLUMN num4_pub TYPE INTEGER USING num4_pub::INTEGER,
	ALTER COLUMN num4_priv TYPE INTEGER USING num4_priv::INTEGER,
	ALTER COLUMN costt4_a TYPE INTEGER USING costt4_a::INTEGER,	
	ALTER COLUMN costt4_p TYPE INTEGER USING costt4_p::INTEGER,
	ALTER COLUMN tuitionfee_in TYPE INTEGER USING tuitionfee_in::INTEGER,
	ALTER COLUMN tuitionfee_out TYPE INTEGER USING tuitionfee_out::INTEGER,
	ALTER COLUMN pctpell TYPE FLOAT USING pctpell::FLOAT,		
	ALTER COLUMN c150_4 TYPE FLOAT USING c150_4::FLOAT,
	ALTER COLUMN pftftug1_ef TYPE FLOAT USING pftftug1_ef::FLOAT,
	ALTER COLUMN d150_4 TYPE INTEGER USING d150_4::INTEGER,
	ALTER COLUMN ret_ft4 TYPE FLOAT USING ret_ft4::FLOAT,
	ALTER COLUMN pctfloan TYPE FLOAT USING pctfloan::FLOAT,
	ALTER COLUMN debt_mdn TYPE FLOAT USING debt_mdn::FLOAT,
	ALTER COLUMN debt_n TYPE INTEGER USING debt_n::INTEGER,	
	ALTER COLUMN faminc TYPE INTEGER USING faminc::INTEGER,	
	ALTER COLUMN md_faminc TYPE INTEGER USING md_faminc::INTEGER,	
	ALTER COLUMN median_hh_inc TYPE INTEGER USING median_hh_inc::INTEGER,
	ALTER COLUMN count_nwne_1yr TYPE INTEGER USING count_nwne_1yr::INTEGER,
	ALTER COLUMN count_wne_1yr TYPE INTEGER USING count_wne_1yr::INTEGER,	
	ALTER COLUMN cntover150_1yr TYPE INTEGER USING cntover150_1yr::INTEGER,
	ALTER COLUMN md_earn_wne_1yr TYPE INTEGER USING md_earn_wne_1yr::INTEGER;

-- Let's view the table again:
SELECT *
FROM college_scorecard_data.college_data_table_18_19 
ORDER BY unitid
LIMIT 10;

-- Since the goal of the analysis is to focus on 4-year, bachelor-focused institutions 
-- How many institutions are "Predominantly bachelors-degree granting?": 2058
SELECT COUNT(*)
FROM college_scorecard_data.college_data_table_18_19
WHERE preddeg = 'Predominantly bachelors-degree granting';

-- Now the data table is ready for data analysis.

-- -----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------ DATA MANIPULATION & ANALYSIS -----------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------

-- --------------------------------------------- RESEARCH AREA 1 ---------------------------------------------------------
-- PUBLIC vs. PRIVATE vs. PRIVATE-FOR-PROFIT, IS THERE A SYSTEMATIC DIFFERENCE IN RETENTION & GRADUATION BETWEEN INSTITUTION OWNERSHIP?

-- 1.a: What is the distribution of college onwership among all 4-year, bachelor-focused institutions?
SELECT 
	control AS Institution_Ownership, 
	COUNT(*) AS Count, 
	ROUND(
	COUNT(*)::numeric / 
	(SELECT COUNT(*)::numeric 
	 FROM college_scorecard_data.college_data_table_18_19 
	 WHERE preddeg = 'Predominantly bachelors-degree granting')
	 *100
	 , 2) AS Percentage
FROM college_scorecard_data.college_data_table_18_19
WHERE preddeg = 'Predominantly bachelors-degree granting'
GROUP BY control
ORDER BY count DESC;
-- We can now see among all "Predominantly bachelors-degree granting" colleges, 'Private nonprofit' is the most common ownership.
-- 61.95% of the colleges are 'Private nonprofit'. While 29.54% are "Public" and only 8.5% are "Private for-profit".


-- 1.b: Compare the Retention & Graduation Rate between different institution ownerships
--- Note: for outcome analysis, filter out school with ugds >= the 25th percentile to reduce the effect of outliers.
SELECT
	control AS institution_ownership,
	COUNT(c150_4) AS graduation_rate_sample_size,
	ROUND(AVG(c150_4)::numeric,2) AS average_graduation_rate,
	COUNT(ret_ft4) AS retention_rate_sample_size,
	ROUND(AVG(ret_ft4)::numeric,2) AS average_retention_rate
FROM college_scorecard_data.college_data_table_18_19 
WHERE preddeg = 'Predominantly bachelors-degree granting' 
      AND UGDS >=
	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY UGDS)
	   FROM college_scorecard_data.college_data_table_18_19
	   WHERE preddeg = 'Predominantly bachelors-degree granting')		
GROUP BY control;
-- Based on the results, we can see that in general "Private nonprofit" and "Public" schools have higher average_graduation_rate & higher average_rentention_rate than "Private for-profit" schools.
-- "Private nonprofit" schools' average_graduation_rate is slightly higher than that of 'Public' school.

-- 1.c: Within each ownership category, which institution rank among the top 10 in student retention rate? How about the graduation rate?
--- Top 10 retention rate in each ownership category
SELECT *
FROM (
	SELECT unitid AS ID,
		   instnm AS Institution_Name,
		   city AS Institution_City,
		   stabbr AS Institution_State_Code,
		   control AS Institution_Ownership,
		   ugds AS Student_Enrollment,
		   ret_ft4 AS Retention_Rate,
		   ROW_NUMBER() OVER(
	   		  PARTITION BY control 
			  ORDER BY ret_ft4 DESC
	  	   ) AS retention_rate_rank
	FROM college_scorecard_data.college_data_table_18_19
	WHERE preddeg = 'Predominantly bachelors-degree granting'
		  AND ret_ft4 IS NOT NULL
		  AND ugds >= 
	  	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY UGDS)
	   	   FROM college_scorecard_data.college_data_table_18_19
	       WHERE preddeg = 'Predominantly bachelors-degree granting')		  
)t
WHERE t.retention_rate_rank <= 10
ORDER BY t.Institution_Ownership;

-- Top 10 graduation rate in each ownership category
SELECT *
FROM (
	SELECT unitid AS ID,
		   instnm AS Institution_Name,
		   city AS Institution_City,
		   stabbr AS Institution_State_Code,
		   control AS Institution_Ownership,
		   ugds AS Student_Enrollment,
		   c150_4 AS Graduation_Rate,
		   ROW_NUMBER() OVER(
	   		  PARTITION BY control 
			  ORDER BY c150_4 DESC
	  	   ) AS graduation_rate_rank
	FROM college_scorecard_data.college_data_table_18_19
	WHERE preddeg = 'Predominantly bachelors-degree granting'
		  AND c150_4 IS NOT NULL
		  AND ugds >= 
	  	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY UGDS)
	   	   FROM college_scorecard_data.college_data_table_18_19
	       WHERE preddeg = 'Predominantly bachelors-degree granting')		  
)t1
WHERE t1.graduation_rate_rank <= 10
ORDER BY t1.Institution_Ownership;

-- --------------------------------------------- RESEARCH AREA 2 ---------------------------------------------------------
-- DOES SELECTIVITY ASSOCIATE WITH STRONGER STUDENT OUTCOMES: HIGH GRADUATION RATE & HIGH POST-GRADUATION EMPLOYMENT

-- 2.a: The relationship between institutional selectivity, graduation rate, and post-graduation employment after 1yr of graduation
--- I splited the instituions into 4 categories based on their admission rate. The 4 categories are:
--- 1. Highly Selective (Admission Rate <= 25%)
--- 2. Selective (Admission Rate > 25% and <= 50%)
--- 3. Moderately Selective (Admission Rate >50% and <= 75%)
--- 4. Less Selective (Admission Rate > 75%)
--- The post-graduation employment rate is calculated by the number of graduates working after 1 year divided by the sum of number of graduate working & not working after 1 year
SELECT
	CASE 
		 WHEN adm_rate::numeric <= 0.25 THEN 'Highly Selective (Admission Rate <= 25%)'
		 WHEN adm_rate::numeric > 0.25 AND adm_rate::numeric <= 0.5 THEN 'Selective (Admission Rate > 25% and <= 50%'
		 WHEN adm_rate::numeric > 0.5 AND adm_rate::numeric <= 0.75 THEN 'Moderately Selective (Admission Rate > 50% and <= 75%)' 
		 ELSE 'Less Selective (Admission Rate > 75%)' END AS Institution_Selectivity,
	COUNT(unitid) AS Number_of_Institutions,
	ROUND(AVG(c150_4)::numeric,2) AS Average_Graduation_Rate,
	ROUND(SUM(count_wne_1yr)::numeric / (SUM(count_wne_1yr)::numeric+SUM(count_nwne_1yr))::numeric, 4) AS Employment_Rate_After_1yr_Graduation
FROM college_scorecard_data.college_data_table_18_19
WHERE adm_rate IS NOT NULL
      AND preddeg = 'Predominantly bachelors-degree granting'
	  AND ugds >=
	  	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY UGDS)
	   	   FROM college_scorecard_data.college_data_table_18_19
	       WHERE preddeg = 'Predominantly bachelors-degree granting')
GROUP BY Institution_Selectivity
ORDER BY Average_Graduation_Rate DESC
-- Based on the data, we can observe that institution selectivity has strong impact on the average_graduation rate.
-- Hard selectivity means higher graduation rate.
-- However, selectivity seems to not have high impact on employment_rate. 
-- But since the college data does not track the earnings of students, we cannot analyze what kinds of jobs students are working after graduation.

-- --------------------------------------------- RESEARCH AREA 3 ---------------------------------------------------------
-- COST OF ATTENDANCE AND STUDENT OUTCOMES: EVIDENCE FROM GRADUATION RATE AND EMPLOYMENT RATE

--- For this analysis, I am also going to divide the institutions into 4 categorizes based on their annual cost of attendance
--- Note: this analysis does not consider students loan, scholarships, or federal assistances. Only focus on cost of attendance
--- Find the 25th, 50th, and 75th percentile of cost of attendance, will categorize institutions into different cost tiers.
WITH cte AS(
SELECT
	COALESCE(costt4_a, costt4_p) AS Annual_Cost_of_Attendance
FROM college_scorecard_data.college_data_table_18_19
WHERE preddeg = 'Predominantly bachelors-degree granting'
	  AND ugds >=
	  	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ugds)
	   	   FROM college_scorecard_data.college_data_table_18_19
	       WHERE preddeg = 'Predominantly bachelors-degree granting')
)
SELECT 
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Annual_Cost_of_Attendance),
	PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Annual_Cost_of_Attendance),
	PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Annual_Cost_of_Attendance)
FROM CTE
WHERE Annual_Cost_of_Attendance IS NOT NULL

-- 3.a: Examine Graduation and Employment Outcomes Across Institutional Cost Tiers
WITH cte AS(
SELECT
	unitid,
	c150_4,
	ugds,
	count_wne_1yr,
	count_nwne_1yr,
	preddeg,
	COALESCE(costt4_a, costt4_p) AS Annual_Cost_of_Attendance
FROM college_scorecard_data.college_data_table_18_19
)
SELECT 
	CASE 
		 WHEN Annual_Cost_of_Attendance::numeric <= 22530 THEN '4Lowest Cost'
		 WHEN Annual_Cost_of_Attendance::numeric > 22530 AND Annual_Cost_of_Attendance::numeric <= 34037.5 THEN '3Lower-Middle Cost'
		 WHEN Annual_Cost_of_Attendance::numeric > 34037.5 AND Annual_Cost_of_Attendance::numeric <= 48269.25 THEN '2Upper-Middle Cost' 
		 ELSE '1Highest Cost' END AS Institution_Cost_Tier,
	COUNT(unitid) AS Number_of_Institutions,
	ROUND(AVG(c150_4)::numeric,2) AS Average_Graduation_Rate,
	ROUND(SUM(count_wne_1yr)::numeric / (SUM(count_wne_1yr)::numeric+SUM(count_nwne_1yr))::numeric, 4) AS Employment_Rate_After_1yr_Graduation
FROM cte
WHERE Annual_Cost_of_Attendance IS NOT NULL
	  AND preddeg = 'Predominantly bachelors-degree granting'
	  AND ugds >=
	  	  (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY ugds)
	   	   FROM college_scorecard_data.college_data_table_18_19
	       WHERE preddeg = 'Predominantly bachelors-degree granting')
GROUP BY Institution_Cost_Tier
ORDER BY Institution_Cost_Tier
-- The results are pretty similar to our previous selectivity analysis.
-- The schools with highest cost have the highest average_graduation_rate. But the employment rates are pretty similar for schools in different cost tiers.

