--============================================================
-- Introduction to Data Dictionary Views
--============================================================
-- v$
-- user_
-- all_
-- dba_
--***************************
DESCRIBE DICTIONARY;
--***************************
SELECT *
FROM dictionary
WHERE table_name = 'USER_OBJECTS';

-- LOWER
SELECT table_name
FROM dictionary
WHERE lower(comments) LIKE '%columns%';

-------------------------------------------------- USER_OBJECTS and ALL_OBJECTS Views
/*
USER_OBJECTS information:
	– Date created
	– Date of last modification
	– Status (valid or invalid)
*/

SELECT object_name,
       object_type,
       created,
       status
FROM user_objects
ORDER BY object_type;

SELECT object_name,
       object_type,
       created,
       status
FROM all_objects
ORDER BY object_type;

-------------------------------------------------- Table Information
DESCRIBE user_tables;
--***************************
SELECT table_name
FROM user_tables;

-------------------------------------------------- Column Information
DESCRIBE user_tab_columns;
--***************************
SELECT column_name,
       data_type,
       data_length,
       data_precision,
       data_scale,
       nullable
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES';

-------------------------------------------------- Constraint Information
DESCRIBE user_constraints;
--***************************
SELECT constraint_name,
       constraint_type,
       search_condition,
       r_constraint_name,
       delete_rule,
       status
FROM user_constraints
WHERE table_name = 'EMPLOYEES';

---------- Querying USER_CONS_COLUMNS
DESCRIBE user_cons_columns;
--***************************
SELECT constraint_name,
       column_name
FROM user_cons_columns
WHERE table_name = 'EMPLOYEES';

-------------------------------------------------- Adding Comments to a Table
/*
• Comments can be viewed through the data dictionary views:
	– ALL_COL_COMMENTS
	– USER_COL_COMMENTS
	– ALL_TAB_COMMENTS
	– USER_TAB_COMMENTS
*/
COMMENT ON TABLE employees 
IS 'Employee Information';

COMMENT ON COLUMN employees.first_name
IS 'First name of the employee';

----------
SELECT *
FROM all_col_comments;

SELECT *
FROM user_col_comments;

SELECT *
FROM all_tab_comments;

SELECT *
FROM user_tab_comments;

-------------------------------------------------- Appendix
--static
select * FROM v$event_name;
select * from gv$process;


--dynamic
SELECT * FROM Tab$ t;
SELECT * FROM ind$;
SELECT * FROM User_segments us;

SELECT * FROM V$tablespace vt ;
SELECT * FROM V_$tablespace vt ;



SELECT * FROM User_indexes ui;	
SELECT * FROM User_ind_columns uic;	