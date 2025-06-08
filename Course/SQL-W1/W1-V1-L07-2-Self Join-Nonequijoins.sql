------------------------------------------------ Self Joins
SELECT WORKER.Last_name  EMP,
       MANAGER.Last_name MGR
FROM Employees WORKER
JOIN Employees MANAGER
    ON (WORKER.Manager_id = MANAGER.Employee_id);

------------------------------------------------ Nonequijoins
-- !!! job_grades not exists in version !!!
SELECT E.Last_name,
       E.Salary,
       J.Grade_level
FROM Employees E
JOIN Job_grades J
    ON E.Salary BETWEEN J.Lowest_sal AND J.Highest_sal;
