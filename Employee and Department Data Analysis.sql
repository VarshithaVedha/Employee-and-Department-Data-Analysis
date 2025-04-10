create database case_study2
use case_study2
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50));

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);


INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

--Simple Queries:
--1. List all the employee details.
select * from Employee
--2. List all the department details.
select * from department
--3. List all job details.
select * from job
--4. List all the locations.
select * from location
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name, Last_Name, Salary, Comm from Employee
--6. List out the Employee ID, Last Name, Department ID for all employees and alias Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select employee_ID as "ID of the Employee", Last_Name as "Name of the Employee", Department_ID as Dep_id from Employee
--7. List out the annual salary of the employees with their names only.
select concat(First_Name, ' ', Last_Name) as Fullname, Salary * 12 as AnnualSalary from Employee

--WHERE Condition:
--1. List the details about "Smith".
select * from Employee where Last_Name = 'Smith'
--2. List out the employees who are working in department 20.
select * from Employee where Department_ID = 20
--3. List out the employees who are earning salary between 2000 and 3000.
select * from Employee where Salary between 2000 and 3000
--4. List out the employees who are working in department 10 or 20.
select * from Employee where Department_ID=10 or Department_ID=20
--5. Find out the employees who are not working in department 10 or 30.
select * from Employee where Department_ID not in (10, 30)
--6. List out the employees whose name starts with 'L'.
select * from Employee where First_Name like 'L%'
--7. List out the employees whose name starts with 'L' and ends with 'E'.
select * from Employee where First_Name like 'L%E' 
--8. List out the employees whose name length is 4 and start with 'J'.
select * from Employee where len(First_Name) = 4 and First_Name LIKE 'J%'
--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
select * from Employee where Department_ID = 30 and Salary > 2500
--10. List out the employees who are not receiving commission.
select * from Employee where Comm is null

--ORDER BY clause
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select Employee_ID, Last_Name from Employee ORDER BY Employee_ID ASC
--2. List out the Employee ID and Name in descending order based on salary.
select Employee_ID, CONCAT(First_Name, ' ', Last_Name) AS name FROM Employee ORDER BY Salary DESC
--3. List out the employee details according to their Last Name in ascending-order.
select * from Employee ORDER BY Last_Name ASC
--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select * from Employee ORDER BY Last_Name ASC, Department_ID DESC

--GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
select Department_ID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary 
from Employee
GROUP BY Department_ID
--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
select Job_ID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary 
from Employee 
GROUP BY Job_ID
--3. List out the number of employees who joined each month in ascending order.
select MONTH(Hire_Date) AS Month, YEAR(Hire_Date) AS Year, COUNT(*) AS NumEmployees 
FROM Employee
GROUP BY MONTH(Hire_Date), YEAR(Hire_Date) 
ORDER BY Year, Month
--4. List out the number of employees for each month and year in ascending order based on the year and month.
select MONTH(Hire_Date) AS Month, YEAR(Hire_Date) AS Year, COUNT(*) AS NumEmployees 
from Employee
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date) 
ORDER BY Year, Month
--5. List out the Department ID having at least four employees.
select Department_ID 
from Employee
GROUP BY Department_ID 
HAVING COUNT(*) >= 4
--6. How many employees joined in February month.
select COUNT(*) AS NumEmployees 
from Employee 
where MONTH(Hire_Date) = 2
--7. How many employees joined in May or June month.
select COUNT(*) AS NumEmployees 
from Employee
where MONTH(Hire_Date) IN (5, 6)
--8. How many employees joined in 1985?
select COUNT(*) AS NumEmployees 
from Employee 
where YEAR(Hire_Date) = 1985
--9. How many employees joined each month in 1985?
select MONTH(Hire_Date) AS Month, COUNT(*) AS NumEmployees 
from Employee 
where YEAR(Hire_Date) = 1985 
GROUP BY MONTH(Hire_Date)
--10. How many employees were joined in April 1985?
select COUNT(*) AS NumEmployees 
from Employee
where YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4
--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select Department_ID 
from Employee
where YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4 
GROUP BY Department_ID 
HAVING COUNT(*) >= 3

