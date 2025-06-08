------------------------------------------------ Cartesian Products
/*
	• Cartesian product is a join of every row of one table to every row of another table.
	• A Cartesian product generates a large number of rows and the result is rarely useful.

*/

-- Rows: 2889
SELECT Last_name,
       Department_name
FROM Employees
CROSS JOIN Departments;

------------------------------------------------
------------------------------------------------ Appendix
------------------------------------------------
-- Remove "CROSS JOIN"
-- Rows: 2889

SELECT Last_name,
       Department_name
FROM Employees,
     Departments;

-- inner join

SELECT E.Last_name,
       D.Department_name
FROM Employees E,
     Departments D
WHERE D.Department_id = 10;
