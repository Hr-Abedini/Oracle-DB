--============================================================
-- **********  Changing Data in a Table
--============================================================
/*
UPDATE Statement Syntax:
UPDATE table
SET column = value [, column = value, ...]
[WHERE condition];

--> create table copy_emp as ( select * from employees where 1=0);
*/
------------------------------------------------ Updating Rows in a Table
UPDATE employees
SET    department_id = 50
WHERE  employee_id = 113;


UPDATE copy_emp
SET    department_id = 110;

------------------------------------------------ Updating Two Columns with a Subquery
/*
UPDATE TABLE
SET    column =
           (SELECT column
            FROM   TABLE
            WHERE  condition) 
      [,column =
           (SELECT column
            FROM   TABLE
            WHERE  condition) ] 
[WHERE  condition ];
*/
SELECT job_id,
	   salary
FROM   employees
WHERE  employee_id = 103;


UPDATE employees
SET    (job_id, salary) =
	   (SELECT job_id,
			   salary
		FROM   employees
		WHERE  employee_id = 205)
WHERE  employee_id = 103;

------------------------------------------------ Updating Rows Based on Another Table
UPDATE copy_emp
SET    department_id =
	   (SELECT department_id
		FROM   employees
		WHERE  employee_id = 100)
WHERE  job_id = (SELECT job_id
				 FROM   employees
				 WHERE  employee_id = 200);

