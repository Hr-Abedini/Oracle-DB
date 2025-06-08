--============================================================
--          Working with Composite Data Types
--============================================================
/*
Are of two types:
    - PL/SQL records
    - PL/SQL collections:
        - Associative array (INDEX BY table)
        - Nested table
        - VARRAY

Syntax:

   1- TYPE type_name IS RECORD
     (field_declaration[, field_declaration]…);

   2- identifier	type_name; 

field_declaration:
    field_name {field_type | variable%TYPE 
           | table.column%TYPE | table%ROWTYPE}
           [[NOT NULL] {:= | DEFAULT} expr] 


****
In a block or subprogram, user-defined records are instantiated 
when you enter the block or subprogram. 
They cease to exist when you exit the block or subprogram.

*/
-------------------------------------------------- %ROWTYPE Attribute
/*
    Advantages of Using the %ROWTYPE Attribute
            The %ROWTYPE attribute is useful 
            when you want to retrieve a row with:
                - The SELECT * statement
                - Row-level INSERT and UPDATE statements


*/
-------------------------------------------------- P6-12 Creating a PL/SQL Record: Example
--> King 16-JAN-24 1500

DECLARE
   TYPE typ_rec IS RECORD
   (
     V_SAL       NUMBER(8),
     V_MINSAL    NUMBER(8) DEFAULT 1000,
     V_HIRE_DATE EMPLOYEES.HIRE_DATE %TYPE,
     V_REC1      EMPLOYEES %ROWTYPE  --***
   );

   v_myrec typ_rec;

BEGIN
   v_myrec.V_SAL := v_myrec.V_MINSAL + 500;
   v_myrec.V_HIRE_DATE := SYSDATE;

   SELECT *
   INTO v_myrec.V_REC1
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 100;

   DBMS_OUTPUT.PUT_LINE(v_myrec.V_REC1.LAST_NAME || ' ' || TO_CHAR(v_myrec.V_HIRE_DATE) || ' ' || TO_CHAR(v_myrec.V_SAL));
END;

-------------------------------------------------- P6-14 Another %ROWTYPE Attribute Example
/* 
DROP TABLE RETIRED_EMPS;

CREATE TABLE RETIRED_EMPS
AS
(
 SELECT
        E.EMPLOYEE_ID    AS EMPNO,
        E.LAST_NAME      AS ENAME,
        E.JOB_ID         AS JOB,
        E.MANAGER_ID     AS MGR,
        E.HIRE_DATE      AS HIREDATE,
        CURRENT_DATE     AS LEAVEDATE,
        E.SALARY         AS SAL,
        E.COMMISSION_PCT AS COMM,
        E.DEPARTMENT_ID  AS DEPTNO
 FROM EMPLOYEES E
 WHERE 1 = 0
)

--ORA-00911: invalid character  -> % 
CREATE TABLE  retired_emps
(
    empno EMPLOYEES.EMPLOYEE_ID%TYPE,
    ...
)


P6-14 Note
CREATE TABLE RETIRED_EMPS
(
    EMPNO     NUMBER(4),
    ENAME     VARCHAR2(10),
    JOB       VARCHAR2(9),
    MGR       NUMBER(4),
    HIREDATE  DATE,
    LEAVEDATE DATE,
    SAL       NUMBER(7, 2),
    COMM      NUMBER(7, 2),
    DEPTNO    NUMBER(2)
)
 */
DECLARE
   v_employee_number NUMBER := 124;
   v_emp_rec         EMPLOYEES % ROWTYPE;

BEGIN
   SELECT *
   INTO v_emp_rec
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = v_employee_number;

   INSERT INTO RETIRED_EMPS
   (
     EMPNO,
     ENAME,
     JOB,
     MGR,
     HIREDATE,
     LEAVEDATE,
     SAL,
     COMM,
     DEPTNO
   )
   VALUES
   (
     v_emp_rec.EMPLOYEE_ID,
     v_emp_rec.LAST_NAME,
     v_emp_rec.JOB_ID,
     v_emp_rec.MANAGER_ID,
     v_emp_rec.HIRE_DATE,
     SYSDATE,
     v_emp_rec.SALARY,
     v_emp_rec.COMMISSION_PCT,
     v_emp_rec.DEPARTMENT_ID
   );

END;
/

SELECT *
FROM RETIRED_EMPS;

--------------------------------------------------P6-15 Inserting a Record by Using %ROWTYPE
-- The number of fields in the record must be equal to the number of field names in the INTO clause
-- This makes the code more readable

