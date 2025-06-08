--============================================================
-- Managing Schema Objects
--============================================================
-------------------------------------------------- Adding a Constraint
/*
ALTER TABLE <table_name>
ADD [CONSTRAINT <constraint_name>]
type (<column_name>);

*/

/*
 Drop Table emp2;
 
 Create Table  emp2 as 
	 select * from employees;
 
 Drop Table dept2;
 
 create table dept2 as 
	 select * from departments;
*/
ALTER TABLE emp2
MODIFY employee_id PRIMARY KEY;

desc emp2;

ALTER TABLE emp2
ADD CONSTRAINT emp_mgr_fk
	FOREIGN KEY(manager_id)
		REFERENCES emp2(employee_id);
		
-------------------------------------------------- Dropping a Constraint
/*
Syntax:
	ALTER TABLE table
	DROP PRIMARY KEY | 
		 UNIQUE (column) |
	     CONSTRAINT constraint [CASCADE];

The CASCADE option of the DROP clause causes any dependent constraints also
to be dropped.
*/
Alter table emp2
DROP CONSTRAINT emp_mgr_fk;	

-- Remove the PRIMARY KEY constraint
-- drop the associated FOREIGN KEY constraint on the EMP2.DEPARTMENT_ID column
alter table emp2
DROP PRIMARY KEY CASCADE;
	
-------------------------------------------------- Dropping a CONSTRAINT ONLINE
ALTER TABLE myemp2
DROP CONSTRAINT emp_name_pk ONLINE;

-------------------------------------------------- ON DELETE Clause
ALTER TABLE dept2 
	ADD CONSTRAINT dept_lc_fk
		FOREIGN KEY (location_id)
			REFERENCES locations(location_id) 
			ON DELETE CASCADE;

ALTER TABLE emp2 
	ADD CONSTRAINT emp_dt_fk
		FOREIGN KEY (Department_id)
			REFERENCES departments(department_id) 
			ON DELETE SET NULL;

-------------------------------------------------- Cascading Constraints / p137
-- drop table test1;
CREATE TABLE test1 
(
	col1_pk NUMBER PRIMARY KEY,
	col2_fk NUMBER,
	col1 NUMBER,
	col2 NUMBER,
	CONSTRAINT fk_constraint 
		FOREIGN KEY (col2_fk) 
			REFERENCES	test1,
	CONSTRAINT ck1 
		CHECK (col1_pk > 0 and col1 > 0),
	CONSTRAINT ck2 
		CHECK (col2_fk > 0)
);

ALTER TABLE emp2
	DROP COLUMN employee_id 
	CASCADE CONSTRAINTS;
	
ALTER TABLE test1
	DROP (col1_pk, col2_fk, col1);	
	
-------------------------------------------------- Renaming Table Columns and Constraints /p139
drop table marketing;

CREATE TABLE marketing 
(
	team_id NUMBER(10),
	target VARCHAR2(50),
	CONSTRAINT mktg_pk PRIMARY KEY(team_id)
);
-- rename tables
ALTER TABLE marketing 
	RENAME to new_marketing;
-- RENAME COLUMN	
ALTER TABLE new_marketing 
	RENAME COLUMN team_id
	TO id;	
-- RENAME CONSTRAINT
ALTER TABLE new_marketing 
	RENAME CONSTRAINT mktg_pk
	TO new_mktg_pk;		
	
-------------------------------------------------- Disabling Constraints	
/*
Syntax:
	ALTER TABLE table
	DISABLE CONSTRAINT constraint [CASCADE];

• Execute the DISABLE clause of the ALTER TABLE
	statement to deactivate an integrity constraint.
	
• Apply the CASCADE option to disable the primary key and it
	will disable all dependent FOREIGN KEY constraints
	automatically as well.

*/

ALTER TABLE emp2
	DISABLE CONSTRAINTS emp_dt_pk;

ALTER TABLE dept2
	DISABLE primary key CASCADE;
	
-------------------------------------------------- Enabling Constraints
/*
Syntax:
	ALTER TABLE table
	ENABLE CONSTRAINT constraint;

A UNIQUE index is automatically created if you enable a
UNIQUE key or a PRIMARY KEY constraint.

*/
ALTER TABLE emp2
	ENABLE CONSTRAINT emp dt fk;	
	
-------------------------------------------------- Constraint States	
/*
• ENABLE      ensures that all incoming data conforms to the constraint
• DISABLE     allows incoming data, regardless of whether it conforms to the constraint
• VALIDATE    ensures that existing data conforms to the constraint
• NOVALIDATE  means that some existing data may not conform to the constraint

*/

ALTER TABLE dept2
	ENABLE NOVALIDATE PRIMARY KEY;
	
-------------------------------------------------- Deferring Constraints	
ALTER TABLE dept2
ADD CONSTRAINT dept2_id_pk
	PRIMARY KEY (department_id)
	DEFERRABLE INITIALLY DEFERRED;
	
SET CONSTRAINTS dept2_id_pk IMMEDIATE;

ALTER SESSION
SET CONSTRAINTS= IMMEDIATE;

-------------------------------------------------- Difference Between INITIALLY DEFERRED and INITIALLY IMMEDIATE	
/*
INITIALLY DEFERRED:  Waits until the transaction ends to check the constraint
INITIALLY IMMEDIATE: Checks the constraint at the end of the statement execution
*/
CREATE TABLE emp_new_sal 
(
	salary NUMBER CONSTRAINT sal_ck
		CHECK (salary > 100)
		DEFERRABLE INITIALLY IMMEDIATE,
	bonus NUMBER CONSTRAINT bonus_ck
		CHECK (bonus > 0 )
		DEFERRABLE INITIALLY DEFERRED 
);

--Example 1:
-- ORA-02290: check constraint (HR.SAL_CK) violated
INSERT INTO emp_new_sal VALUES(90,5);

--Example 2:
INSERT INTO emp_new_sal VALUES(110, -1);

--Example 3:
SET CONSTRAINTS ALL DEFERRED;
INSERT INTO emp_new_sal VALUES(90,5);
-- ORA-02290: check constraint (HR.SAL_CK) violated
COMMIT;

--Example 4:
SET CONSTRAINTS ALL IMMEDIATE;
-- ORA-02290: check constraint (HR.BONUS_CK) violated
INSERT INTO emp_new_sal VALUES(110, -1);

CREATE TABLE newemp_details
(
	emp_id NUMBER, 
	emp_name VARCHAR2(20),
	CONSTRAINT newemp_det_pk 
		PRIMARY KEY(emp_id)
);

-- ORA-02447: cannot defer a constraint that is not deferrable
SET CONSTRAINT newemp_det_pk DEFERRED;

-------------------------------------------------- DROP TABLE … PURGE
-- recovered with the FLASHBACK TABLE statement
/* If you want to
immediately release the space associated with the table at the time you issue the DROP
TABLE statement, include the PURGE clause as shown in the statement in the slide.
*/
DROP TABLE emp_new_sal PURGE;
