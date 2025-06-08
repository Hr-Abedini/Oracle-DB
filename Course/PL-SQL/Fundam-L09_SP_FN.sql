--============================================================
--          Introducing Stored Procedures and Functions
--============================================================
/*
named blocks => PL/SQL subprograms 

unlike anonymous blocks, the declarative section of a subprogram 
does not start with the DECLARE keyword. 

The optional declarative section follows 
the IS or AS keyword in the subprogram declaration.


*/
-------------------------------------------------- Procedure: Syntax
/*
CREATE [OR REPLACE] PROCEDURE procedure_name
 [(argument1 [mode1] datatype1,
   argument2 [mode2] datatype2,
  . . .)]
IS|AS
procedure_body;

*/
-------------------------------------------------- Creating a Procedure
CREATE TABLE DEPT
AS SELECT *
FROM DEPARTMENTS;
----------------------------
CREATE PROCEDURE ADD_DEPT
IS
   v_dept_id   DEPT.DEPARTMENT_ID % TYPE;
   v_dept_name DEPT.DEPARTMENT_NAME % TYPE;
BEGIN
    v_dept_id := 280;
    v_dept_name := 'ST-Curriculum';

    INSERT INTO DEPT
    (
      DEPARTMENT_ID,
      DEPARTMENT_NAME
    )
    VALUES
    (
      v_dept_id,
      v_dept_name
    );

    DBMS_OUTPUT.PUT_LINE(' Inserted ' || SQL % ROWCOUNT || ' row ');
END;
/
--------------------------------------------------P9-9 USER_OBJECTS / USER_SOURCE
SELECT object_name,
       object_type
FROM USER_OBJECTS;

SELECT *
FROM USER_SOURCE
WHERE name = 'ADD_DEPT';
/
-------------------------------------------------- Invoking a Procedure
--...
BEGIN
 add_dept;
END;
/
SELECT DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM DEPT
WHERE DEPARTMENT_ID = 280;

--------------------------------------------------P9-12 Function: Syntax
/*
CREATE [OR REPLACE] FUNCTION function_name
 [(argument1 [mode1] datatype1,
  argument2 [mode2] datatype2,
  . . .)]
RETURN datatype
IS|AS
function_body;

*/
-------------------------------------------------- Creating a Function
CREATE FUNCTION CHECK_SAL
  RETURN BOOLEAN
IS
   v_dept_id EMPLOYEES.DEPARTMENT_ID % TYPE;
   v_empno   EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_sal     EMPLOYEES.SALARY % TYPE;
   v_avg_sal EMPLOYEES.SALARY % TYPE;
BEGIN
    v_empno := 205;

    SELECT SALARY,
           DEPARTMENT_ID
    INTO v_sal,
         v_dept_id
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = v_empno;

    SELECT AVG(SALARY)
    INTO v_avg_sal
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = v_dept_id;

    IF v_sal > v_avg_sal THEN
       RETURN TRUE;
    ELSE
       RETURN FALSE;
    END IF;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       RETURN NULL;
END;
/
-------------------------------------------------- Invoking a Function
BEGIN

   IF (CHECK_SAL IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('The function returned  NULL due to exception');
   ELSIF (CHECK_SAL) THEN
      DBMS_OUTPUT.PUT_LINE('Salary > average');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Salary < average');
   END IF;

END;
/
---------------------
DESCRIBE check_sal;
-------------------------------------------------- Passing a Parameter to the Function
DROP FUNCTION CHECK_SAL;
/
-------------------------
CREATE FUNCTION CHECK_SAL
(
  p_empno EMPLOYEES.EMPLOYEE_ID % TYPE
)
  RETURN BOOLEAN
IS
   v_dept_id EMPLOYEES.DEPARTMENT_ID % TYPE;
   v_sal     EMPLOYEES.SALARY % TYPE;
   v_avg_sal EMPLOYEES.SALARY % TYPE;
BEGIN
    SELECT SALARY,
           DEPARTMENT_ID
    INTO v_sal,
         v_dept_id
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMPNO;

    SELECT AVG(SALARY)
    INTO v_avg_sal
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = v_dept_id;

    IF v_sal > v_avg_sal THEN
       RETURN TRUE;
    ELSE
       RETURN FALSE;
    END IF;

EXCEPTION WHEN OTHERS THEN   
    RETURN FALSE;
END;
  /

-------------------------------------------------- Invoking the Function with a Parameter
BEGIN
   DBMS_OUTPUT.PUT_LINE('Checking for employee with id 205');

   IF (CHECK_SAL(205) IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('The function returned  NULL due to exception');
   ELSIF (CHECK_SAL(205)) THEN
      DBMS_OUTPUT.PUT_LINE('Salary > average');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Salary < average');
   END IF;

   DBMS_OUTPUT.PUT_LINE('Checking for employee with id 70');

   IF (CHECK_SAL(70) IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('The function returned  NULL due to exception');
   ELSIF (CHECK_SAL(70)) THEN
      DBMS_OUTPUT.PUT_LINE('...');
   END IF;

END;
/

--------------------------------------------------
--------------------------------------------------


--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------





