-- what is the gender breakdown of employee in the company?

select gender,count(*) as total_count
from hr
where age>=18 and termdate ='0000-00-00'
group by gender;


select *from hr;

-- what is the race/etnicity breakdown of employeee in the compnay

select race,count(*) as total_race_count
from hr
where age>=18 and termdate ='0000-00-00'
group by 1
order by 2 desc;

-- what is the age distribution of employee in the company 
select 
 min(age) as youngest,
 max(age) as oldest
from hr
where age>=18 and termdate ='0000-00-00';


select 
case when  age>=18 and age<=24 then '18-24'
 when  age>=25 and age<=34 then '25-34'
 when  age>=35 and age<=44 then '35-44'
 when  age>=45 and age<=54 then '45-44'
when  age>=55 and age<=64 then '55-64'
else '65+'
end as age_group,
count(*) as total_count
from hr
where age>=18 and termdate ='0000-00-00'
group by 1
order by 2;

select 
case when  age>=18 and age<=24 then '18-24'
 when  age>=25 and age<=34 then '25-34'
 when  age>=35 and age<=44 then '35-44'
 when  age>=45 and age<=54 then '45-44'
when  age>=55 and age<=64 then '55-64'
else '65+'
end as age_group,gender,
count(*) as total_count
from hr
where age>=18 and termdate ='0000-00-00'
group by 1,gender
order by 2,gender;

-- how many employee work at headquarters versus remote locateion

select location,count(*) as total_count
from hr
where age>=18 and termdate ='0000-00-00'
group by 1;

-- what is the average length of employee fro employee who have been terminated

select  
round(avg(datediff(termdate,hire_date))/365,0) as avg_length_employee
from hr
where termdate<=curdate() and termdate<>'0000-00-00' and age>=18;


-- 6 how does the gender distribution vary across department and job title?
select department, gender, count(*) as total_count
from hr 
where age >=18 and termdate='0000-00-00'
group by 1,2
order by 1;


-- what is the d distribution of job title across the company;
select jobtitle,  count(*) as total_count
from hr 
where age >=18 and termdate='0000-00-00'
group by 1
order by 1 desc;

-- which department has the highest turnover rate?
select department,total_count,
terminated_count,
terminated_count/total_count as termination_rate
from (select department,  count(*) as total_count,
sum(case when termdate <> '0000-00-00' and termdate <=curdate() then 1 else 0 end) as terminated_count
from hr
where age >=18 
group by 1) as subquery
order by termination_rate desc;

-- 9 . what is the distribution of employee across location by  city and state
select location_state, count(*) as total_count
from hr
where age >=18 and termdate='0000-00-00'
group by 1
order by 2 desc;

-- 10. how has the compnay emplyee count change over time based on hire and term dates?
select
year,
hires,
terminations,
hires - terminations as net_change,
round((hires - terminations)/hires*100,2) as net_change_percent 
from (
     select year(hire_date) as year,
     count(*) as hires,
     sum(
         case 
             when termdate<>'0000-00-00' and termdate <=curdate() then 1 else 0 end) as terminations
from hr
where age >=18
group by year(hire_date)
) as subquery
order by year;


-- 11. what is the tenure distribution fro each department

select department,
round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<>'0000-00-00' and termdate <=curdate() and age>=18
group by 1;