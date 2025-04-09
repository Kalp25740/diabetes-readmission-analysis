CREATE DATABASE diabetes;
USE diabetes;
CREATE TABLE raw_data (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(20),
    age VARCHAR(20),
    weight VARCHAR(20),
    admission_type_id INT,
    discharge_disposition_id INT,
    admission_source_id INT,
    time_in_hospital INT,
    medical_specialty VARCHAR(100),
    diag_1 VARCHAR(10),
    diag_2 VARCHAR(10),
    diag_3 VARCHAR(10),
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    readmitted VARCHAR(10),
    num_lab_procedures INT,
    num_procedures INT,
    num_medications INT,
    number_outpatient INT,
    number_inpatient INT,
    number_emergency INT,
    number_diagnoses INT,
    metformin VARCHAR(10),
    repaglinide VARCHAR(10),
    nateglinide VARCHAR(10),
    chlorpropamide VARCHAR(10),
    glimepiride VARCHAR(10),
    acetohexamide VARCHAR(10),
    glipizide VARCHAR(10),
    glyburide VARCHAR(10),
    tolbutamide VARCHAR(10),
    pioglitazone VARCHAR(10),
    rosiglitazone VARCHAR(10),
    acarbose VARCHAR(10),
    miglitol VARCHAR(10),
    troglitazone VARCHAR(10),
    tolazamide VARCHAR(10),
    examide VARCHAR(10),
    citoglipton VARCHAR(10),
    insulin VARCHAR(10),
    glyburide_metformin VARCHAR(10),
    glipizide_metformin VARCHAR(10),
    glimepiride_pioglitazone VARCHAR(10),
    metformin_rosiglitazone VARCHAR(10),
    metformin_pioglitazone VARCHAR(10),
    change_of_medicine VARCHAR(10),
    diabetesMed VARCHAR(10)
);
SELECT * 
FROM raw_data
LIMIT 5000;

SELECT COUNT(*) AS row_count 
FROM raw_data;

CREATE TABLE demographics (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    race VARCHAR(50),
    gender VARCHAR(20) NOT NULL,
    age VARCHAR(20) NOT NULL,
    weight VARCHAR(20)
);
CREATE TABLE admission_diagnosis (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    admission_type_id INT NOT NULL,
    discharge_disposition_id INT NOT NULL,
    admission_source_id INT NOT NULL,
    time_in_hospital INT NOT NULL,
    medical_specialty VARCHAR(100),
    diag_1 VARCHAR(10),
    diag_2 VARCHAR(10),
    diag_3 VARCHAR(10),
    max_glu_serum VARCHAR(20),
    A1Cresult VARCHAR(20),
    readmitted VARCHAR(10)
);

CREATE TABLE admission_events (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    num_lab_procedures INT NOT NULL,
    num_procedures INT NOT NULL,
    num_medications INT NOT NULL,
    number_outpatient INT NOT NULL,
    number_inpatient INT NOT NULL,
    number_emergency INT NOT NULL
);

CREATE TABLE medications (
    encounter_id BIGINT PRIMARY KEY,
    patient_nbr BIGINT,
    metformin VARCHAR(10),
    repaglinide VARCHAR(10),
    nateglinide VARCHAR(10),
    chlorpropamide VARCHAR(10),
    glimepiride VARCHAR(10),
    acetohexamide VARCHAR(10),
    glipizide VARCHAR(10),
    glyburide VARCHAR(10),
    tolbutamide VARCHAR(10),
    pioglitazone VARCHAR(10),
    rosiglitazone VARCHAR(10),
    acarbose VARCHAR(10),
    miglitol VARCHAR(10),
    troglitazone VARCHAR(10),
    tolazamide VARCHAR(10),
    examide VARCHAR(10),
    citoglipton VARCHAR(10),
    insulin VARCHAR(10),
    glyburide_metformin VARCHAR(10),
    glipizide_metformin VARCHAR(10),
    glimepiride_pioglitazone VARCHAR(10),
    metformin_rosiglitazone VARCHAR(10),
    metformin_pioglitazone VARCHAR(10),
    change_of_medicine VARCHAR(10),
    diabetesMed VARCHAR(10)
);

INSERT INTO demographics (encounter_id, patient_nbr, race, gender, age, weight)
SELECT encounter_id, patient_nbr, race, gender, age, weight
FROM raw_data;

