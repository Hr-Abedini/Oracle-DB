---------------------------------------------------------- Inner join
SELECT *
FROM Departments D,
     Employees E
WHERE E.Department_id = D.Department_id;

SELECT *
FROM Departments D
INNER JOIN Employees E
     ON E.Department_id = D.Department_id;
---------------------------------------------------------- Left Join
-- Left: Departments
-- Right: Employees
SELECT *
FROM Employees E,
     Departments D
WHERE D.Department_id --left
         = E.Department_id (+); -- right  + null

SELECT *
FROM Departments D,
     Employees E
WHERE E.Department_id (+) 
            = D.Department_id;


SELECT  d.*,E.*
FROM Departments D    -- Left
LEFT JOIN Employees E  -- Right
     ON E.Department_id = D.Department_id;
----------------------------------------------------------  Right Join
SELECT *
FROM Departments D,
     Employees E
WHERE E.Department_id  = D.Department_id (+);

SELECT *
FROM Departments D    -- Left
right JOIN Employees E  -- Right
     ON E.Department_id = D.Department_id;