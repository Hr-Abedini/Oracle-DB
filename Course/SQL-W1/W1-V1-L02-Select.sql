/*
SELECT *|{[DISTINCT] column [alias],...}
FROM table;
*/
------------------------------------------------ 
------------------------------------------------ Selecting All Columns
SELECT *
FROM DEPARTMENTS;


SELECT DEPARTMENT_ID,
	   DEPARTMENT_NAME,
	   MANAGER_ID,
	   LOCATION_ID
FROM DEPARTMENTS;

------------------------------------------------ Selecting Specific Columns
SELECT DEPARTMENT_ID,
	   LOCATION_ID
FROM DEPARTMENTS;

------------------------------------------------ Column Heading Defaults
SELECT LAST_NAME,
	   HIRE_DATE,
	   SALARY
FROM EMPLOYEES;

------------------------------------------------ Using Arithmetic Operators
SELECT LAST_NAME,
	   SALARY,
	   SALARY + 300
FROM EMPLOYEES;


SELECT LAST_NAME,
	   SALARY,
	   12 * SALARY + 100
FROM EMPLOYEES;


SELECT LAST_NAME,
	   SALARY,
	   12 * (SALARY + 100)
FROM EMPLOYEES;


SELECT LAST_NAME,
	   SALARY,
	   12 * SALARY + 100,
	   12 * (SALARY + 100)
FROM EMPLOYEES;

------------------------------------------------ Defining a Null Value
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY,
	   COMMISSION_PCT
FROM EMPLOYEES;

------------------------------------------------ Null Values in Arithmetic Expressions
SELECT LAST_NAME,
	   SALARY,
	   12 * SALARY * COMMISSION_PCT
FROM EMPLOYEES;

------------------------------------------------ Using Column Aliases
-- lower case
SELECT LAST_NAME AS name,
	   COMMISSION_PCT comm
FROM EMPLOYEES;


SELECT LAST_NAME "Name",
	   SALARY * 12 "Annual Salary"
FROM EMPLOYEES;

------------------------------------------------ Concatenation Operator
SELECT LAST_NAME || JOB_ID AS "Employees"
FROM Employees;

------------------------------------------------ Literal: character, number, date
------------------------------------------------ Using Literal Character Strings
SELECT LAST_NAME || ' is a ' || JOB_ID AS "Employee Details"
FROM EMPLOYEES;


SELECT LAST_NAME || ': 1 Month salary = ' || SALARY MONTHLY
FROM EMPLOYEES;

/*------------------------------------------------ quotation mark delimiter

You can choose any convenient delimiter, single-byte or multibyte, or any of the following
character pairs: [ ], { }, ( ), or < >.
*/
------------------------------------------------ Alternative Quote (q) Operator
SELECT DEPARTMENT_NAME || q'[ Department's Manager Id: ]' || MANAGER_ID AS "Department and Manager"
FROM DEPARTMENTS;

------------------------------------------------ Duplicate Rows
SELECT DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES;

------------------------------------------------ Displaying Table Structure
-- DESC[RIBE] tablename 
-- In Command windows
DESCRIBE EMPLOYEES
------------------------------------------------ Quiz 
-- err: Yearly Sal
/*
SELECT FIRST_NAME,
	   LAST_NAME,
	   JOB_ID,
	   SALARY * 12 AS Yearly Sal
FROM EMPLOYEES;
	*/

SELECT FIRST_NAME,
	   LAST_NAME,
	   JOB_ID,
	   SALARY * 12 AS "yearly sal"
FROM EMPLOYEES;

SELECT FIRST_NAME,
	   LAST_NAME,
	   JOB_ID,
	   SALARY AS "yearly sal"
FROM EMPLOYEES;

/*
SELECT FIRST_NAME + LAST_NAME AS name,
	   JOB_ID,
	   SALARY * 12 yearly sal
FROM EMPLOYEES;
*/
