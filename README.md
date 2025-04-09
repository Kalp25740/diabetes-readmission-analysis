# 🏥 Diabetes Hospital Encounters Analysis Using SQL

## 📌 Project Overview

This SQL project explores a comprehensive dataset of diabetic patient hospital encounters to identify patterns in readmissions, medication usage, and demographic risk factors. Using **MySQL Workbench**, the project transforms raw CSV data into a normalized relational database and performs detailed descriptive analysis with a focus on **readmission rates**.

---

## 🛠️ Tools & Technologies
- **Database**: MySQL 8.0+
- **Tool**: MySQL Workbench
- **Dataset**: Diabetes 130-US hospitals for years 1999–2008 (~100,000 records)

---

## 🗃️ Schema Overview

The database is normalized into the following main tables:

- `admission_summary`: encounter-level info including readmission status and admission source
- `demographics`: patient-level info like age, race, gender, and weight
- `admission_diagnosis`: includes diagnosis codes, A1C results, and admission type
- `admission_events`: contains number of procedures, emergency visits, and hospital stay duration
- `medications`: original wide-format medication columns
- `medications_long`: long-format table with one medication per row per patient
- Lookup Tables: `admission_type`, `discharge_disposition`, `admission_source`

---

## 📊 Key Analyses Performed

### 🔹 Demographics
- Gender and race distribution
- Readmission rates by **gender** and **race**

### 🔹 Clinical Factors
- Readmission rates by **A1C test result**
- Relationship between **number of medications** and readmission

### 🔹 Admissions
- Readmission patterns by **admission type**, **admission source**, and **discharge disposition**
- Hospital stay duration vs. admission source

### 🔹 Medications
- Most commonly prescribed diabetes medications
- Number of medications per patient (binned) vs. readmission

---

## 🧪 Sample Query: A1C Results vs Readmission
```sql
SELECT 
    A1Cresult,
    COUNT(*) AS total_encounters,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_within_30,
    ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS readmission_rate_30d
FROM admission_diagnosis
GROUP BY A1Cresult;

## 🧠 Lessons Learned

- Designing normalized schemas upfront improves both speed and clarity of analysis
- Long-format tables make aggregation and filtering much simpler
- Readmission is strongly correlated with factors like high A1C, multiple medications, and specific discharge types

---

## 🚀 Future Enhancements

- Export data for visualization using Python or Tableau
- Create stored procedures and reusable views
- Build a predictive model to estimate readmission risk
