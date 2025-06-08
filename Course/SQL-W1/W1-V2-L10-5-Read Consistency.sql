--============================================================
-- **********  Read Consistency
--============================================================
/*
• Read consistency guarantees a consistent view of the data at all times.
• Changes made by one user do not conflict with the changes made by another user.
• Read consistency ensures that, on the same data:
    – Readers do not wait for writers
    – Writers do not wait for readers
    – Writers wait for writers
    
*/

------------------------------------------------ FOR UPDATE Clause in a SELECT Statement
/*
• Locks the rows in the EMPLOYEES table where job_id is SA_REP.
• Lock is released only when you issue a ROLLBACK or a COMMIT.
• If the SELECT statement attempts to lock a row that is locked by another user, 
	the database waits until the row is available, 
	and then returns the results of the SELECT statement.
*/
SELECT employee_id,
	   salary,
	   commission_pct,
	   job_id
FROM   employees
WHERE  job_id = 'SA_REP'
FOR    UPDATE
ORDER  BY employee_id;

-------------------- multiple tables

SELECT e.employee_id,
	   e.salary,
	   e.commission_pct
FROM   employees e
JOIN   departments d
USING  (department_id)
WHERE  job_id = 'ST_CLERK'
	   AND location_id = 1500
FOR    UPDATE
ORDER  BY e.employee_id;

-------------------- UPDATE WAIT
-- Rows from both the EMPLOYEES and DEPARTMENTS tables are locked.
SELECT employee_id,
	   salary,
	   commission_pct,
	   job_id
FROM   employees
WHERE  job_id = 'SA_REP'
FOR    UPDATE WAIT 5
ORDER  BY employee_id;

--------------------  Use FOR UPDATE OF column_name
-- locks only those rows in the EMPLOYEES table with ST_CLERK located in LOCATION_ID 1500.
-- No rows are locked in the DEPARTMENTS table
SELECT e.employee_id,
	   e.salary,
	   e.commission_pct
FROM   employees e
JOIN   departments d
USING  (department_id)
WHERE  job_id = 'ST_CLERK'
	   AND location_id = 1500
FOR    UPDATE OF e.salary
ORDER  BY e.employee_id;

-- For Update NOWAIT
