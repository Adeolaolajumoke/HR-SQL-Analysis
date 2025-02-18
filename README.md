# HR Analysis SQL 

![Screenshot 2025-02-18 104531](https://github.com/user-attachments/assets/1397702a-3e0f-4085-ba82-1f32ab4f18f9)

## Table of Content 
- [Introduction](#Introduction)
- [Project Overview](#Project-Overview)
- [Project Objectives](#Project-Objectives)
- [Data Cleaning and Transformation](#Data-Cleaning-and-Transformation)
- [Data Exploration and Insight](#Data-Exploration-and-Insights)
- [Files Detail](#Files-Details)
- [Conclusion](#Conclusion)

## Introduction: 
The HR dataset contains detailed records of employees within an organization, capturing various demographic, job, and performance-related information. 
It serves as a valuable resource for Human Resources (HR) professionals and analysts to gain insights into the workforce, identify trends, and
make data-driven decisions about hiring, employee retention, performance management, and overall organizational development.

## Project-Overview
The dataset includes the following 22,214 rows and 13 columns which are: ID, First_name,Last_name, Birthdate, Gender, Race, Department, Job title, Location, Hire_date,
Term_date,Location_city, Location_state.
![Screenshot 2025-02-18 110311](https://github.com/user-attachments/assets/5308fc9b-13ec-446e-9396-bf2430034758)


## Project-Objectives
1.	What is the gender breakdown in the Company? 
2.	How many employees work remotely for each department? 
3.	What is the distribution of employees who work remotely and HQ 
4.	What is the race distribution in the Company? 
5.	What is the distribution of employee across different states? 
6.	What is the number of employees whose employment has been terminated 
7.	Who is/are the longest serving employee in the organization. 
8.	Return the terminated employees by their race 
9.	What is the age distribution in the Company? 
10.	How have employee hire counts varied over time? 
11.	What is the tenure distribution for each department? 
12.	What is the average length of employment in the company? 
13.	Which department has the highest turnover rate?

## Data-Cleaning-and-Transformation
-- Rename Table
```sql
Rename table `Hr Data` to HR_DATA;
Alter table HR_DATA
Rename column `ï»¿id` to Company_Id;
```
```sql
SET SQL_SAFE_UPDATES=0;
```
-- Replace
```sql
Update Hr_data
set Birthdate= replace (birthdate, "-","/");
Update Hr_data
set Hire_date= replace (Hire_date, "-","/");
```
-- Change date format
```sql
update Hr_data
set birthdate = str_to_date(birthdate, "%m/%d/%Y");
Update Hr_data
set birthdate= date_sub(birthdate, interval 100 year) 
where year (birthdate)>2002;
update Hr_data
set Hire_date = str_to_date(hire_date, "%m/%d/%Y");
Alter table Hr_data
modify column birthdate date;
Alter table Hr_data 
modify column hire_date date;
```
-- Add column 
```sql
alter table Hr_data
 add column Name Text;
 update Hr_data
 set Name= concat(first_name, “-“, last_name);
alter table Hr_data
add column age int;
update Hr_data
set age = floor(datediff(current_date(), birthdate)/365);
select case 
          when age <30 then "20-29"
          when age < 40 then "30-39"
          when age < 50 then "40-49"
          else "50-59" end as Age_group, count(*) as Age_Distribution from hr_data
          group by Age_group 
          order by Age_Distribution desc;
alter table Hr_data
add column Tenure int;
update Hr_data
set tenure = round(avg(datediff(current_date(), hire_date)/365),1);
```

## Data-Exploration-and-Insights
1.	What is the gender breakdown in the Company? 
Insight:
Male: 11288 
Female: 10321 
Non-confirming: 605
2.	How many employees work remotely for each department? 
Insight: 
Product management: 157 
Legal: 63, Accounting: 859 
Business development: 410 
Human resource: 467 
Engineering: 1616 
Training: 420 
Sales: 467 
Service: 407 
Support: 230 
Research and development: 282 
Marketing: 111 
Auditing: 10 
3.	What is the distribution of employees who work remotely and HQ 
Insight: Remote: 5499, Head-quarters: 16715
4.	What is the race distribution in the Company?
Insight: 
Hispanic or Latino: 2501 
White: 6328, Black or African American: 3619 
Two or more races: 3648 
Asian: 3562 
American Indian or Alaska native: 1327 
Native Hawaiian or other Pacific Islander: 1229  
5.	What is the distribution of employee across different states? 
Insight: 
Ohio: 18025
Michigan: 673 
Pennsylvanian: 1115 
Wisconsin: 382 
Illinois: 868 
Indiana: 700 
Kentucky: 451
6.	What is the number of employees whose employment has been terminated 
Insight: 2662
7.	Who is/are the longest serving employee in the organization.
Insight: Guendolen-Neles 2000-10-17  
8.	Return the terminated employees by their race 
Insight: 
White: 759
Black or African American: 437 
Two or more races: 437 
Asian: 432 
Hispanic or Latino: 278 
Native Hawaiian or other Pacific Islander: 164 
American Indian or Alaska native: 155
9.	What is the age distribution in the Company?
Insight: 
30-39: 6152
40-49: 5885
50-59: 5599 
20-29: 4578
10.	How have employee hire counts varied over time? 
Insight:
2000-2005: 5783
2006-2010: 5555
2016-2020: 5455
2011-2015: 5421
11.	What is the tenure distribution for each department? 
Insight: 
Product management: 14.5
Legal:14.0 
Accounting: 14.3 
Business development: 14.3 
Human resource: 14.4 
Engineering: 14.4 
Training: 14.5 
Sales:14.2 
Service: 14.2 
Support: 14.2 
Research and development: 14.3 
Marketing: 13.8 
Auditing: 15.5
12.	What is the average length of employment in the company? 
Insight: 14.31

## Files-Details
- HR Dataset.csv: The raw data used for analysis
- Problem Statement- HR SQL Question Pratice.pdf: Project overview and objectives
- Query.sql: SQL queries used to extract and analyze the data
- README.md: Documentation for the project

## Conclusion
The dataset reveals that the company has a fairly balanced and diverse workforce, with a significant number of employees working remotely, 
especially in departments like Engineering and Business Development. There is a strong age and racial diversity present, 
though some disparities in termination rates across racial groups merit further investigation. 
The company has a considerable number of long-tenured employees, particularly in departments like Auditing, and an average employee tenure of over 14 years,
which highlights a relatively stable workforce.
The recommendations focus on improving inclusivity, optimizing remote work policies, retaining diverse talent, 
and addressing termination patterns to ensure a fair and supportive workplace. Additionally, 
focusing on career development and mentorship programs will help retain both older and younger employees, ultimately contributing to long-term employee satisfaction and
organizational growth.
