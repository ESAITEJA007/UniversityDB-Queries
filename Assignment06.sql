/*
// Name : Saiteja Enimidigandla
// Student ID: 999902573
// Student ID Name : SEnimidigandla3555
*/

-- Displaying databases --
show databases;
-- Part 1: Company Database
-- using company database

use company;

-- Display tables

show tables;

-- 1. Retrieve the highest and lowest salary of all employees who works for
-- ‘Research’ department

SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE, DEPARTMENT
WHERE DNO=DNUMBER AND DNAME='Research';

-- 2. For each project, list project name and the total hours of all employees who work
-- on the project

select Pname, SUM(Hours) FROM PROJECT, WORKS_ON 
WHERE Pnumber=Pno GROUP BY Pname;

-- Retrieve the names of employees who work on every project controlled by
-- department 4

SELECT fname, lname FROM employee
WHERE NOT EXISTS
(SELECT pnumber FROM project WHERE dnum=4
AND pnumber NOT IN
(SELECT pno FROM works_on WHERE ssn=essn));

-- Retrieve the names of employee who don’t work on project ‘Newbenefits’

SELECT Fname,lname FROM EMPLOYEE WHERE Ssn NOT IN (SELECT Essn FROM WORKS_ON join project on WORKS_ON.PNO = project.Pnumber WHERE project.Pname ="Newbenefits");

-- List the last names of male employees who are department managers

select fname,lname
from   employee
where sex="M" and ssn in (select mgrssn
               from department);
--                
-- Part 2:
-- Specify the following queries in SQL on the University database 
-- use university database               

use university;

-- Display Tables

show tables;

-- Retrieve the names of all courses taught by Professor Anderson in Fall 21.

SELECT DISTINCT Course.Course_name
FROM Course
JOIN Section
ON Course.Course_number = Section.Course_number
WHERE Section.Instructor = 'Anderson' and Section.Semester="Fall" and Section.Year=21;
 
-- Retrieve names of students who took Data Structures

 
SELECT STUDENT.Name FROM STUDENT
JOIN GRADE_REPORT
ON STUDENT.student_number = GRADE_REPORT.student_number
JOIN SECTION
ON GRADE_REPORT.Section_identifier = SECTION.Section_identifier
JOIN COURSE
ON COURSE.Course_Number = SECTION.Course_Number
WHERE COURSE.Course_Name = 'Data Structures' ;
 
-- Retrieve the names and major of students who never fail in any class

 
 SELECT DISTINCT Name, Major
FROM STUDENT
JOIN GRADE_REPORT
ON STUDENT.student_number = GRADE_REPORT.student_number
WHERE GRADE_REPORT.Grade != 'F';

-- For each section taught by Professor Anderson, retrieve the number of students
-- who took the section

SELECT Course_number, Semester, Year, COUNT(Student_number)
FROM SECTION INNER JOIN GRADE_REPORT ON SECTION.Section_identifier = GRADE_REPORT.Section_identifier
WHERE Instructor = 'Anderson' GROUP BY Course_number, Semester, Year;

-- Retrieve department names and the number of courses offered by each
-- department

select department, count(Course_name) from course group by department;