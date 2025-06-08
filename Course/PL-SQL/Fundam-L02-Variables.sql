--============================================================
--              Declaring PL/SQL Variables
--============================================================
--
---------------------------------------------------------
-- Declaring and Initializing PL/SQL Variables
---------------------------------------------------------
/*
Syntax:
  identifier [CONSTANT] datatype [NOT NULL]   
		[:= | DEFAULT expr];
*/
-- P2-7
DECLARE
   v_hiredate          DATE;
   v_deptno            NUMBER(2) NOT NULL := 10;
   v_location          VARCHAR2(13)       := 'Atlanta';
   c_comm     CONSTANT NUMBER             := 1400;
BEGIN
   NULL;
END;
/

---------------------------------------------------------
DECLARE
   v_myName VARCHAR2(20);
BEGIN
   DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
   v_myName := 'John';
   DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
END;
/

---------------------------------------------------------
DECLARE
   v_myName VARCHAR2(20) := 'John';
BEGIN
   v_myName := 'Steven';
   DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
END;
/

---------------------------------------------------------
-- Delimiters in String Literals
---------------------------------------------------------
DECLARE
   v_event VARCHAR2(15);
BEGIN
   -- The first quotation mark acts as the escape character    
   --v_event := '!Father''s day!';
   v_event := q'!Father's day!';
   DBMS_OUTPUT.PUT_LINE('3rd Sunday in June is :      ' || v_event);

   v_event := q'[Mother's day]';
   DBMS_OUTPUT.PUT_LINE('2nd Sunday in May is :    ' || v_event);
END;
/

---------------------------------------------------------
-- Types of Variables
---------------------------------------------------------
/*
PL/SQL variables:
    - Scalar                Scalar data types hold a single value. The value depends on the data type of the variable.
    - Reference             Reference data types hold values, called pointers, which point to a storage location.
    - Large object (LOB)    LOB data types hold values, called locators, which specify the location of large objects (such as graphic images) that are stored outside the table.
    - Composite             Composite data types are available by using PL/SQL collection and record variables.
Non-PL/SQL variables: 
    -Bind variables         include host language variables declared in precompiler programs, screen fields in Forms applications, and host variables.


*/
---------------------------------------------------------
-- Guidelines for Declaring PL/SQL Variables
---------------------------------------------------------
--!! Avoid using column names as identifiers !!
DECLARE
   employee_id NUMBER(6) := 0;
BEGIN

   DBMS_OUTPUT.PUT_LINE(employee_id);

   SELECT employee_id
   INTO employee_id
   FROM EMPLOYEES
   WHERE LAST_NAME = 'Kochhar';

   DBMS_OUTPUT.PUT_LINE(employee_id);
END;
/

-- use in where
DECLARE
   employee_id NUMBER(6) := 0;
BEGIN

   DBMS_OUTPUT.PUT_LINE(employee_id);

   SELECT employee_id
   INTO employee_id
   FROM EMPLOYEES
   WHERE employee_id = 100;
   -- ORA-01422: exact fetch returns more than requested number of rows
   --WHERE employee_id = employee_id;  

   DBMS_OUTPUT.PUT_LINE(employee_id);
END;
/

/*
-----------------------------------------------------------
PL/SQL Structure         My_Convention          Convention       
-----------------------------------------------------------
Variable                    var_name            v_name
Constant                    const_name          c_name
Subprogram parameter        prm_name            p_name
Bind (host) variable        bvar_name           b_name
Cursor                      cur_name            cur_name
Record                      rec_name            rec_name            
Type                        typ_name            name_type
Exception                   ex_name             e_name[_invalid]
File handle                 hdl_name            f_name

*/

-----------------------------------------------------------
-- %TYPE Attribute
-----------------------------------------------------------
DECLARE
   var_firstName EMPLOYEES.FIRST_NAME %TYPE;
   rec_emp       EMPLOYEES %ROWTYPE;
BEGIN
   NULL;
END;
-- Composite Data Types: Records and Collections
/*
   There are three types of PL/SQL collections: 
        - Associative Arrays
        - Nested Tables
        - VARRAY 
*/

-----------------------------------------------------------
--P2-30 Bind Variables 
-----------------------------------------------------------
VARIABLE b_result NUMBER

BEGIN

   SELECT (SALARY * 12) + NVL(COMMISSION_PCT, 0)
   INTO :b_result
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 144;

END;
/
-- SQL Plus | SQL Developer
PRINT b_result

----------------------------------------------------------
--P2-31 Referencing Bind Variables
----------------------------------------------------------
-- Command Window!!
VARIABLE b_emp_salary NUMBER;
BEGIN
   SELECT SALARY
   INTO :b_emp_salary
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 178;
END;
/
PRINT b_emp_salary

SELECT FIRST_NAME,
       LAST_NAME
FROM EMPLOYEES
WHERE SALARY = :b_emp_salary;

----
VARIABLE b_emp_salary NUMBER
SET AUTOPRINT ON;

DECLARE
   v_empno NUMBER(6) := &empno; --178
BEGIN
   SELECT SALARY
   INTO :b_emp_salary
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = v_empno;
END;
/