INSERT INTO admission_diagnosis (
    encounter_id, patient_nbr, 
    admission_type_id, discharge_disposition_id, admission_source_id, 
    time_in_hospital, medical_specialty, 
    diag_1, diag_2, diag_3, 
    max_glu_serum, A1Cresult, readmitted
)
SELECT 
    encounter_id, patient_nbr, 
    admission_type_id, discharge_disposition_id, admission_source_id, 
    time_in_hospital, medical_specialty, 
    diag_1, diag_2, diag_3, 
    max_glu_serum, A1Cresult, readmitted
FROM raw_data;

INSERT INTO admission_events (
    encounter_id, patient_nbr, 
    num_lab_procedures, num_procedures, num_medications, 
    number_outpatient, number_inpatient, number_emergency
)
SELECT 
    encounter_id, patient_nbr, 
    num_lab_procedures, num_procedures, num_medications, 
    number_outpatient, number_inpatient, number_emergency
FROM raw_data;

INSERT INTO medications (
    encounter_id, patient_nbr, 
    metformin, repaglinide, nateglinide, 
    chlorpropamide, glimepiride, acetohexamide, 
    glipizide, glyburide, tolbutamide, 
    pioglitazone, rosiglitazone, acarbose, 
    miglitol, troglitazone, tolazamide, 
    examide, citoglipton, insulin, 
    glyburide_metformin, glipizide_metformin, 
    glimepiride_pioglitazone, metformin_rosiglitazone, 
    metformin_pioglitazone, change_of_medicine, diabetesMed
)
SELECT 
    encounter_id, patient_nbr, 
    metformin, repaglinide, nateglinide, 
    chlorpropamide, glimepiride, acetohexamide, 
    glipizide, glyburide, tolbutamide, 
    pioglitazone, rosiglitazone, acarbose, 
    miglitol, troglitazone, tolazamide, 
    examide, citoglipton, insulin, 
    glyburide_metformin, glipizide_metformin, 
    glimepiride_pioglitazone, metformin_rosiglitazone, 
    metformin_pioglitazone, change_of_medicine, diabetesMed
FROM raw_data;

SELECT COUNT(*) AS Demographics_Count FROM demographics;
SELECT COUNT(*) AS Admission_Diagnosis_Count FROM admission_diagnosis;
SELECT COUNT(*) AS Admission_Events_Count FROM admission_events;
SELECT COUNT(*) AS Medications_Count FROM medications;

SELECT * FROM demographics LIMIT 5;
SELECT * FROM admission_diagnosis LIMIT 5;
SELECT * FROM admission_events LIMIT 5;
SELECT * FROM medications LIMIT 5;


INSERT INTO admission_type (admission_type_id, description) VALUES
(1, 'Emergency'),
(2, 'Urgent'),
(3, 'Elective'),
(4, 'Newborn'),
(5, 'Not Available'),
(6, 'NULL'),
(7, 'Trauma Center'),
(8, 'Not Mapped');

#create foreign key for admission_type_id decsription, discharge diposition and admission source id.
ALTER TABLE admission_diagnosis
ADD CONSTRAINT fk_admission_type
FOREIGN KEY (admission_type_id) 
REFERENCES admission_type(admission_type_id);

SELECT * FROM admission_diagnosis
LIMIT 100;

SELECT * 
FROM admission_type
;

#left join description from admission type to admission_type_id in admission_diagnosis

SELECT 
    ad.encounter_id,
    ad.patient_nbr,
    COALESCE(at.description, 'Unknown') AS admission_type,
    ad.time_in_hospital,
    ad.readmitted
FROM admission_diagnosis ad
LEFT JOIN admission_type at 
ON ad.admission_type_id = at.admission_type_id;

CREATE TABLE discharge_disposition (
    discharge_disposition_id INT PRIMARY KEY,
    description VARCHAR(255)
);

