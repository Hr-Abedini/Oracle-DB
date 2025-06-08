--============================================================
-- Retrieving Data by Using Subqueries
--============================================================
-- The inner query is similar to that of a database view but does not have any physical name.
SELECT t1.department_name,
	   t2.city
FROM   departments t1
NATURAL JOIN 
   (
	   SELECT l.location_id,
			   l.city,
			   l.country_id
		FROM   locations l
		Inner JOIN   countries c
			ON     (l.country_id = c.country_id)
		Inner JOIN   regions
			USING  (region_id)
		WHERE  region_name = 'Europe'
	) t2;
	
-------------------------------------------------- same output
--1.Create a database view:
CREATE OR REPLACE VIEW european_cities
AS
SELECT l.location_id,
	   l.city,
	   l.country_id
FROM   locations l
JOIN   countries c
	ON     (l.country_id = c.country_id)
JOIN   regions
	USING  (region_id)
WHERE  region_name = 'Europe';

-- 2.Join the EUROPEAN_CITIES view with the DEPARTMENTS table:
SELECT department_name,
	   city
FROM   departments 
NATURAL JOIN   european_cities;

-------------------------------------------------- Multiple-Column Subqueries
/*
Main query
WHERE (MANAGER_ID, DEPARTMENT_ID) IN

SELECT column, column, ...
FROM table
WHERE (column, column, ...) IN
			(SELECT column, column, ...
			 FROM table
			 WHERE condition);
*/
-------------------------------------------------- Column Comparisons
/*
Multiple-column comparisons involving subqueries can be:
	• Pairwise comparisons
	• Nonpairwise comparisons
*/
-------------------------------------------------- Pairwise Comparison Subquery
-- Pairwise Versus Nonpairwise Comparisons
--
--create table empl_demo as select * from employees;
SELECT first_name,
	   last_name,
	   manager_id,
	   department_id
FROM   empl_demo
WHERE  manager_id IN (SELECT manager_id
		     		  FROM   empl_demo
					  WHERE  first_name = 'Daniel')
		AND department_id IN (SELECT department_id
							  FROM   empl_demo
							  WHERE  first_name = 'Daniel');

----------
SELECT employee_id,
	   manager_id,
	   department_id
FROM   employees
WHERE  (manager_id, department_id) IN (SELECT manager_id,
											  department_id
										FROM   employees
										WHERE  employee_id IN (174, 199))
	   AND employee_id NOT IN (174, 199);				  

-------------------------------------------------- Nonpairwise Comparison Subquery
SELECT EMPLOYEE_ID,
       MANAGER_ID,
       DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN
      (
       SELECT MANAGER_ID
       FROM EMPLOYEES
       WHERE EMPLOYEE_ID IN (174, 141)
      )
      AND DEPARTMENT_ID IN
      (
       SELECT DEPARTMENT_ID
       FROM EMPLOYEES
       WHERE EMPLOYEE_ID IN (174, 141)
      )
      AND EMPLOYEE_ID NOT IN (174, 141);
				  
-------------------------------------------------- Scalar Subquery Expressions	   
-- returns exactly one column value from one row
--
-- Scalar subqueries in CASE expressions
SELECT EMPLOYEE_ID,
       LAST_NAME,
       (CASE
           WHEN DEPARTMENT_ID =
           (
            SELECT
                   DEPARTMENT_ID
            FROM DEPARTMENTS
            WHERE LOCATION_ID = 1800
           ) THEN 'Canada'
           ELSE 'USA'
       END) LOCATION
FROM EMPLOYEES;

-- Scalar subqueries in the SELECT statement
SELECT department_id,
	   department_name,
	   (SELECT COUNT(*)
		FROM   employees e
		WHERE  e.department_id = d.department_id) AS emp_count
FROM   departments d;

-------------------------------------------------- Correlated Subqueries
/*
SELECT column1, column2, ...
FROM table1 Outer table
WHERE column1 operator
		(SELECT column1, column2
		 FROM table2
		 WHERE expr1 = Outer_Outer_table.expr2);

*/
-- example 1:
SELECT last_name,
	   salary,
	   department_id 
FROM employees outer_table
WHERE salary > (SELECT AVG(salary)
				FROM   employees inner_table
				WHERE  inner_table.department_id = outer_table.department_id);

-- example 2:
SELECT department_id, 
	   employee_id,
	   salary
FROM EMPLOYEES e
WHERE 1 = (SELECT COUNT(DISTINCT salary)
		   FROM EMPLOYEES
           WHERE e.department_id = department_id
				AND e.salary <= salary);
				
-------------------------------------------------- Using the EXISTS Operator
SELECT employee_id,
	   last_name,
	   job_id,
	   department_id
FROM   employees
OUTER  WHERE EXISTS (SELECT NULL
					  FROM   employees
					  WHERE  manager_id = outer.employee_id);				

/*
Find All Departments
That Do Not Have Any Employees
*/
SELECT department_id,
	   department_name
FROM   departments d
WHERE  NOT EXISTS (SELECT NULL
		FROM   employees
		WHERE  department_id = d.department_id);

-- NOT IN evaluates to FALSE if any member of the set is a NULL value		
SELECT department_id,
	   department_name
FROM   departments
WHERE  department_id NOT IN (SELECT department_id
							 FROM   employees);
							 
							 
