--============================================================
-- 03 - Writing Executable Statements
--============================================================
/*
    Lexical units:
            blocks.
            letters, numerals, special characters, tabs, spaces, returns, and symbols.
    
    classified:
        (1)Identifiers: Identifiers are the names given to PL/SQL objects. 
                     You learned to identify valid and invalid identifiers. 
                     Recall that keywords cannot be used as identifiers. 
    	    Quoted identifiers: "my_name" nvarchar(50)
                - Make identifiers case-sensitive. 
                - Include characters such as spaces. 
                - Use reserved words.
           !!All subsequent usage of these variables should have double quotation marks!!
    
        (2)Delimiters: Delimiters are symbols that have special meaning. 
                       You already learned that the semicolon (;) is used to terminate a SQL or PL/SQL statement
        
        (3)Literals: Any value that is assigned to a variable is a literal
                - Character
                - Numeric
                - Boolean
                     -> John, 428, True
        (4)Comments: 
                single line : --
                multi line  : /* */
*/
-------------------------------------------------- Commenting Code
DECLARE
	v_annual_sal NUMBER (9,2);
	monthly_sal NUMBER := 1;
BEGIN  
/* Compute the annual salary based on the       
   monthly salary input from the user 
*/
	v_annual_sal := monthly_sal * 12;
--The following line displays the annual salary 
	DBMS_OUTPUT.PUT_LINE(v_annual_sal);
END;

-------------------------------------------------- SQL Functions in PL/SQL: Examples
/*
SQL provides several predefined functions that can be used in SQL statements. Most of these functions (such as single-row number and character functions, data type conversion functions, and date and time-stamp functions) are valid in PL/SQL expressions.

The following functions are not available in procedural statements:
DECODE
Group functions: AVG, MIN, MAX, COUNT, SUM, STDDEV, and VARIANCE Group functions apply to groups of rows in a table and are, therefore, available only in SQL statements in a PL/SQL block. The functions mentioned here are only a subset of the complete list.

*/
DECLARE
	v_desc_size        INTEGER(5);
	v_prod_description VARCHAR2(70) := 'You can use this product with your radios for higher frequency';
BEGIN
-- get the length of the string in prod_description
	v_desc_size := length(v_prod_description);
	DBMS_OUTPUT.PUT_LINE(v_desc_size);
END;
--***** ***** ***** ***** *****
DECLARE 
  -- Local variables here
	v_tenure   INTEGER;
	v_hiredate DATE := current_date - ( 4 * 30 );
BEGIN
  -- Test statements here
	v_tenure := months_between(current_date, v_hiredate);
	dbms_output.put_line(v_tenure);
END;

-------------------------------------------------- Using Sequences in PL/SQL Expressions
/* NEXTVAL and CURRVAL

DROP SEQUENCE my_seq;
CREATE SEQUENCE my_seq CACHE 20;
*/
-- Before 11g:
DECLARE
   v_new_id NUMBER;
BEGIN
   SELECT my_seq.nextval
   INTO v_new_id
   FROM DUAL;

   DBMS_OUTPUT.PUT_LINE(v_new_id);
END;

-- Starting in 11g:
DECLARE
   v_new_id NUMBER;
BEGIN
   v_new_id := my_seq.nextval;
   DBMS_OUTPUT.PUT_LINE(v_new_id);
END;
/*
FIRST Time:  NEXTVAL 
else
    ORA-08002: sequence MY_SEQ.CURRVAL is not yet defined in this session 
*/
SELECT MY_SEQ.NEXTVAL
FROM dual;

SELECT MY_SEQ.currval
FROM DUAL;

-------------------------------------------------- Data Type Conversion
/*
Converts data to comparable data types
Is of two types:
    Implicit conversion
        can be between: 
            Characters and numbers
            Characters and dates

    Explicit conversion
Functions:
    TO_CHAR
    TO_DATE
    TO_NUMBER
    TO_TIMESTAMP

*/
DECLARE
   v_salary       NUMBER(6)   := 6000;
   v_sal_hike     VARCHAR2(5) := '1000';
   v_total_salary v_salary %TYPE;
BEGIN
   v_total_salary := v_salary + v_sal_hike;

   DBMS_OUTPUT.PUT_LINE(v_total_salary);
END;

-- implicit data type conversion
v_date_of_joining DATE:= '02-Feb-2000';

-- error in data type conversion
v_date_of_joining DATE:= 'February 02,2000';

-- explicit data type conversion
v_date_of_joining DATE:= TO_DATE('February 02,2000','Month DD, YYYY');

-------------------------------------------------- Nested Blocks: Example
/*
LOCAL VARIABLE
GLOBAL VARIABLE
GLOBAL VARIABLE
*/
DECLARE
	v_outer_variable VARCHAR2(20) := 'GLOBAL VARIABLE';
