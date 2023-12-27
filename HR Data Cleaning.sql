use project;

select *from hr;


-- data cleaning 
alter table hr
change column ï»¿id emp_id varchar(20) null;


update project.hr
set birthdate=
	case when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
         when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    else null
    end;
    
alter table project.hr
modify column birthdate date;    
    
describe project.hr;

update project.hr
set hire_date=
	case when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
         when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    else null
    end;
    
UPDATE project.hr
SET termdate = DATE_FORMAT(termdate, '%Y-%m-%d')
WHERE termdate IS NOT NULL AND termdate != ' ';

alter table project.hr
modify column termdate date ; 




UPDATE project.hr
SET termdate = DATE_FORMAT(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'), '%Y-%m-%d')
WHERE termdate IS NOT NULL AND termdate != '' AND termdate != ' ';

update project.hr
set termdate='0000-00-00'
where termdate is null;



select termdate from hr;

alter table hr
add column age int;

update hr
set age =timestampdiff(year,birthdate,curdate());


select birthdate,age,termdate from hr;

select 
 min(age) as youngest,
 max(age) as oldest
from hr; 

select count(*) from hr
where age<18;
