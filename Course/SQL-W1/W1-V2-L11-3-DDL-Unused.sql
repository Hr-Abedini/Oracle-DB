---------- Dropping a Column
ALTER TABLE dept80
	DROP (job_id);
	
------------------------------------------------ SET UNUSED Option /p131
/*
-- SET UNUSED
-- DROP UNUSED COLUMNS
-- ONLINE

ALTER TABLE <table_name>
SET UNUSED(<column_name> [ , <column_name>]);
OR
ALTER TABLE <table_name>
SET UNUSED COLUMN <column_name> [ , <column_name>];


ALTER TABLE <table_name>
DROP UNUSED COLUMNS;
*/
-- 
CREATE TABLE dept80
	AS
		SELECT employee_id,
		       last_name,
		       salary * 12 salary2,
		       hire_date
		FROM employees
		WHERE department_id = 80;
--
DESCRIBE dept80;
--
ALTER TABLE dept80 
	SET UNUSED(hire_date)ONLINE;

ALTER TABLE dept80 
	SET UNUSED ( last_name );

-- similar to a DROP COLUMN.
ALTER TABLE dept80 
	DROP UNUSED COLUMNS;
--
DESCRIBE dept80;	

------------------------------------------------ Appendix
ALTER TABLE employees 
	SET UNUSED ( job_id, commission_pct );

SELECT *
FROM user_unused_col_tabs;

-------------
CREATE TABLE t (
	x INT NOT NULL,
	y INT NOT NULL,
	z INT NOT NULL
);
--
INSERT INTO t VALUES (
	1,
	2,
	3
);
--
ALTER TABLE t 
	SET UNUSED COLUMN z;
--
INSERT INTO t VALUES (
	4,
	5
);
-- new column
ALTER TABLE t 
	ADD z date;--int