INSERT INTO discharge_disposition (discharge_disposition_id, description) VALUES
(1, 'Discharged to home'),
(2, 'Discharged/transferred to another short term hospital'),
(3, 'Discharged/transferred to SNF'),
(4, 'Discharged/transferred to ICF'),
(5, 'Discharged/transferred to another type of inpatient care institution'),
(6, 'Discharged/transferred to home with home health service'),
(7, 'Left AMA'),
(8, 'Discharged/transferred to home under care of Home IV provider'),
(9, 'Admitted as an inpatient to this hospital'),
(10, 'Neonate discharged to another hospital for neonatal aftercare'),
(11, 'Expired'),
(12, 'Still patient or expected to return for outpatient services'),
(13, 'Hospice / home'),
(14, 'Hospice / medical facility'),
(15, 'Discharged/transferred within this institution to Medicare approved swing bed'),
(16, 'Discharged/transferred/referred another institution for outpatient services'),
(17, 'Discharged/transferred/referred to this institution for outpatient services'),
(18, 'NULL'),
(19, 'Expired at home. Medicaid only, hospice.'),
(20, 'Expired in a medical facility. Medicaid only, hospice.'),
(21, 'Expired, place unknown. Medicaid only, hospice.'),
(22, 'Discharged/transferred to another rehab fac including rehab units of a hospital'),
(23, 'Discharged/transferred to a long term care hospital.'),
(24, 'Discharged/transferred to a nursing facility certified under Medicaid but not certified under Medicare.'),
(25, 'Not Mapped'),
(26, 'Unknown/Invalid'),
(27, 'Discharged/transferred to a federal health care facility.'),
(28, 'Discharged/transferred/referred to a psychiatric hospital of psychiatric distinct part unit of a hospital'),
(29, 'Discharged/transferred to a Critical Access Hospital (CAH).'),
(30, 'Discharged/transferred to another Type of Health Care Institution not Defined Elsewhere');

CREATE TABLE admission_source (
    admission_source_id INT PRIMARY KEY,
    description VARCHAR(255)
);

INSERT INTO admission_source (admission_source_id, description) VALUES
(1, 'Physician Referral'),
(2, 'Clinic Referral'),
(3, 'HMO Referral'),
(4, 'Transfer from a hospital'),
(5, 'Transfer from a Skilled Nursing Facility (SNF)'),
(6, 'Transfer from another health care facility'),
(7, 'Emergency Room'),
(8, 'Court/Law Enforcement'),
(9, 'Not Available'),
(10, 'Transfer from critical access hospital'),
(11, 'Normal Delivery'),
(12, 'Premature Delivery'),
(13, 'Sick Baby'),
(14, 'Extramural Birth'),
(15, 'Not Available'),
(17, 'NULL'),
(18, 'Transfer From Another Home Health Agency'),
(19, 'Readmission to Same Home Health Agency'),
(20, 'Not Mapped'),
(21, 'Unknown/Invalid'),
(22, 'Transfer from hospital inpt/same fac reslt in a sep claim'),
(23, 'Born inside this hospital'),
(24, 'Born outside this hospital'),
(25, 'Transfer from Ambulatory Surgery Center'),
(26, 'Transfer from Hospice');

ALTER TABLE admission_diagnosis
ADD CONSTRAINT fk_discharge_disposition
FOREIGN KEY (discharge_disposition_id) 
REFERENCES discharge_disposition(discharge_disposition_id),

ADD CONSTRAINT fk_admission_source
FOREIGN KEY (admission_source_id) 
REFERENCES admission_source(admission_source_id);

SELECT * FROM discharge_disposition LIMIT 5;
SELECT * FROM admission_source LIMIT 5;

SELECT 
    ad.encounter_id,
    ad.patient_nbr,
    dd.description AS discharge_type,
    asrc.description AS admission_source
FROM admission_diagnosis ad
LEFT JOIN discharge_disposition dd 
ON ad.discharge_disposition_id = dd.discharge_disposition_id
LEFT JOIN admission_source asrc 
ON ad.admission_source_id = asrc.admission_source_id
LIMIT 10;

CREATE TABLE admission_summary AS
SELECT 
    ad.encounter_id,
    ad.patient_nbr,
    dd.description AS discharge_type,
    asrc.description AS admission_source,
    ad.time_in_hospital,
    ad.readmitted
FROM admission_diagnosis ad
LEFT JOIN discharge_disposition dd 
ON ad.discharge_disposition_id = dd.discharge_disposition_id
LEFT JOIN admission_source asrc 
ON ad.admission_source_id = asrc.admission_source_id;

CREATE INDEX idx_patient_encounter ON admission_summary(patient_nbr, encounter_id);

#lets have a count of all our tables
SELECT 
    (SELECT COUNT(*) FROM admission_summary) AS total_admissions,
    (SELECT COUNT(*) FROM discharge_disposition) AS unique_discharge_types,
    (SELECT COUNT(*) FROM admission_source) AS unique_admission_sources,
    (SELECT COUNT(*) FROM admission_events) AS total_admission_events,
    (SELECT COUNT(*) FROM demographics) AS total_demographics,
    (SELECT COUNT(*) FROM medications) AS total_medication_records;