--Joins:
--1. List out employees with their department names.
SELECT Employee.*, Department.name
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
--2. Display employees with their designations.
SELECT Employee.*, Job.Designation
FROM Employee
INNER JOIN Job ON Employee.job_id = Job.job_id
--3. Display the employees with their department names and city.
SELECT Employee.*, Department.Name, Location.city
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
INNER JOIN Location ON Department.location_id = Location.location_id
--4. How many employees are working in different departments? Display with department names.
SELECT Department.name, COUNT(*) AS num_employees
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
GROUP BY Department.name
--5. How many employees are working in the sales department?
SELECT COUNT(*) AS num_employees
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
WHERE Department.name = 'Sales'
--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
SELECT Department.name
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
GROUP BY Department.name
HAVING COUNT(*) >= 3
ORDER BY Department.name ASC
--7. How many employees are working in 'Dallas'?
SELECT COUNT(*) AS num_employees
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
INNER JOIN Location ON Department.location_id = Location.location_id
WHERE Location.city = 'Dallas'
--8. Display all employees in sales or operation departments.
SELECT Employee.*, Department.name
FROM Employee
INNER JOIN Department ON Employee.department_id = Department.department_id
WHERE Department.name IN ('Sales', 'Operations')

--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT employee_id, first_name, last_name, salary,
    CASE
        WHEN salary < 2000 THEN 'Grade A'
        WHEN salary >= 2000 AND salary < 4000 THEN 'Grade B'
        WHEN salary >= 4000 AND salary < 6000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS grade
FROM Employee
--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT
    CASE
        WHEN Salary < 2000 THEN 'Grade A'
        WHEN Salary >= 2000 AND Salary < 4000 THEN 'Grade B'
        WHEN Salary >= 4000 AND Salary < 6000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS Grade,
    COUNT(*) AS NumEmployees
FROM Employee
GROUP BY 
    CASE
        WHEN Salary < 2000 THEN 'Grade A'
        WHEN Salary >= 2000 AND Salary < 4000 THEN 'Grade B'
        WHEN Salary >= 4000 AND Salary < 6000 THEN 'Grade C'
        ELSE 'Grade D'
    END
--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.
SELECT 
    CASE
        WHEN Salary >= 2000 AND Salary <= 5000 THEN 'Grade B'
        ELSE 'Other'
    END AS Grade,
    COUNT(*) AS NumEmployees
FROM Employee
GROUP BY 
    CASE
        WHEN Salary >= 2000 AND Salary <= 5000 THEN 'Grade B'
        ELSE 'Other'
    END

--Subqueries:
--1. Display the employees list who got the maximum salary.
SELECT * FROM Employee
WHERE Salary = (SELECT MAX(Salary) FROM Employee)
--2. Display the employees who are working in the sales department.
SELECT * FROM Employee
WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Sales')
--3. Display the employees who are working as 'Clerk'.
SELECT * FROM Employee
WHERE job_id = (SELECT job_id FROM Job WHERE Designation = 'Clerk')
--4. Display the list of employees who are living in 'Boston'.
select e.First_Name,e.Last_Name, l.city from location as l join department as d
	on l.location_id= d.location_id join employee as e
	on d.department_id=e.Department_Id
	where l.city='boston'
--5. Find out the number of employees working in the sales department.
select count(e.First_Name) as number_of_emp from department as d join employee as e
	on d.department_id=e.Department_Id
	where d.name='sales'
	group by e.First_Name 
--6. Update the salaries of employees who are working as clerks on the basis of 10%.
update employee
	set Salary=Salary*1.10
	where Job_Id = (select job_id from job
	where designation='clerk')
--7. Display the second highest salary drawing employee details.
select * from employee
  where Salary=( select max(Salary) from employee
				 where Salary< ( select MAX(Salary) from employee))
--8. List out the employees who earn more than every employee in department 30.
select * from employee
	where Salary =(
	select max(Salary) from employee
	where Department_Id=30)
--9. Find out which department has no employees.
select * from department
	where department_id not in( 
	select distinct Department_Id from  employee)
--10. Find out the employees who earn greater than the average salary for their department.
select top 1* from employee as e
where Salary>(select avg(Salary) from employee
				where Department_Id=e.Department_Id)
		order by Salary desc