-- truncate table RETIRED_EMPS;
DECLARE
   v_employee_number NUMBER := 124;
   v_emp_rec         RETIRED_EMPS % ROWTYPE;

BEGIN
   SELECT EMPLOYEE_ID,
          LAST_NAME,
          JOB_ID,
          MANAGER_ID,
          HIRE_DATE,
          HIRE_DATE,
          SALARY,
          COMMISSION_PCT,
          DEPARTMENT_ID
   INTO v_emp_rec
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = v_employee_number;

   INSERT INTO RETIRED_EMPS
   VALUES
   v_emp_rec;
END;
/

SELECT *
FROM RETIRED_EMPS;

--------------------------------------------------P6-16 Updating a Row in a Table by Using a Record
-- Updating a (1) Row in a Table by Using a Record
SET VERIFY OFF

DECLARE
   v_employee_number NUMBER := 124;
   v_emp_rec         RETIRED_EMPS % ROWTYPE;

BEGIN
   SELECT *
   INTO v_emp_rec
   FROM RETIRED_EMPS;

   v_emp_rec.LEAVEDATE := CURRENT_DATE;
    
   UPDATE RETIRED_EMPS
   SET ROW = v_emp_rec
   WHERE EMPNO = v_employee_number;

END;
/

SELECT *
FROM RETIRED_EMPS;


-------------------------------------------------- session 15
--------------------------------------------------

DECLARE
   TYPE rec_emp_info IS RECORD
   (
     EMP_ID    EMPLOYEES.EMPLOYEE_ID % TYPE,
     SALARY    EMPLOYEES.SALARY % TYPE,
     HIRE_DATE DATE
   );
   v_emp_info rec_emp_info;

BEGIN
   v_emp_info.EMP_ID := 1500;
   v_emp_info.SALARY := 5800;
   v_emp_info.HIRE_DATE := DATE '2015-11-13';

   DBMS_OUTPUT.PUT_LINE(v_emp_info.EMP_ID || CHR(13) || v_emp_info.SALARY || CHR(13) || TO_CHAR(v_emp_info.HIRE_DATE, 'yyyy-mm-dd'));
END;
--------------------------
SET SERVEROUTPUT ON

DECLARE
   TYPE rec_emp_info IS RECORD
   (
     EMP_ID     EMPLOYEES.EMPLOYEE_ID % TYPE,
     FIRST_NAME VARCHAR2(100),
     SALARY     EMPLOYEES.SALARY % TYPE,
     HIRE_DATE  DATE
   );
   v_emp_info rec_emp_info;

BEGIN
   SELECT E.EMPLOYEE_ID,
          E.FIRST_NAME,
          E.SALARY,
          E.HIRE_DATE
   INTO v_emp_info
   FROM EMPLOYEES E
   WHERE E.EMPLOYEE_ID = &p_emp_id;

   DBMS_OUTPUT.PUT_LINE(v_emp_info.EMP_ID || CHR(13) || v_emp_info.FIRST_NAME || CHR(13) || v_emp_info.SALARY || CHR(13) || TO_CHAR(v_emp_info.HIRE_DATE, 'yyyy-mm-dd'));
END;
/

--------------------------

/*
create table emp_14020425 as 
select * from employees e
where 1=2

*/


DECLARE
   v_emp_info      EMPLOYEES % ROWTYPE;
   v_min_emp_id    EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_max_emp_id    EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_is_emp_exists NUMBER(1);
   v_avg_salary    NUMBER(8);

BEGIN
   SELECT MIN(E.EMPLOYEE_ID),
          MAX(E.EMPLOYEE_ID)
   INTO v_min_emp_id,
        v_max_emp_id
   FROM EMPLOYEES E;

   FOR I IN v_min_emp_id .. v_max_emp_id
   LOOP

      SELECT COUNT(*)
      INTO v_is_emp_exists
      FROM EMPLOYEES E
      WHERE E.EMPLOYEE_ID = I;

      CONTINUE WHEN v_is_emp_exists = 0;

      SELECT *
      INTO v_emp_info
      FROM EMPLOYEES E
      WHERE E.EMPLOYEE_ID = I;

      SELECT AVG(NVL(SALARY, 0))
      INTO v_avg_salary
      FROM EMPLOYEES E
      WHERE E.DEPARTMENT_ID = v_emp_info.DEPARTMENT_ID
            AND E.EMPLOYEE_ID <> v_emp_info.EMPLOYEE_ID;

      IF v_emp_info.SALARY > v_avg_salary THEN
         INSERT INTO EMP_14020425
         VALUES
         v_emp_info;
      END IF;

   END LOOP;

END;
/

SELECT *
FROM EMP_14020425;   
