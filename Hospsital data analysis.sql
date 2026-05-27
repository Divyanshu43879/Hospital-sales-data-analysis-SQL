drop database if exists hospital_data;

create database hospital_data;

drop table if exists hospital_data;

create table hospital_data(
		Hospital_Name varchar(39) not null,
		Location varchar(20),
		Department varchar(45), 
		doctors_Count smallint,
		Patients_Count bigint,
		Admission_Date date,
		Discharge_Date date, 
		Medical_Expenses numeric(10,2));
select * from hospital_data


-- Show all columns from the hospital_data table.
select * from hospital_data 

-- List all unique hospital names.
select distinct(hospital_name) 
from hospital_data;

-- Get all records for the Cardiology department.
select * from hospital_data 
where department='Cardiology'

-- Show patients admitted in 'Lucknow' location.
select hospital_name,patients_count,
location 
from hospital_data 
where location='Lucknow';

-- Get records with medical expenses greater than ₹10,000.
select * from hospital_data
where medical_expenses>10000;

-- Find all records where admission and discharge occurred in the same month.
select extract(month from admission_date) as ad_mon,
extract(month from discharge_date) as dis_mon,
h.* 
from hospital_data h
where extract(month from admission_date)=extract(month from discharge_date);

-- Retrieve all records from the year 2023. 
select * from hospital_data 
where admission_date>'31-12-2022'

-- Show admissions after January 1st, 2023.
select * from hospital_data 
where admission_date>'01-01-2023'

-- List all departments available in a hospital named "City Hospital".
select distinct(department) 
from hospital_data 
where hospital_name='City Hospital'

-- Get records where medical expenses are missing or null.
select * from hospital_data 
where medical_expenses is null;



-- Total medical expenses per hospital.
select hospital_name, 
sum(medical_expenses) as expense  
from hospital_data 
group by hospital_name;


-- Average medical expenses per department.
select department,
avg(medical_expenses) as average 
from hospital_Data 
group by department;


-- number of patients admitted per department.
select sum(patients_count) as count,
department from hospital_data
group by department 
order by count 
desc;

-- Count of patients per location.
select location,sum(patients_count) as patient_location
from hospital_data 
group by location 
order by patient_location 
desc;

-- Total number of admissions in each year.
select extract(year from admission_date) as ad_year,
sum(patients_count) as patients_per_year
from hospital_data
group by extract(year from admission_date) 
order by extract(year from admission_date);

-- Get the department with the highest average expenses.
select sum(medical_expenses) as expense, 
department from hospital_data 
group by department 
order by sum(medical_expenses) desc 
limit 1;

-- Which hospital had the highest total expenses?
select hospital_name,
sum(medical_expenses) as expenses 
from hospital_data 
group by hospital_name 
order by expenses desc 
limit 1;

-- Which location had the most admissions?
select count(admission_date) as number_of_admission,
location from hospital_data group by location 
order by number_of_admission desc 
limit 1;

-- Average expenses for each hospital and department combination.
SELECT hospital_name, department, AVG(medical_expenses) AS expenses
FROM hospital_data
GROUP BY hospital_name, department
ORDER BY hospital_name DESC;


-- Count of admissions per month (based on admission_date).
select extract(month from admission_date) as month_of_admision,
count (admission_date) as ad_per_month
from hospital_data  
group by extract(month from admission_date) 
order by month_of_admision ;

-- Sum of expenses for patients discharged in 2023.
select sum(medical_expenses) as expenses,
extract(year from discharge_date) as year
from hospital_data 
group by year having extract(year from discharge_date)<=2023
order by expenses;

-- Max and min expense per hospital.
select hospital_name,max(medical_expenses) as maximum,
min(medical_expenses)as minimum 
from hospital_data 
group by hospital_name 

-- Average length of stay by department 
SELECT department, 
avg(discharge_date - admission_date) AS length 
FROM hospital_data group by department;

-- Which department in which hospital has the highest total expense?
select sum(medical_expenses) as expense,
hospital_name,department 
from hospital_data 
group by department,hospital_name
order by expense desc limit 1; 

-- Number of admissions per day (date-wise breakdown).

select extract(day from admission_date) as day,
count(admission_date) as per_day_admission
from hospital_data
group by day 
order by day;

-- Calculate length of stay for each record.
select h.*,(discharge_date-admission_date) as stay from hospital_data h; 

-- Show all records with length of stay > 10 days.
select h.*,(discharge_date-admission_date) as stay 
from hospital_data h 
where (discharge_date-admission_date)>10;

-- Show patients admitted in February 2025.
select h.*,
date_part('month',admission_date) as month 
from hospital_data h
where date_part('month',admission_date)=2

-- Count how many patients were admitted on weekends.
select h.*,
date_part('dow',admission_date) as week_days 
from hospital_data h
where date_part('dow',admission_date) in (0,6);

-- Calculate average length of stay per hospital.
select hospital_name,
avg(discharge_date-admission_date) as average
from hospital_data 
group by hospital_name 
order by average 
desc;

-- Group expenses by quarter of admission.
select
sum(medical_expenses) as expenses,
date_part('quarter',admission_date) 
from hospital_data h
group by date_part('quarter',admission_date);

-- Find earliest and latest admission date per department.
select 


-- Which month had the highest number of admissions?
select sum(patients_count) as patients,
date_part('month',admission_date)as month
from hospital_data 
group by date_part('month',admission_date) order by month asc;

-- Find average daily expenses per patient (expenses ÷ length of stay).
select (sum(medical_expenses)/sum(patients_count))as daily_expense from hospital_data 

-- Count discharges by weekday name (e.g., Monday, Tuesday).
select count(discharge_date) as count,
date_part('dow',discharge_date) as dow
from hospital_data
group by date_part('dow',discharge_date)
having date_part('dow',discharge_date) in(1,2);


