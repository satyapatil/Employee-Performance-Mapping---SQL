/* ScienceQtech Employee Performance Mapping */

/* 1. Create a database named employee, then import data_science_team.csv, proj_table.csv and emp_record_table.csv into the employee database from the given resources. */
create database employee;
use employee;
# Import all datasets using Table data import wizard
 
/* 2. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.*/
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, dept from employee.emp_record_table;

/* 3. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, dept, emp_rating from emp_record_table
where emp_rating <2;
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, dept, emp_rating from emp_record_table
where emp_rating >4;  
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, dept, emp_rating from emp_record_table
where emp_rating between 2 & 4

/* 4. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME. */
select concat(first_name, " ", last_name) as Name, dept from emp_record_table
WHERE dept ="Finance"; 

/* 5. Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).*/
select * from emp_record_table
WHERE role in ("president","MANAGER"); 

/* 6. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.*/
select first_name, last_name, dept from emp_record_table
where dept = "healthcare"
union 
select first_name, last_name,dept  from emp_record_table
where dept = "finance";

/* 7. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee 
rating along with the max emp rating for the department.*/
 select EMP_ID, FIRST_NAME, LAST_NAME,ROLE, DEPT, EMP_RATING, max(emp_rating) as Deptwise_rating from emp_record_table group by dept order by emp_rating desc;          
          
/* 8. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table. */
select role, max(salary),min(salary) from emp_record_table
group by role;      
          
/* 9. Write a query to assign ranks to each employee based on their experience. Take data from the employee record table. */         
select concat(first_name, " ", last_name) as full_name , exp,
RANK() over ( order by exp desc) as experience_on_rank
from emp_record_table
order by exp desc;    
 
/* 10. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table. */
CREATE VIEW view_name as 
SELECT emp_id, country, salary 
FROM emp_record_table
WHERE salary >6000
order by salary;
      
/* 11. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table. */     
select* from emp_record_table
where emp_id in ( select emp_id from emp_record_table where exp>10);	
    
/* 12. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table. */
delimiter &&
create procedure get_mid_experience()
begin
select * from emp_record_table where exp> 3;
end &&
call get_mid_experience();

 /* 13. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard. 
1.For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
2.For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
3.For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
4.For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
5.For an employee with the experience of 12 to 16 years assign 'MANAGER'.  */

delimiter &&
create procedure Jobprofile(exp int)
begin
SELECT FIRST_NAME,last_name, role, exp,
case 
when exp <=2 THEN "JUNIOR DATA SCIENTIST"
when  exp between 2 and 5  THEN "ASSOCIATE DATA SCIENTIST"
WHEN exp between 5 and 10 THEN "SENIOR DATA SCIENTIST"
WHEN exp between 10 and 12 THEN "LEAD DATA SCIENTIST"
WHEN exp between 12 and 16 THEN "MANAGER"
ELSE "Not assign value"
END as role_assign 
FROM emp_record_table;

/* 14. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan. */
create index index_name
on emp_record_table (first_name);
  
/* 15. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating). */
select *, ((0.05*salary) * EMP_rating) as bouns FROM emp_record_table order by ((0.05*salary) * EMP_rating)  desc ; 
 
 
 /* 16. Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.*/ 
select continent , country, avg(salary) as Avg
from emp_record_table
group by continent , country
order by avg(salary) desc;