#lets check missing data from admission_summary table
SELECT CONCAT(
    'SELECT ', 
    GROUP_CONCAT(
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL THEN 1 ELSE 0 END) AS missing_', COLUMN_NAME
    ), 
    ' FROM ', TABLE_NAME, ';'
) AS sql_statement
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'admission_summary';

SELECT
	SUM(CASE WHEN encounter_id IS NULL THEN 1 ELSE 0 END) AS missing_encounter_id,
    SUM(CASE WHEN patient_nbr IS NULL THEN 1 ELSE 0 END) AS missing_patient_nbr,
    SUM(CASE WHEN discharge_type IS NULL THEN 1 ELSE 0 END) AS missing_discharge_type,
    SUM(CASE WHEN admission_source IS NULL THEN 1 ELSE 0 END) AS missing_admission_source,
    SUM(CASE WHEN time_in_hospital IS NULL THEN 1 ELSE 0 END) AS missing_time_in_hospital,
    SUM(CASE WHEN readmitted IS NULL THEN 1 ELSE 0 END) AS missing_readmitted FROM admission_summary;
   
   #lets check missing data from admission_events table
SELECT CONCAT(
    'SELECT ', 
    GROUP_CONCAT(
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL THEN 1 ELSE 0 END) AS missing_', COLUMN_NAME
    ), 
    ' FROM ', TABLE_NAME, ';'
) AS sql_statement
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'admission_events';

SELECT
	SUM(CASE WHEN num_lab_procedures IS NULL THEN 1 ELSE 0 END) AS missing_num_lab_procedures,
    SUM(CASE WHEN num_procedures IS NULL THEN 1 ELSE 0 END) AS missing_num_procedures,
    SUM(CASE WHEN num_medications IS NULL THEN 1 ELSE 0 END) AS missing_num_medications,
    SUM(CASE WHEN number_outpatient IS NULL THEN 1 ELSE 0 END) AS missing_number_outpatient,
    SUM(CASE WHEN number_inpatient IS NULL THEN 1 ELSE 0 END) AS missing_number_inpatient,
    SUM(CASE WHEN number_emergency IS NULL THEN 1 ELSE 0 END) AS missing_number_emergency FROM admission_events;
    
    #lets check missing data from demographics table
 SELECT CONCAT(
    'SELECT ', 
    GROUP_CONCAT(
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL THEN 1 ELSE 0 END) AS missing_', COLUMN_NAME
    ), 
    ' FROM ', TABLE_NAME, ';'
) AS sql_statement
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'demographics';   

SELECT 
SUM(CASE WHEN race IS NULL THEN 1 ELSE 0 END) AS missing_race,
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
SUM(CASE WHEN weight IS NULL THEN 1 ELSE 0 END) AS missing_weight FROM demographics;

#lets check missing data from medications table
SELECT CONCAT(
    'SELECT ', 
    GROUP_CONCAT(
        'SUM(CASE WHEN ', COLUMN_NAME, ' IS NULL THEN 1 ELSE 0 END) AS missing_', COLUMN_NAME
    ), 
    ' FROM ', TABLE_NAME, ';'
) AS sql_statement
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'medications'; 

SELECT
	SUM(CASE WHEN encounter_id IS NULL THEN 1 ELSE 0 END) AS missing_encounter_id,
    SUM(CASE WHEN patient_nbr IS NULL THEN 1 ELSE 0 END) AS missing_patient_nbr,
    SUM(CASE WHEN metformin IS NULL THEN 1 ELSE 0 END) AS missing_metformin,
    SUM(CASE WHEN repaglinide IS NULL THEN 1 ELSE 0 END) AS missing_repaglinide,
    SUM(CASE WHEN nateglinide IS NULL THEN 1 ELSE 0 END) AS missing_nateglinide,
    SUM(CASE WHEN chlorpropamide IS NULL THEN 1 ELSE 0 END) AS missing_chlorpropamide,
    SUM(CASE WHEN glimepiride IS NULL THEN 1 ELSE 0 END) AS missing_glimepiride,
    SUM(CASE WHEN acetohexamide IS NULL THEN 1 ELSE 0 END) AS missing_acetohexamide,
    SUM(CASE WHEN glipizide IS NULL THEN 1 ELSE 0 END) AS missing_glipizide,
    SUM(CASE WHEN glyburide IS NULL THEN 1 ELSE 0 END) AS missing_glyburide,
    SUM(CASE WHEN tolbutamide IS NULL THEN 1 ELSE 0 END) AS missing_tolbutamide,
    SUM(CASE WHEN pioglitazone IS NULL THEN 1 ELSE 0 END) AS missing_pioglitazone,
    SUM(CASE WHEN rosiglitazone IS NULL THEN 1 ELSE 0 END) AS missing_rosiglitazone,
    SUM(CASE WHEN acarbose THEN 1 ELSE 0 END) AS missing_acarbose FROM medications;  
  
  #Descriptive stats
  #Average Length of Hospital Stay by Admission Source

