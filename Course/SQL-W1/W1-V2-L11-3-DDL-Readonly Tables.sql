------------------------------------------------ Read-Only Tables

ALTER TABLE employees READ ONLY;
-- ORA-12081: update operation not allowed on table "HR"."EMPLOYEES"
UPDATE employees
SET
	first_name = 'test'
WHERE employee_id = 5;


-- perform table maintenance and then
-- return table back to read/write mode
ALTER TABLE employees READ WRITE;

