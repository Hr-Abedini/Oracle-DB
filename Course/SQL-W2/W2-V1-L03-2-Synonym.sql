--============================================================
--Creating Sequences, Synonyms, and Indexes
--============================================================
-------------------------------------------------- Creating a Synonym for an Object
/*
- PUBLIC Creates a synonym that is accessible to all users
	ORA-01031: insufficient privileges
	
CREATE [PUBLIC] SYNONYM synonym
FOR object;

*/

-------------------------------------------------- Creating and Removing Synonyms
CREATE SYNONYM d_sum
FOR dept_sum_vu;

-- Public
CREATE public SYNONYM d_sum
FOR dept_sum_vu;

DROP SYNONYM d_sum;

--------------------------------------------------
-- The database administrator can create a public synonym
-- that is accessible to all users
CREATE PUBLIC SYNONYM dept
FOR alice.departments;

DROP PUBLIC SYNONYM dept;

-------------------------------------------------- Synonym Information
DESCRIBE user_synonyms;

SELECT *
FROM user_synonyms;
