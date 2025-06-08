--============================================================
-- **********  Managing Tables Using DML Statements
--============================================================
/*
Data Manipulation Language (DML)
• A DML statement is executed when you:
    – Add new rows to a table
    – Modify existing rows in a table
    – Remove existing rows from a table
• A transaction consists of a collection of DML statements that form a logical unit of work.

*/
------------------------------------------------ Inserting New Rows
/*

INSERT INTO table [(column [, column...])]
VALUES (value [, value...]);

*/
INSERT INTO Departments
   (
     Department_id,
     Department_name,
     Manager_id,
     Location_id
   )
VALUES
   (
     70,
     'Public Relations',
     100,
     1700
   );

-- DESCRIBE departments   
------------------------------------------------ Inserting Rows with Null Values
--Implicit method: Omit the column from the column list.
INSERT INTO Departments
   (
     Department_id,
     Department_name
   )
VALUES
   (
     30,
     'Purchasing'
   );

------
-- OR 
------
--Explicit method:Specify the NULL keyword in the VALUES clause.
INSERT INTO Departments
VALUES
   (
     100,
     'Finance',
     NULL,
     NULL
   );
------------------------------------------------ Inserting Special Values
INSERT INTO Employees
   (
     Employee_id,
     First_name,
     Last_name,
     Email,
     Phone_number,
     Hire_date, /****/
     Job_id,
     Salary,
     Commission_pct,
     Manager_id,
     Department_id
   )
VALUES
   (
     113,
     'Louis',
     'Popp',
     'LPOPP',
     '515.124.4567',
     Current_date, /****/
     'AC_ACCOUNT',
     6900,
     NULL,
     205,
     110
   );

------------------------------------------------ Inserting Specific Date and Time Values
INSERT INTO Employees
VALUES
   (
     114,
     'Den',
     'Raphealy',
     'DRAPHEAL',
     '515.127.4561',
     To_Date('FEB 3, 2003', 'MON DD, YYYY'), /****/
     'SA_REP',
     11000,
     0.2,
     100,
     60
   );

------------------------------------------------ Creating a Script "&"
--  ORA-01008: not all variables bound
INSERT INTO Departments
   (
     Department_id,
     Department_name,
     Location_id
   )
VALUES
   (
     &Department_id,
     '&department_name',
     &Location
   );

------------------------------------------------ Copying Rows from Another Table
INSERT INTO Sales_reps
   (
     Id,
     Name,
     Salary,
     Commission_pct
   )
SELECT Employee_id,
       Last_name,
       Salary,
       Commission_pct
FROM Employees
WHERE Job_id LIKE '%REP%';

------------------------------------------------  create table
-- ORA-00942: table or view does not exist
--create table copy_emp as ( select * from employees where 1=0);

INSERT INTO Copy_emp
SELECT *
FROM Employees;


--DROP TABLE Copy_emp;