SELECT 
    asrc.description AS admission_source, 
    ROUND(AVG(ad.time_in_hospital), 2) AS avg_hospital_stay
FROM admission_summary ad
LEFT JOIN admission_source asrc 
ON ad.admission_source = asrc.description  -- Matching descriptions instead of IDs
GROUP BY asrc.description
ORDER BY avg_hospital_stay DESC;

SELECT COUNT(*) FROM raw_data;

#Demographics analysis
SELECT age, COUNT(*) AS patient_count
FROM demographics
GROUP BY age
ORDER BY patient_count DESC;

#Hospital Utilization (from admission_events table)
SELECT ROUND(AVG(num_lab_procedures), 2) AS avg_lab_tests
FROM admission_events;

SELECT num_procedures, COUNT(*) AS frequency
FROM admission_events
GROUP BY num_procedures
ORDER BY frequency DESC;

SELECT 
    ROUND(AVG(number_outpatient), 2) AS avg_outpatient,
    ROUND(AVG(number_inpatient), 2) AS avg_inpatient,
    ROUND(AVG(number_emergency), 2) AS avg_emergency
FROM admission_events;

#Readmission trends
SELECT readmitted, COUNT(*) AS total, 
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM admission_summary)) * 100, 2) AS percent
FROM admission_summary
GROUP BY readmitted;

