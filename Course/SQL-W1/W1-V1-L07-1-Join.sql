--============================================================
-- **********  Displaying Data from Multiple Tables Using Joins
--============================================================
/*

Types of Joins
Joins that are compliant with the SQL:1999 standard include the following:
	• Natural join with the NATURAL JOIN clause
	• Join with the USING clause
	• Join with the ON clause
	• OUTER joins:
		– LEFT OUTER JOIN
		– RIGHT OUTER JOIN
		– FULL OUTER JOIN
	• Cross joins

------------------------------------------------ Joining Tables Using SQL:1999 Syntax
SELECT table1.column, table2.column
FROM table1
[NATURAL JOIN table2] |
[JOIN table2 USING (column_name)] |
[JOIN table2 ON (table1.column_name = table2.column_name)]|
[LEFT|RIGHT|FULL OUTER JOIN table2ON (table1.column_name = table2.column_name)]|
[CROSS JOIN table2];

*/

------------------------------------------------ Retrieving Records with Natural Joins
/*
Creating Natural Joins
	• The NATURAL JOIN clause is based on all the columns
		that have the same name in two tables.
	• It selects rows from the two tables that have equal values
		in all matched columns.
	• If the columns having the same names have different data
		types, an error is returned.

same name: tbl1.col1 = tbl2.col1
and
same type: tbl1.col1.type = tbl2.col1.type

SELECT * FROM table1 NATURAL JOIN table2;

*/

SELECT employee_id,
	   first_name,
	   job_id,
	   job_title
FROM   employees
NATURAL JOIN   jobs;

-- Natural Joins with a WHERE Clause

SELECT department_id,
	   department_name,
	   location_id,
	   city
FROM   departments 
NATURAL JOIN   locations
WHERE  department_id IN (20, 50);

------------------------------------------------ Retrieving Records with the USING Clause
/*
	• If several columns have the same names but the data types do not match, 
	  use the USING clause to specify the columns for the equijoin.
	• Use the USING clause to match only one column when
	  more than one column matches.

*/

SELECT employee_id,
	   last_name,
	   location_id,
	   department_id
FROM   employees
JOIN   departments
	USING  (department_id);

------------------------------------------------ Using Table Aliases with the USING Clause
--
-- Error: ORA-25154: column part of USING clause cannot have qualifier
--
SELECT l.city,
	   d.department_name
FROM   locations l
JOIN   departments d
	USING  (location_id)
--WHERE  d.location_id = 1400; -- Error
WHERE  location_id = 1400;
--
-- Error: ORA-00918: column ambiguously defined
--
SELECT first_name,
	   --manager_id, -- Error 
	   d.manager_id,
	   e.manager_id
FROM   employees e
JOIN   departments d
	USING  (department_id)
WHERE  department_id = 50;

------------------------------------------------ Retrieving Records with the ON Clause
SELECT e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.location_id
FROM   employees e
JOIN   departments d
	ON     (e.department_id = d.department_id);

-- Creating Three-Way Joins
SELECT employee_id,
	   city,
	   department_name
FROM   employees e
JOIN   departments d
	ON     d.department_id = e.department_id
JOIN   locations l
	ON     d.location_id = l.location_id;
------
-- OR 
------
SELECT e.employee_id,
	   l.city,
	   d.department_name
FROM   employees e
JOIN   departments d
	USING  (department_id)
JOIN   locations l
	USING  (location_id);
	
------------------------------------------------ Applying Additional Conditions to a Join	SELECT e.employee_id, e.last_name, e.department_id,
SELECT e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.location_id
FROM   employees e
JOIN   departments d
	ON (e.department_id = d.department_id)
	   AND e.manager_id = 149;
------
-- OR 
------
SELECT e.employee_id,
	   e.last_name,
	   e.department_id,
	   d.department_id,
	   d.location_id
FROM   employees e
JOIN   departments d
	ON     (e.department_id = d.department_id)
WHERE  e.manager_id = 149;
