-------------------------------------------------- External Tables

-------------------------------------------------- Creating a Directory for the External Table
/*
alias for a directory

Syntax:
	CREATE [OR REPLACE] DIRECTORY AS 'path_name';

*/
CREATE OR REPLACE DIRECTORY emp_dir
AS '/…/emp_dir';

GRANT READ ON DIRECTORY emp_dir TO ora_21;

-------------------------------------------------- Creating an External Table
/*
CREATE TABLE <table_name>
	( <col_name> <datatype>, … )
ORGANIZATION EXTERNAL
	(
		TYPE <access_driver_type>
		DEFAULT DIRECTORY <directory_name>
		ACCESS PARAMETERS
		(… )
	)
	LOCATION ('<location_specifier>')
	REJECT LIMIT [0 | <number> | UNLIMITED];
*/

CREATE TABLE oldemp 
(
	fname char(25), 
	lname CHAR(25)
)
ORGANIZATION EXTERNAL
(
	TYPE ORACLE_LOADER
	DEFAULT DIRECTORY emp_dir
	ACCESS PARAMETERS
		(
			RECORDS DELIMITED BY NEWLINE
			FIELDS(fname POSITION ( 1:20) CHAR, lname POSITION (22:41) CHAR)
		 )
LOCATION ('emp.dat'));

-------------------------------------------------- Creating an External Table by Using ORACLE_DATAPUMP: Example
CREATE DIRECTORY emp_dir AS '/emp_dir' ;

CREATE TABLE emp_ext
(employee_id, first_name, last_name)
ORGANIZATION EXTERNAL
(
TYPE ORACLE_DATAPUMP
DEFAULT DIRECTORY emp_dir
LOCATION
('emp1.exp','emp2.exp')
)
PARALLEL
AS
SELECT employee_id, first_name, last_name
FROM employees;

