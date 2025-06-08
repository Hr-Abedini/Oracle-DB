--============================================================
-- Creating Views
--============================================================
/*
CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view
[(alias[, alias]...)]
AS subquery
	[WITH CHECK OPTION [CONSTRAINT constraint]]
	[WITH READ ONLY [CONSTRAINT constraint]];
*/

CREATE VIEW Empvu80
AS
   SELECT Employee_id,
          Last_name,
          Salary
   FROM Employees
   WHERE Department_id = 80;
--	

DESCRIBE Empvu80;
-------------------------------------------------- Creating a View / p111

CREATE VIEW Salvu50
AS
   SELECT Employee_id ID_NUMBER,
          Last_name   NAME,
          Salary * 12 ANN_SALARY
   FROM Employees
   WHERE Department_id = 50;

---------- CREATE OR REPLACE	
CREATE OR REPLACE VIEW Salvu50
(
   Id_number,
   Name,
   Ann_salary
)
AS
   SELECT Employee_id,
          Last_name,
          Salary * 12
   FROM Employees
   WHERE Department_id = 50;

----------	
SELECT *
FROM Salvu50;

-------------------------------------------------- Modifying a View /p113
CREATE OR REPLACE VIEW Empvu80
(
   Id_number,
   Name,
   Sal,
   Department_id
)
AS
   SELECT Employee_id,
          First_name || ' ' || Last_name,
          Salary,
          Department_id
   FROM Employees
   WHERE Department_id = 80;

-------------------------------------------------- Creating a Complex View
CREATE OR REPLACE VIEW Dept_sum_vu
(
   Name,
   Minsal,
   Maxsal,
   Avgsal
)
AS
   SELECT D.Department_name,
          MIN(E.Salary),
          MAX(E.Salary),
          AVG(E.Salary)
   FROM Employees E
   JOIN Departments D
        USING (Department_id)
   GROUP BY D.Department_name;

SELECT *
FROM Dept_sum_vu;

-------------------------------------------------- View Information
DESCRIBE User_views;

SELECT View_name
FROM User_views;

SELECT Text
FROM User_views
WHERE View_name = 'EMP_DETAILS_VIEW';

-------------------------------------------------- Using the WITH CHECK OPTION Clause
/*
Any attempt to INSERT a row with a department_id
other than 20 or to UPDATE the department number for any
row in the view fails because it violates the WITH CHECK
OPTION.
*/
CREATE OR REPLACE VIEW Empvu20
AS
   SELECT *
   FROM Employees
   WHERE Department_id = 20
   --WITH CHECK OPTION;
   WITH CHECK OPTION CONSTRAINT Empvu20_ck;
---- Check Constraint
SELECT *
FROM All_constraints
WHERE Owner = 'HR'
      AND Table_name = 'EMPVU20';

-- ORA-01402: view WITH CHECK OPTION where-clause violation	
UPDATE Empvu20
SET Department_id = 10
WHERE Employee_id = 201;

-------------------------------------------------- Denying DML Operations
CREATE OR REPLACE VIEW Empvu10
(
   Employee_number,
   Employee_name,
   Job_title
)
AS
   SELECT Employee_id,
          Last_name,
          Job_id
   FROM Employees
   WHERE Department_id = 10
   WITH READ ONLY;
   --WITH READ ONLY CONSTRAINT CK_Empvu10;
---- Check Constraint
SELECT *
FROM All_constraints
WHERE Owner = 'HR'
      AND Table_name = 'EMPVU10';


-- ORA-42399: cannot perform a DML operation on a read-only view	
DELETE FROM Empvu10
WHERE Employee_number = 200;

-------------------------------------------------- Removing a View
--DROP VIEW view;

DROP VIEW Empvu80;
DROP VIEW Salvu50;
DROP VIEW Dept_sum_vu;

DROP VIEW Empvu20;
DROP VIEW Empvu10;