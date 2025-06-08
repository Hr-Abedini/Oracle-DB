--============================================================
-- **********  Using Subqueries to Solve Queries
--============================================================
/*
SELECT select_list
FROM   TABLE
WHERE  expr operator (SELECT select_list FROM   TABLE);

Types of Subqueries:
	 • Single-row subqueries: Queries that return only one row from the inner SELECT statement
	 • Multiple-row subqueries: Queries that return more than one row from the inner SELECT statement
*/

SELECT LAST_NAME,
	   HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > (
	 SELECT HIRE_DATE
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Davies'
   );

------------------------------------------------ Single-Row Subqueries
SELECT LAST_NAME,
	   JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = (
	 SELECT JOB_ID
	 FROM EMPLOYEES
	 WHERE EMPLOYEE_ID = 141
   );

------------------------------------------------ Executing Single-Row Subqueries
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE JOB_ID = (
	 SELECT JOB_ID
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Abel'
   )
   AND SALARY > (
	 SELECT SALARY
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Abel'
   );

--
-- ORA-01427: single-row subquery returns more than one row					 
--
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE JOB_ID = (
	 SELECT JOB_ID
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Taylor'
   )
   AND SALARY > (
	 SELECT SALARY
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Taylor'
   );

------------------------------------------------ Using Group Functions in a Subquery
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE SALARY = (
	 SELECT MIN(SALARY)
	 FROM EMPLOYEES
   );

------------------------------------------------ HAVING Clause with Subqueries				 
SELECT DEPARTMENT_ID,
	   MIN(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MIN(SALARY) > (
	 SELECT MIN(SALARY)
	 FROM EMPLOYEES
	 WHERE DEPARTMENT_ID = 30
   );


SELECT JOB_ID,
	   AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY) = (
	 SELECT MIN(AVG(SALARY))
	 FROM EMPLOYEES
	 GROUP BY JOB_ID
   );

------------------------------------------------ 
-- ORA-01427: single-row subquery returns more than one row
SELECT EMPLOYEE_ID,
	   LAST_NAME
FROM EMPLOYEES
WHERE SALARY = (
	 SELECT MIN(SALARY)
	 FROM EMPLOYEES
	 GROUP BY DEPARTMENT_ID
   );

------------------------------------------------ No Rows Returned by the Inner Query
SELECT LAST_NAME,
	   JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = (
	 SELECT JOB_ID
	 FROM EMPLOYEES
	 WHERE LAST_NAME = 'Haas'
   );
				 
------------------------------------------------ 
