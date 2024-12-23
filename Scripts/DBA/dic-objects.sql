--============================================================
SELECT *
FROM DBA_OBJECTS;

SELECT *
FROM USER_OBJECTS;

SELECT *
FROM ALL_OBJECTS;
--============================================================ Tables
SELECT *
FROM ALL_ALL_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM USER_TABLES;

SELECT *
FROM USER_TAB_COMMENTS;
--============================================================ segments
SELECT *
FROM USER_SEGMENTS;

SELECT *
FROM USER_SEGMENTS S
WHERE S.segment_name = 'EMPLOYEES';

--============================================================ columns
SELECT *
FROM USER_TAB_COLUMNS;

SELECT *
FROM USER_COL_COMMENTS;



--============================================================ Column Size
SELECT Vsize(E.employee_id)
FROM EMPLOYEES E;

SELECT Vsize(E.employee_id) + Vsize(E.first_name)
FROM EMPLOYEES E;

--============================================================ Source
SELECT *
FROM DBA_SOURCE;

SELECT *
FROM USER_SOURCE;

--============================================================ Constraint
SELECT *
FROM USER_CONSTRAINTS;