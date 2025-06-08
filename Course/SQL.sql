SELECT *
FROM Hr.Departments D
WHERE NOT EXISTS
      (
       SELECT 1
       FROM Employees E
       WHERE E.Department_id = D.Department_id
      );                       