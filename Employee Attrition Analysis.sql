use hr_analytics;

SELECT * FROM HR_1;

SELECT * FROM HR_2;

-- Total Employees
select count(distinct(employeenumber)) as Total_employees 
from hr_1;

-- Employees by gender
select gender,count(distinct(EmployeeNumber)) as Employee_count 
from hr_1 
group by gender;

-- Attrition count
select count(attrition) as Attrition_count 
from hr_1
where Attrition='yes';

-- Attrition rate
select concat(format(avg(a.Attrition_yes)*100,2),"%") as Attrition_rate
from
(select attrition,
       case
       when attrition='yes' 
       then 1 
       else 0
       end as attrition_yes
from hr_1) as a;

-- Gender wise attrition rate
select a.gender,(concat(round(avg(a.attrition_yes)*100,2),"%")) as Attrition_rate
 from 
(select gender,attrition,
case 
when Attrition='yes' 
then 1 
else 0 
end as attrition_yes from hr_1) as a
group by gender;

-- Department wise attrition rate
select a.Department,CONCAT(ROUND(AVG(a.attrition_yes) * 100), '%') AS Attrition_rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
else 0
end as attrition_yes from hr_1 ) as a
group by a.department;

-- Average Hourly rate of Male Research Scientist
select jobrole,format(avg(hourlyrate),2) as Hourly_Rate,gender
from hr_1 
where jobrole='research scientist' and gender='male';
 
-- Attrition rate Vs Monthly income status
 select a.department,
 concat(round(avg(attrition_yes)*100),"%") as attrition_rate,
 CONCAT(round(AVG(b.monthlyincome) / 1000), 'K') AS AVG_monthlyincome_k
 from(select department,attrition,employeenumber,
 case 
 when attrition='yes'
 then 1
 else 0 
 end as attrition_yes from hr_1)as a
 join
 hr_2 as b on a.employeenumber=b.employeeid
 group by a.department;
 
 -- Average working years for each Department
 select department,format(avg(totalworkingyears),0) as Avg_workingyears
 from 
 hr_1 join hr_2  on hr_1.employeenumber=hr_2.employeeid 
 group by department;
 
 -- Job Role Vs Work life balance
 select jobrole,round(avg(worklifebalance),2) as Avg_worklifebalance
 from
 hr_1  join hr_2 on hr_1.EmployeeNumber=hr_2.employeeid
 group by jobrole;
 
 -- Work life balance across Job Roles
 SELECT 
    jobrole,
    CASE worklifebalance
        WHEN 1 THEN 'Poor'
        WHEN 2 THEN 'Average'
        WHEN 3 THEN 'Good'
        WHEN 4 THEN 'Excellent'
        ELSE 'Unknown'
    END AS WorkLifeBalance_Label
FROM hr_1 
JOIN hr_2 
    ON hr_1.EmployeeNumber = hr_2.EmployeeID;
    
 -- Relationship between attrition and years since last promotion
 select Attrition,
count(*) as Total_Employees,
round(avg(YearsSinceLastPromotion),2) as avg_years_since_promotion,
min(YearsSinceLastPromotion) as min_years_since_promotion,
max(YearsSinceLastPromotion) as max_years_since_promotion
from hr_1 h inner join hr_2 q
on h.EmployeeNumber = q.EmployeeID
group by Attrition;

-- Average salary of each job role 
 SELECT 
    jobrole,
    CONCAT(FORMAT(AVG(monthlyincome) / 1000, 2), 'K') AS Avg_monthlyincome_k
FROM hr_1 
JOIN hr_2 
    ON hr_1.EmployeeNumber = hr_2.EmployeeID
GROUP BY jobrole;
 
-- Attrition count by Marital status
select MaritalStatus, count(attrition) as Att_C
 from hr_1 where attrition='yes'
 group by MaritalStatus;
 
  -- Average job satisfaction by department
 select department,gender,format(avg(jobsatisfaction),2) as Job_satisfaction 
 from hr_1
 group by department,gender order by department,gender ;
 
 -- Performance rating by Department
 select Department,format(avg(performancerating),1) as Avg_performancerating
 from hr_1 join hr_2 on hr_1.EmployeeNumber=hr_2.EmployeeID
 group by department;
 
 