BEGIN
	DECLARE
		v_inner_variable VARCHAR2(20) := 'LOCAL VARIABLE';
	BEGIN
		dbms_output.put_line(v_inner_variable);
		dbms_output.put_line(v_outer_variable);
	END;

	dbms_output.put_line(v_outer_variable);
END;

-------------------------------------------------- Variable Scope and Visibility
/*
Set:
Father's Name: Patrick
Date of Birth: 20-Apr-1972
Child's Name: Mike
Date of Birth: 12-Dec-2002

Print:
Father's Name: Patrick
Date of Birth: 12-DEC-02
Child's Name: Mike
Date of Birth: 20-APR-72
*/
DECLARE
   v_father_name   VARCHAR2(20) := 'Patrick';
   v_date_of_birth DATE         := '20-Apr-1972';
BEGIN
   DECLARE
      v_child_name    VARCHAR2(20) := 'Mike';
      v_date_of_birth DATE         := '12-Dec-2002';
   BEGIN
      DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name);
      DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);
      DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
   END;

   DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);
END;

-------------------------------------------------- Using a Qualifier with Nested Blocks
/*
Father's Name: Patrick
Date of Birth: 20-APR-72
Child's Name: Mike
Date of Birth: 12-DEC-02
*/
BEGIN

<< outer >>
   DECLARE
      v_father_name   VARCHAR2(20) := 'Patrick';
      v_date_of_birth DATE         := '20-Apr-1972';
   BEGIN
      DECLARE
         v_child_name    VARCHAR2(20) := 'Mike';
         v_date_of_birth DATE         := '12-Dec-2002';
      BEGIN
         DBMS_OUTPUT.PUT_LINE('Father''s Name: ' || v_father_name);
         DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || outer.v_date_of_birth);
         DBMS_OUTPUT.PUT_LINE('Child''s Name: ' || v_child_name);
         DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_date_of_birth);
      END;
   END;

END outer;

-------------------------------------------------- Challenge: Determining Variable Scope
BEGIN

<< outer >>
   DECLARE
      v_sal     NUMBER(7, 2)  := 60000;
      v_comm    NUMBER(7, 2)  := v_sal * 0.20;
      v_message VARCHAR2(255) := ' eligible for commission';
   BEGIN
      DECLARE
         v_sal        NUMBER(7, 2) := 50000;
         v_comm       NUMBER(7, 2) := 0;
         v_total_comp NUMBER(7, 2) := v_sal + v_comm;
      BEGIN
         -- CLERK not eligible for commission
         v_message := 'CLERK not' || v_message;
         outer.v_comm := v_sal * 0.30;

         DBMS_OUTPUT.PUT_LINE(v_message);
         DBMS_OUTPUT.PUT_LINE('Inner ->	v_sal:' || v_sal || ', v_comm:' || v_comm);
         DBMS_OUTPUT.PUT_LINE('outer ->	v_comm:' || outer.v_comm);
      END;

      v_message := 'SALESMAN' || v_message;
   END;

END outer;

--------------------------------------------------  P2-23      Operators in PL/SQL
-- Exponential operator (**)
BEGIN
    DBMS_OUTPUT.PUT_LINE(4 ** 2);
END;

-- no SQL Statement
-- ORA-00936: missing expression
SELECT (5**2)
FROM DUAL;

SELECT POWER(4, 2)
FROM DUAL;

SELECT POWER(4, -2)  --> 1/16
FROM DUAL;


-------------------------------------------------- Operators in PL/SQL: Examples
-- Increment the counter for a loop.
loop_count := loop_count + 1;

-- Set the value of a Boolean flag. 
good_sal := sal BETWEEN 50000 AND 150000;

-- Validate whether an employee number contains a value
valid	:= (empno IS NOT NULL);

----------------- null value
/*
When you are working with nulls, 
you can avoid some common mistakes by keeping in mind the following rules:
    - Comparisons involving nulls always yield NULL.
    - Applying the logical operator NOT to a null yields NULL.
    - In conditional control statements, 
        if the condition yields NULL, 
        its associated sequence of statements is not executed.
*/

DECLARE
   x NUMBER;
   y NUMBER := -1;
BEGIN

   IF x = 0 THEN
      y := 1;
   ELSE
      DBMS_OUTPUT.PUT_LINE(y);
   END IF;

END;
------------------------------------------------- Indenting Code

BEGIN
  IF x=0 THEN
     y:=1;
  END IF;
END;
/

DECLARE
  deptno       NUMBER(4);
  location_id  NUMBER(4);
BEGIN
  SELECT	department_id,
         	location_id
  INTO		deptno,
			location_id
  FROM		departments
  WHERE	department_name 
          = 'Sales';   
...
END;
/

