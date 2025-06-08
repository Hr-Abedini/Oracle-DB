--============================================================
--          Writing Control Structures
--============================================================
/*
IF statements, CASE expressions, LOOP structures in a PL/SQL block.
*/
-------------------------------------------------- IF Statement
/*
IF condition THEN
  statements;
[ELSIF condition THEN 
  statements;]
[ELSE 
  statements;]
END IF;
*/
SET SERVEROUTPUT ON;
-------------------------------------------------- Simple IF Statement
DECLARE
   v_myage NUMBER := 31;
BEGIN

   IF v_myage < 11  -- 31 < 11
   THEN
      DBMS_OUTPUT.PUT_LINE(' I am a child ');
   END IF;

END;
/

-------------------------------------------------- IF THEN ELSE Statement
DECLARE
   v_myage NUMBER := 31;
BEGIN

   IF v_myage < 11 THEN
      DBMS_OUTPUT.PUT_LINE(' I am a child ');
   ELSE
      DBMS_OUTPUT.PUT_LINE(' I am not a child ');
   END IF;

END;
/

-------------------------------------------------- IF ELSIF ELSE Clause
DECLARE
   v_myage NUMBER := 31;
BEGIN

   IF v_myage < 11 THEN
      DBMS_OUTPUT.PUT_LINE(' I am a child ');
   ELSIF v_myage < 20 THEN
      DBMS_OUTPUT.PUT_LINE(' I am young ');
   ELSIF v_myage < 30 THEN
      DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
   ELSIF v_myage < 40 THEN
      DBMS_OUTPUT.PUT_LINE(' I am in my thirties'); ---***
   ELSE
      DBMS_OUTPUT.PUT_LINE(' I am always young ');
   END IF;

END;
/

-------------------------------------------------- NULL Value in IF Statement
DECLARE
   v_myage NUMBER;
BEGIN

   IF v_myage < 11 THEN   -- (null < 11) --> null
      DBMS_OUTPUT.PUT_LINE(' I am a child ');
   ELSE
      DBMS_OUTPUT.PUT_LINE(' I am not a child '); ---***
   END IF;

END;
/

--------------------------------------------------  CASE Expressions (selector/expression)
/*
CASE selector
   WHEN expression1 THEN result1
   WHEN expression2 THEN result2
   ...
   WHEN expressionN THEN resultN
  [ELSE resultN+1]
END;

*/
-- !! Run in SQL*Plus
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
   v_grade     CHAR(1) := UPPER('&grade'); -- substitution variable
   v_appraisal VARCHAR2(20);
BEGIN
   v_appraisal := CASE v_grade
                     WHEN 'A' THEN 'Excellent'
                     WHEN 'B' THEN 'Very Good'
                     WHEN 'C' THEN 'Good'
                     ELSE 'No such grade'
                 END;
   DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade || ' Appraisal ' || v_appraisal);
END;
/

--------------------------------------------------P5-14 Searched CASE Expressions ()
-- CASE expressions end with END;

DECLARE
   v_grade     CHAR(1) := UPPER('&grade'); -- substitution variable
   v_appraisal VARCHAR2(20);
BEGIN
   v_appraisal := CASE
                     WHEN v_grade = 'A' THEN 'Excellent'
                     WHEN v_grade IN ('B', 'C') THEN 'Good'
                     ELSE 'No such grade'
                 END;
   DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade || ' Appraisal ' || v_appraisal);
END;
/

-------------------------------------------------- CASE Statement ***
-- CASE statements end with END CASE; 

/*
Note: Whereas an IF statement is able to do nothing 
      (the conditions could be all false and the ELSE clause is not mandatory),
      a CASE statement must execute some PL/SQL statement.

ORA-06592: CASE not found while executing CASE statement
*/
DECLARE
   v_deptid   NUMBER;
   v_deptname VARCHAR2(20);
   v_emps     NUMBER;
   v_mngid    NUMBER := 105;
BEGIN

   CASE v_mngid
      WHEN 108 THEN
          ---
          SELECT DEPARTMENT_ID,
                 DEPARTMENT_NAME
          INTO v_deptid,
               v_deptname
          FROM DEPARTMENTS
          WHERE MANAGER_ID = 108;

          SELECT COUNT(*)
          INTO v_emps
          FROM EMPLOYEES
          WHERE DEPARTMENT_ID = v_deptid;
   --   WHEN  200 THEN ...
   --   ELSE ... 
   --    ...
   END CASE;

   DBMS_OUTPUT.PUT_LINE('You are working in the ' || v_deptname || ' department. There are ' || v_emps || ' employees in this department');
   
END;
/
--------------------------------------------------P5-16   Handling Nulls
/*
** FALSE takes precedence in an AND condition
** TRUE  takes precedence in an OR  condition 
** null  values are indeterminate
-----------------------   -----------------------   ----------------------
        AND = *                 OR = +                    Not = !
-----------------------   -----------------------   ----------------------   
true  * true   = true     true  + true   = true     !true  = false
true  * false  = false    true  + false  = false    !false = true
true  * null   = null     true  + null   = null     !null  = null
false * false  = false    false + false  = false
false * null   = false    false + null   = false
null  * null   = null     null  + null   = null
                    

    x := 5;
    y := NULL;
    ...
    
    IF x != y THEN  -- yields NULL, not TRUE
        --sequence_of_statements that are not executed
    END IF;


    a := NULL;
    b := NULL;
    ...
    IF a = b THEN  -- yields NULL, not TRUE
        --sequence_of_statements that are not executed
    END IF;

*/





