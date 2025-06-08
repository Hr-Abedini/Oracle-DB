--============================================================
--Creating Sequences, Synonyms, and Indexes
--============================================================
-------------------------------------------------- CREATE SEQUENCE Statement: Syntax
/*
CREATE SEQUENCE [ schema. ] sequence
[ { START WITH|INCREMENT BY } integer
| { MAXVALUE integer | NOMAXVALUE }
| { MINVALUE integer | NOMINVALUE }
| { CYCLE | NOCYCLE }
| { CACHE integer | NOCACHE }
| { ORDER | NOORDER }
];

*/

--DROP SEQUENCE DEPT_DEPTID_SEQ;
CREATE SEQUENCE dept_deptid_seq 
	START WITH 280 
	INCREMENT BY 10 
	MAXVALUE 9999 
	NOCACHE NOCYCLE;

-------------------------------------------------- NEXTVAL and CURRVAL Pseudocolumns	
-- <sequence>.nextval
-- <sequence>.currval
INSERT INTO departments (
	department_id,
	department_name,
	location_id
) VALUES (
	dept_deptid_seq.NEXTVAL,
	'Support',
	2500
);

-- 1.CURRVAL -> error 
-- 		ORA-08002: sequence DEPT_DEPTID_SEQ.CURRVAL is not yet defined in this session
SELECT dept_deptid_seq.CURRVAL
FROM dual;

SELECT dept_deptid_seq.NEXTVAL
FROM dual;

-------------------------------------------------- SQL Column Defaulting Using a Sequence		
CREATE SEQUENCE s1 
	START WITH 1;

CREATE TABLE emp (
	a1 NUMBER DEFAULT s1.NEXTVAL NOT NULL,
	a2 VARCHAR2(10)
);

INSERT INTO emp ( a2 ) VALUES ( 'john' );

INSERT INTO emp ( a2 ) VALUES ( 'mark' );

SELECT *
FROM emp;

-- Drop SEQUENCE s1;
-------------------------------------------------- Caching Sequence Values

-------------------------------------------------- Modifying a Sequence
/*
ALTER SEQUENCE sequence
	[INCREMENT BY n]
	[{MAXVALUE n | NOMAXVALUE}]
	[{MINVALUE n | NOMINVALUE}]
	[{CYCLE | NOCYCLE}]
	[{CACHE n | NOCACHE}];
*/
ALTER SEQUENCE dept_deptid_seq
	INCREMENT BY 20
	MAXVALUE 999999
	NOCACHE
	NOCYCLE;

-- current value > 280
-- ORA-04009: MAXVALUE cannot be made to be less than the current value
ALTER SEQUENCE dept_deptid_seq
	INCREMENT BY 20
	MAXVALUE 90
	NOCACHE
	NOCYCLE;

------------------- Drop	
DROP SEQUENCE dept_deptid_seq;	

-------------------------------------------------- Sequence Information	
DESCRIBE user_sequences;

SELECT sequence_name,
       min_value,
       max_value,
       increment_by,
       last_number
FROM user_sequences;

		
		