#Readmission rate by gender
SELECT 
    d.gender,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
    ROUND(SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate_30d
FROM admission_summary s
JOIN (
    SELECT patient_nbr, gender 
    FROM demographics
) d 
ON s.patient_nbr = d.patient_nbr
GROUP BY d.gender
ORDER BY readmission_rate_30d DESC;

#Readmission rate by race
SELECT 
    d.race,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
    ROUND(SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate_30d
FROM admission_summary s
JOIN (
    SELECT patient_nbr, race 
    FROM demographics
    WHERE race IS NOT NULL AND race != ''
) d 
ON s.patient_nbr = d.patient_nbr
GROUP BY d.race
ORDER BY readmission_rate_30d DESC;


#H. Readmission Rate by Discharge Type
SELECT discharge_type, 
       COUNT(*) AS total_patients,
       SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted,
       ROUND((SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS readmission_rate
FROM admission_summary
GROUP BY discharge_type
ORDER BY readmission_rate DESC;

#I. Length of Stay vs. Readmission
SELECT 
  CASE 
    WHEN time_in_hospital <= 2 THEN '0–2 days'
    WHEN time_in_hospital BETWEEN 3 AND 5 THEN '3–5 days'
    WHEN time_in_hospital BETWEEN 6 AND 10 THEN '6–10 days'
    ELSE '10+ days'
  END AS stay_range,
  COUNT(*) AS total,
  SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted,
  ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*)*100, 2) AS readmission_rate
FROM admission_summary
GROUP BY stay_range
ORDER BY readmission_rate DESC;

#admission type vs Readmission

SELECT 
    at.description AS admission_type,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN ad.readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
    SUM(CASE WHEN ad.readmitted = '>30' THEN 1 ELSE 0 END) AS readmitted_after_30,
    SUM(CASE WHEN ad.readmitted = 'NO' THEN 1 ELSE 0 END) AS not_readmitted,
    ROUND(SUM(CASE WHEN ad.readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate
FROM admission_diagnosis ad
LEFT JOIN admission_type at 
ON ad.admission_type_id = at.admission_type_id
GROUP BY at.description
ORDER BY readmission_rate DESC;

#Medication Patterns (from medications table)
#first convert medications table into long format

CREATE TABLE medications_long (
    patient_nbr BIGINT,
    medication VARCHAR(100),
    status VARCHAR(50)
);
INSERT INTO medications_long (patient_nbr, medication, status)
SELECT patient_nbr, 'metformin', metformin FROM medications
UNION ALL
SELECT patient_nbr, 'repaglinide', repaglinide FROM medications
UNION ALL
SELECT patient_nbr, 'nateglinide', nateglinide FROM medications
UNION ALL
SELECT patient_nbr, 'chlorpropamide', chlorpropamide FROM medications
UNION ALL
SELECT patient_nbr, 'glimepiride', glimepiride FROM medications
UNION ALL
SELECT patient_nbr, 'acetohexamide', acetohexamide FROM medications
UNION ALL
SELECT patient_nbr, 'glipizide', glipizide FROM medications
UNION ALL
SELECT patient_nbr, 'glyburide', glyburide FROM medications
UNION ALL
SELECT patient_nbr, 'tolbutamide', tolbutamide FROM medications
UNION ALL
SELECT patient_nbr, 'pioglitazone', pioglitazone FROM medications
UNION ALL
SELECT patient_nbr, 'rosiglitazone', rosiglitazone FROM medications
UNION ALL
SELECT patient_nbr, 'acarbose', acarbose FROM medications
UNION ALL
SELECT patient_nbr, 'miglitol', miglitol FROM medications
UNION ALL
SELECT patient_nbr, 'troglitazone', troglitazone FROM medications
UNION ALL
SELECT patient_nbr, 'tolazamide', tolazamide FROM medications
UNION ALL
SELECT patient_nbr, 'examide', examide FROM medications
UNION ALL
SELECT patient_nbr, 'citoglipton', citoglipton FROM medications
UNION ALL
SELECT patient_nbr, 'insulin', insulin FROM medications
UNION ALL
SELECT patient_nbr, 'glyburide_metformin', glyburide_metformin FROM medications
UNION ALL
SELECT patient_nbr, 'glipizide_metformin', glipizide_metformin FROM medications
UNION ALL
SELECT patient_nbr, 'glimepiride_pioglitazone', glimepiride_pioglitazone FROM medications
UNION ALL
SELECT patient_nbr, 'metformin_rosiglitazone', metformin_rosiglitazone FROM medications
UNION ALL
SELECT patient_nbr, 'metformin_pioglitazone', metformin_pioglitazone FROM medications;

SELECT * FROM medications_long LIMIT 50;

#medication prescription count
SELECT medication, COUNT(*) AS prescribed_count
FROM medications_long
WHERE status != 'No'
GROUP BY medication
ORDER BY prescribed_count DESC;

#Count of Patients with Dosage Changed
SELECT medication, 
       SUM(CASE WHEN status IN ('Up', 'Down') THEN 1 ELSE 0 END) AS dose_changed
FROM medications_long
GROUP BY medication
ORDER BY dose_changed DESC;

#number of medications per patient
CREATE TEMPORARY TABLE patient_med_count AS
SELECT 
    patient_nbr,
    COUNT(*) AS medication_count
FROM medications_long
WHERE status != 'No'
GROUP BY patient_nbr;

SELECT * FROM patient_med_count LIMIT 100;

#association between number of medications and readmission
SELECT 
  CASE 
    WHEN pmc.medication_count <= 1 THEN '0–1'
    WHEN pmc.medication_count BETWEEN 2 AND 3 THEN '2–3'
    ELSE '4+'
  END AS medication_range,
  COUNT(*) AS total_encounters,
  SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
  ROUND(SUM(CASE WHEN s.readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate
FROM admission_summary s
JOIN patient_med_count pmc USING (patient_nbr)
GROUP BY medication_range
ORDER BY 
  CASE 
    WHEN medication_range = '0–1' THEN 1
    WHEN medication_range = '2–3' THEN 2
    ELSE 3
  END;

#A1C vs Readmission

SELECT 
    A1Cresult,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
    ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate_30d
FROM admission_diagnosis
WHERE A1Cresult IS NOT NULL
GROUP BY A1Cresult
ORDER BY readmission_rate_30d DESC;

SELECT age, gender, admission_source, discharge_type, COUNT(*) AS total,
       SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
       ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END)/COUNT(*) * 100, 2) AS readmission_rate
FROM admission_summary
JOIN demographics USING (patient_nbr)
GROUP BY age, gender, admission_source, discharge_type
ORDER BY readmission_rate DESC;





  