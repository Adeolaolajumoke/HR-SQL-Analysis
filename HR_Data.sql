Create Database SQL_Projects;

select * from `HR DATA`;
Rename table `Hr Data` to HR_DATA;

Alter table HR_DATA
Rename column `ï»¿id` to Company_Id;

SET SQL_SAFE_UPDATES=0;
Update Hr_data
set Birthdate= replace (birthdate, "-","/");

Update Hr_data
set Hire_date= replace (Hire_date, "-","/");

update Hr_data
set birthdate = str_to_date(birthdate, "%m/%d/%Y");

Update Hr_data
set birthdate=  date_sub(birthdate, interval 100 year) 
where year (birthdate)>2002;

update Hr_data
set Hire_date = str_to_date(hire_date, "%m/%d/%Y");

Alter table  Hr_data
modify column birthdate date;

Alter table Hr_data 
modify column hire_date date; 

-- 1.	What is the gender breakdown in the Company? 
select gender, count(gender) as gender_breakdown from Hr_data 
group by gender;

-- 2.	How many employees work remotely for each department? 
select department, count(Location) as employee_locat from Hr_data 
where location = "Remote" group by department;
 
-- 3.	What is the distribution of employees who work remotely and HQ 
select location, count(location) as count from HR_DATA
GROUP BY LOCATION ORDER BY COUNT;

-- 4.	What is the race distribution in the Company? 
select race, count(company_id) as no_dis from Hr_data 
group by race;

-- 5.	What is the distribution of employee across different states? 
select location_state, count(company_id) as em_dis from Hr_data 
group by location_state;

-- 6.	What is the number of employees whose employment has been terminated
 Select count(date(termdate)) as terminated_employees from hr_data 
 where date(termdate) <= current_date();
 
 alter table Hr_data
 add column Name Text;
 
 Set SQL_SAFE_UPDATES=0;
 update Hr_data 
 set Name= concat(first_name,"-", last_name);
-- 7.	Who is/are the longest serving employee in the organization.
select name, min(hire_date) as longest_employee from Hr_data
group by name
order by longest_employee ASC;
 
-- 8.	Return the terminated employees by their race 
select race, count(race) as count from hr_data
where date(termdate) <= current_date()
group by race
order by count desc;

-- 9.	What is the age distribution in the Company? 
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

-- 10.	How have employee hire counts varied over time? 
select case 
          when year (hire_date) <= 2005 then "2000-2005"
          when year (hire_date) <= 2010 then "2006-2010"
          when year (hire_date) <= 2015 then "2011-2015"
          when year (hire_date) <= 2020 then "2016-2020"
	end as Hire_year_group, count(*) as count_overtime from HR_DATA
    Group by Hire_year_group order by count_overtime desc;
    
-- 11.	What is the tenure distribution for each department? 
alter table Hr_data
add column Tenure int;
update Hr_data
set tenure = round(avg(datediff(current_date(), hire_date)/365),1);

select department, round(avg(datediff(current_date(), hire_date)/365),1) from Hr_data
group by 1
order by 2 desc;

-- 12.	What is the average length of employment in the company? 
select round(avg(datediff(current_date(), hire_date)/365),2) as avg_employemnt from Hr_data;

-- 13.	Which department has the highest turnover rate? 

Select * from Hr_data;