/*************************************************
Restricting and Sorting Data
*************************************************/
/*
SELECT *|{[DISTINCT] column [alias],...}
FROM table
[WHERE logical expression(s)];
*/

------------------------------------------------ Using the WHERE Clause
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

------------------------------------------------ Character Strings and Dates
SELECT LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE LAST_NAME = 'Whalen';


SELECT LAST_NAME
FROM EMPLOYEES
WHERE HIRE_DATE = '17-OCT-03';


SELECT LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE LAST_NAME = 'WHALEN';

------------------------------------------------ Using Comparison Operators
SELECT LAST_NAME,
	   SALARY
FROM EMPLOYEES
WHERE SALARY <= 3000;

------------------------------------------------ Range Conditions Using the BETWEEN Operator
SELECT LAST_NAME,
	   SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 2500 AND 3500;


-- character values
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME BETWEEN 'King' AND 'Whalen';

------------------------------------------------ Using the IN Operator
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   SALARY,
	   MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN (100, 101, 201);


SELECT EMPLOYEE_ID,
	   MANAGER_ID,
	   DEPARTMENT_ID
FROM EMPLOYEES
WHERE LAST_NAME IN ('Hartstein', 'Vargas');

------------------------------------------------ Pattern Matching Using the LIKE Operator
/*
% denotes zero or more characters.
_ denotes one character.

wildcard characters (%, _)
*/
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';


SELECT LAST_NAME,
	   HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%05';


SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '_o%';

------------------------------------------------ Using NULL Conditions
SELECT LAST_NAME,
	   MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;


SELECT LAST_NAME,
	   JOB_ID,
	   COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

----------  No Output
SELECT LAST_NAME,
	   JOB_ID,
	   COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT = NULL;
------------------------------------------------ Using the AND Operator
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000
  AND JOB_ID LIKE '%MAN%';

------------------------------------------------ Using the OR Operator
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000
  OR JOB_ID LIKE '%MAN%';

------------------------------------------------ Using the NOT Operator
SELECT LAST_NAME,
	   JOB_ID
FROM EMPLOYEES
WHERE JOB_ID
  NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

------------------------------------------------ Rules of Precedence
SELECT LAST_NAME,
	   DEPARTMENT_ID,
	   SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60
  OR DEPARTMENT_ID = 80
  AND SALARY > 10000;


SELECT LAST_NAME,
	   DEPARTMENT_ID,
	   SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID = 60  OR DEPARTMENT_ID = 80)
  AND SALARY > 10000;

------------------------------------------------ Using the ORDER BY Clause
/*
Syntax
SELECT expr
FROM table
[WHERE condition(s)]
[ORDER BY {column, expr, numeric_position} [ASC|DESC]];
*/

SELECT LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID,
	   HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE;


SELECT LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID,
	   HIRE_DATE
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID DESC;


SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   SALARY * 12 ANNSAL
FROM EMPLOYEES
ORDER BY annsal;


SELECT LAST_NAME,
	   JOB_ID,
	   DEPARTMENT_ID,
	   HIRE_DATE
FROM EMPLOYEES
ORDER BY 3;


SELECT LAST_NAME,
	   DEPARTMENT_ID,
	   SALARY
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID,
		 SALARY DESC;


------------------------------------------------ *** Null FIRST,LAST
SELECT LAST_NAME,
	   DEPARTMENT_ID	   
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID
  NULLS FIRST;


SELECT LAST_NAME,
	   DEPARTMENT_ID	   
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID
  NULLS LAST;

