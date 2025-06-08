--============================================================
-- **********•  Introduction to Data Definition Language
--============================================================

------------------------------------------------ Database Objects
/*

schema objects:
	1. Clusters
	2. Database links
	3. Database triggers
	4. Dimensions
	5. External procedure libraries
	6. Indexes and index types
	7. Java classes, Java resources, and Java sources
	8. Materialized views and materialized view logs
	9. Object tables, object types, and object views
	10.Operators
	11.Sequences
	12.Stored functions, procedures, and packages
	13.Synonyms
	14.Tables and index-organized tables
	15.Views			
	-- Constraints

NON-SCHEMA Objects:
	Contexts
	Directories
	Profiles
	Roles
	Tablespaces
	Users
	Rollback segments	
------------------------------------------------ Naming Rules
Table names and column names must:
	• Begin with a letter
	• Be 1–30 characters long
	• Contain only A–Z, a–z, 0–9, _, $, and #
	• Not duplicate the name of another object owned by the	same user
	• Not be an Oracle server–reserved word
	
------------------------------------------------ CREATE TABLE Statement
* You must have CREATE TABLE privilege

CREATE TABLE [schema.]table
(column datatype [DEFAULT expr][, ...]);

*/
CREATE TABLE dept (
	deptno      NUMBER(2),
	dname       VARCHAR2(14),
	loc         VARCHAR2(13),
	create_date DATE DEFAULT sysdate
);

--DESCRIBE dept;

------------------------------------------------ Data Types

------------------------------------------------ DEFAULT Option
-- ... hire_date DATE DEFAULT SYSDATE, ...
CREATE TABLE hire_dates (
	id        NUMBER(8),
	hire_date DATE DEFAULT sysdate
);

INSERT INTO hire_dates VALUES (
	45,
	NULL
);

INSERT INTO hire_dates ( id ) VALUES ( 35 );

SELECT *
FROM hire_dates;

------------------------------------------------ Defining Constraints
/*
constraint types:
	– NOT NULL
	– UNIQUE
	– PRIMARY KEY
	– FOREIGN KEY
	– CHECK

Syntax:	
CREATE TABLE [schema.]table (
	column datatype [DEFAULT expr]
	[column_constraint],
	...
	[table_constraint][,...]
	);	
*/	
------------------------------------------------ Column-level constraint
/*
 syntax:
	column [CONSTRAINT constraint_name] constraint_type,	
*/
-- DROP TABLE employees_collevel;
CREATE TABLE employees_collevel (
	employee_id NUMBER(6)
		CONSTRAINT emp_collevel_id_pk PRIMARY KEY,
	first_name  VARCHAR2(20)
);
	
--desc employees_colLevel;
	
------------------------------------------------ Table-level constraint
/*
syntax:	
	column,...
	[CONSTRAINT constraint_name] constraint_type
	(column, ...),	
*/

-- DROP TABLE employees_tablelevel;
CREATE TABLE employees_tablelevel (
	employee_id NUMBER(6),
	first_name  VARCHAR2(20),
	job_id      VARCHAR2(10) NOT NULL,
	CONSTRAINT emp_tablelevel_id_pk PRIMARY KEY ( employee_id )
);

-- desc employees_tableLevel;
------------------------------------------------ NOT NULL Constraint

------------------------------------------------ UNIQUE Constraint
-- DROP TABLE employees_uq;
CREATE TABLE employees_uq (
	employee_id    NUMBER(6),
	last_name      VARCHAR2(25) NOT NULL,
	email          VARCHAR2(25),
	salary         NUMBER(8,2),
	commission_pct NUMBER(2,2),
	hire_date      DATE NOT NULL,
	--...
	CONSTRAINT emp_uq_email_uk UNIQUE ( email )
);

-- desc employees_UQ;
------------------------------------------------ PRIMARY KEY Constraint

------------------------------------------------ FOREIGN KEY Constraint
CREATE TABLE employees (
	employee_id    NUMBER(6),
	last_name      VARCHAR2(25) NOT NULL,
	email          VARCHAR2(25),
	salary         NUMBER(8,2),
	commission_pct NUMBER(2,2),
	hire_date      DATE NOT NULL,
--	...
	department_id  NUMBER(4),
	CONSTRAINT emp_dept_fk FOREIGN KEY ( department_id )
		REFERENCES departments ( department_id ),
	CONSTRAINT emp_email_uk UNIQUE ( email )
);


------------------------------------------------ CHECK Constraint
/*
..., salary NUMBER(2)
	CONSTRAINT emp_salary_min
		CHECK (salary > 0),...
*/

------------------------------------------------ CREATE TABLE: Example
-- DROP TABLE teach_emp;

CREATE TABLE teach_emp (
    empno      NUMBER(5) PRIMARY KEY,
    ename      VARCHAR2(15) NOT NULL,
    job        VARCHAR2(10),
    mgr        NUMBER(5),
    hiredate   DATE DEFAULT ( sysdate ),
    photo      BLOB,
    sal        NUMBER(7, 2),
    deptno     NUMBER(3) NOT NULL
        CONSTRAINT admin_dept_fkey
            REFERENCES departments ( department_id )
);

------------------------------------------------ Violating Constraints / p120
-- ORA-02291: integrity constraint (HR.EMP_DEPT_FK) violated - parent key not found
UPDATE employees
SET
	department_id = 55
WHERE department_id = 110;
-- ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
DELETE FROM departments
WHERE department_id = 60;


------------------------------------------------ Creating a Table Using a Subquery /p123
/*
CREATE TABLE table
	[(column, column...)]
	AS subquery;
*/
DROP TABLE dept80;
-- Table DEPT80 created.
CREATE TABLE Dept80
AS
SELECT Employee_id,
       Last_name,
       Salary * 12 ANNSAL,
       Hire_date
FROM Employees
WHERE Department_id = 80;
		
-- Without the alias
-- ORA-00998: must name this expression with a column alias
CREATE TABLE dept80
	AS
		SELECT employee_id,
		       last_name,
		       salary * 12,
		       hire_date
		FROM employees
		WHERE department_id = 80;	
		
------------------------------------------------ ALTER TABLE Statement
/*
ALTER TABLE table
	ADD (column datatype [DEFAULT expr]
		[, column datatype]...);

ALTER TABLE table
	MODIFY (column datatype [DEFAULT expr]
		[, column datatype]...);

ALTER TABLE table
	DROP (column [,column] …);
*/
---------- Adding a Column / p128
-- Table DEPT80 altered.
ALTER TABLE dept80 
	ADD (job_id VARCHAR2(9));
	
---------- Modifying a Column
ALTER TABLE dept80
	MODIFY (last_name VARCHAR2(30));
	
---------- Dropping a Column
ALTER TABLE dept80
	DROP (job_id);
	

------------------------------------------------ Dropping a Table
/*
-- move -> recycle bin
-- real remove -> PURGE clause

DROP TABLE table [PURGE]

Guidelines:
	• All data is deleted from the table.
	• Any views and synonyms remain, but are invalid.
	• Any pending transactions are committed.
	• Only the creator of the table or a user with the DROP ANY TABLE privilege can remove a table.
*/

DROP TABLE dept80 ;
DROP TABLE dept80 purge;

-- oracle 23
--DROP TABLE If EXISTS Dept80;