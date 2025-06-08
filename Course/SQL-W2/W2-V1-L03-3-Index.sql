--============================================================
--Creating Sequences, Synonyms, and Indexes
--============================================================
-------------------------------------------------- Creating an Index
/*
two types of indexes:
Unique index: PRIMARY KEY, UNIQUE constraint
	The Oracle Server automatically creates this index when you define

• Nonunique index: This is an index that a user can create. 
For example, you can create
the FOREIGN KEY column index for a join in a query to improve the speed of retrieval.


CREATE [UNIQUE]INDEX index
ON table (column[, column]...);
*/

CREATE INDEX Emp_last_name_idx
ON Employees (Last_name);

-------------------------------------------------- CREATE INDEX with the CREATE TABLE Statement /p89
CREATE TABLE New_emp
(
    Employee_id Number(6)
    PRIMARY KEY
        USING INDEX (
                        CREATE INDEX Emp_id_idx
                        ON New_emp (Employee_id)
        ),
    First_name  Varchar2(20),
    Last_name   Varchar2(25)
);

SELECT Index_name,
       Table_name
FROM User_indexes
WHERE Table_name = 'NEW_EMP';

------------------------

CREATE TABLE Emp_unnamed_index
(
    Employee_id Number(6) PRIMARY KEY,
    First_name  Varchar2(20),
    Last_name   Varchar2(25)
);

SELECT Index_name,
       Table_name
FROM User_indexes
WHERE Table_name = 'EMP_UNNAMED_INDEX';

-------------------------------------------------- P90
CREATE TABLE New_emp2
(
    Employee_id Number(6),
    First_name  Varchar2(20),
    Last_name   Varchar2(25)
);

CREATE INDEX Emp_id_idx2
ON New_emp2 (Employee_id);

ALTER TABLE New_emp2 
ADD PRIMARY KEY (Employee_id)
USING INDEX Emp_id_idx2;

-------------------------------------------------- Creating Multiple Indexes on the Same Set of Columns / p93
CREATE INDEX Emp_id_name_ix1
ON Employees (Employee_id, First_name);

ALTER INDEX Emp_id_name_ix1 INVISIBLE;

CREATE BITMAP INDEX Emp_id_name_ix2
ON Employees (Employee_id, First_name);

-------------------------------------------------- Index Information
DESCRIBE User_indexes;

----------
SELECT Index_name,
       Table_name,
       Uniqueness
FROM User_indexes
WHERE Table_name = 'EMPLOYEES';

----------
CREATE TABLE Emp_lib
(
    Book_id  Number(6) PRIMARY KEY,
    Title    Varchar2(25),
    Category Varchar2(20)
);

SELECT Index_name,
       Table_name
FROM User_indexes
WHERE Table_name = 'EMP_LIB';

-------------------------------------------------- Querying USER_IND_COLUMNS
DESCRIBE User_ind_columns

----------
DROP TABLE Emp_test;

CREATE TABLE Emp_test
AS SELECT *
FROM Employees;

CREATE INDEX Lname_idx ON Emp_test (Last_name);

SELECT Index_name,
       Column_name,
       Table_name
FROM User_ind_columns
WHERE Index_name = 'LNAME_IDX';

-------------------------------------------------- Removing an Index /p97
-- DROP INDEX index;

DROP INDEX Lname_idx;

DROP INDEX Emp_indx ONLINE;
