------------------------------------------------ Returning Records with No Direct Match Using OUTER Joins
/*
There are three types of OUTER joins:
    • LEFT OUTER
    • RIGHT OUTER
    • FULL OUTER

*/

------------------------------------------------ LEFT OUTER JOIN
-- row: Grant, null, null
SELECT E.Last_name,
       E.Department_id,
       D.Department_name
FROM Employees E
LEFT OUTER JOIN Departments D
    ON (E.Department_id = D.Department_id);

-- Remove "OUTER"

SELECT E.Last_name,
       E.Department_id,
       D.Department_name
FROM Employees E
LEFT JOIN Departments D
    ON (E.Department_id = D.Department_id);

------------------------------------------------ RIGHT OUTER JOIN
SELECT E.Last_name,
       D.Department_id,
       D.Department_name
FROM Employees E
RIGHT OUTER JOIN Departments D
    ON (E.Department_id = D.Department_id);

-- Remove "OUTER"

SELECT E.Last_name,
       D.Department_id,
       D.Department_name
FROM Employees E
RIGHT JOIN Departments D
    ON (E.Department_id = D.Department_id);

------------------------------------------------ FULL OUTER JOIN
-- all rows in the DEPARTMENTS, EMPLOYEES

SELECT E.Last_name,
       D.Department_id,
       D.Department_name
FROM Employees E
FULL OUTER JOIN Departments D
    ON (E.Department_id = D.Department_id);



