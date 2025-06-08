/*
Single-Row Functions:

• Character functions: Accept character input and can return both character and number values
• Number functions: Accept numeric input and return numeric values
• Date functions: Operate on values of the DATE data type
• Conversion functions: Convert a value from one data type to another
• General functions: These functions take any data type and can also handle NULLs.


Character functions:
  Case-conversion -> LOWER, UPPER, INITCAP
  Character-manipulation -> CONCAT, SUBSTR, LENGTH, INSTR, LPAD | RPAD, TRIM, LTRIM | RTRIM, REPLACE

*/
------------------------------------------------ 
------------------------------------------------ Case-Conversion Functions
------------------------------------------------ 
SELECT LOWER('SQL Course'),
	   UPPER('SQL Course'),
	   INITCAP('SQL COURSE')
FROM DUAL d;


SELECT 'The job id for ' || UPPER(LAST_NAME) || ' is ' || LOWER(JOB_ID) AS "EMPLOYEE DETAILS"
FROM EMPLOYEES;

--***
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   UPPER(LAST_NAME),
	   LOWER(LAST_NAME),
	   INITCAP(LAST_NAME),
	   DEPARTMENT_ID
FROM EMPLOYEES;

------------------------------------------------ Using Case-Conversion Functions
-- 0 rows selected
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE LAST_NAME = 'higgins';


-- LOWER - 1 rows selected
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE LOWER(LAST_NAME) = 'higgins';


-- INITCAP - 1 rows selected
SELECT EMPLOYEE_ID,
	   UPPER(LAST_NAME),
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE INITCAP(LAST_NAME) = 'Higgins';

------------------------------------------------ Character-Manipulation Functions
SELECT LENGTH('HelloWorld'),
	   INSTR('HelloWorld', 'W'),
	   LPAD('last name', 12, '-'),
	   RPAD('first_name', 12, '-'),
	   CONCAT('Hello', 'World'),
	   SUBSTR('HelloWorld', 1, 5),
	   TRIM(' Hello World '),
	   LTRIM(' Hello World '),
	   RTRIM(' Hello World ')
FROM DUAL;


SELECT CONCAT(CONCAT(LAST_NAME, '''s job category is '), JOB_ID) "Job"
FROM EMPLOYEES
WHERE SUBSTR(JOB_ID, 4) = 'REP';


-- (-) => Right
SELECT EMPLOYEE_ID,
	   FIRST_NAME,
	   LAST_NAME,
	   CONCAT(FIRST_NAME, LAST_NAME) NAME,
	   LENGTH(LAST_NAME),
	   INSTR(LAST_NAME, 'a') "LastName -> Contains 'a'?"
FROM EMPLOYEES
WHERE SUBSTR(LAST_NAME, -1, 1) = 'n';

------------------------------------------------
------------------------------------------------ Nesting Functions
------------------------------------------------
SELECT LAST_NAME,
	   UPPER(CONCAT(SUBSTR(LAST_NAME, 1, 8), '_US'))
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

------------------------------------------------ 
------------------------------------------------ Numeric Functions
------------------------------------------------ 
SELECT CEIL(2.83),
	   ROUND(45.926, 2),
	   TRUNC(45.926, 2),
	   TRUNC(45.926), -- TRUNC(45.926,0),
	   FLOOR(2.83),
	   MOD(1600, 300)
FROM DUAL;

------------------------------------------------ Using the ROUND Function
-- (-) => right integer
SELECT ROUND(45.923, 2),
	   ROUND(45.923, 0), -- ROUND(45.923),
	   ROUND(45.923, -1)	   	   
FROM DUAL;


-- ***
SELECT ROUND(1234.923, -1),
	   ROUND(1234.923, -2), 
	   ROUND(1234.923, -3)	   	   
FROM DUAL;

------------------------------------------------ Using the TRUNC Function
-- (-) => right integer
SELECT TRUNC(45.923, 2),
	   TRUNC(45.923), -- TRUNC(45.923,0),
	   TRUNC(45.923, -1)
FROM DUAL;

------------------------------------------------ Using the MOD Function
SELECT EMPLOYEE_ID AS "Even Numbers",
	   LAST_NAME
FROM EMPLOYEES
WHERE MOD(EMPLOYEE_ID, 2) = 0;


