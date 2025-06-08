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

   Using PL/SQL collections
        - Examining associative arrays (INDEX BY Tables)
        - Introducing nested tables    (detail in the course Oracle Database 11g: Advanced PL/SQL.)
        - Introducing VARRAY           (detail in the course Oracle Database 11g: Advanced PL/SQL.)

*/
--------------------------------------------------P6-18 Associative Arrays (INDEX BY Tables)
/*Associative = همبند
  Key (Unique) - Values

    with two columns:
        - Primary key of integer or string data type
            Unique Key Column
            Numeric, either BINARY_INTEGER or PLS_INTEGER
            VARCHAR2 or one of its subtypes

        - Column of scalar or record data type
            The second column either holds one value per row (scalar),
                 or multiple values (record).

BINARY_INTEGER or PLS_INTEGER:
    These two numeric data types require less storage than NUMBER, 
    and arithmetic operations on these data types are faster than the NUMBER arithmetic.
*/
--============================================================
--============================================================
-- Steps to Create an Associative Array
--============================================================
--============================================================
/*
syntax:
TYPE type_name IS TABLE OF 
     {column_type | variable%TYPE | table.column%TYPE} [NOT NULL] 
     | table%ROWTYPE  
     | INDEX BY PLS_INTEGER | BINARY_INTEGER | VARCHAR2(<size>)
;

identifier	 type_name;


example:

...
TYPE ename_table_type IS TABLE OF 
    employees.last_name%TYPE
    INDEX BY PLS_INTEGER;
... 
ename_table ename_table_type;

*/
DECLARE
   TYPE ename_table_type IS TABLE
      OF EMPLOYEES.LAST_NAME % TYPE
      INDEX BY PLS_INTEGER;

   TYPE hiredate_table_type IS TABLE
      OF DATE
      INDEX BY PLS_INTEGER;

   ename_table    ename_table_type;
   hiredate_table hiredate_table_type;

BEGIN
   ename_table(1) := 'CAMERON';
   hiredate_table(8) := SYSDATE + 7;
--IF ename_table.EXISTS(1) THEN
--INSERT INTO ...
--...
END;
/

-------------------------------------------------- P6-22 Using INDEX BY Table Methods
/*
The following methods make associative arrays easier to use:
    1.EXISTS          
    2.COUNT
    3.FIRST 
    4.LAST
    5.PRIOR
    6.NEXT
    7.DELETE

Syntax: table_name.method_name[ (parameters) ]

*/
DECLARE
   TYPE dept_table_type IS TABLE
      OF DEPARTMENTS % ROWTYPE
      INDEX BY PLS_INTEGER;

   dept_table dept_table_type;
-- Each element of dept_table is a record 

BEGIN
   SELECT *
   INTO dept_table(1)
   FROM DEPARTMENTS
   WHERE DEPARTMENT_ID = 10;
   DBMS_OUTPUT.PUT_LINE(dept_table(1).DEPARTMENT_ID || '-' || 
                        dept_table(1).DEPARTMENT_NAME || '-' || 
                        dept_table(1).MANAGER_ID);
END;
/

--------------------------------------------------P6-24  INDEX BY Table of Records Option: Example 2
DECLARE
   TYPE emp_table_type IS TABLE
      OF EMPLOYEES % ROWTYPE
      INDEX BY PLS_INTEGER;

   my_emp_table emp_table_type;
   max_count    NUMBER(3) := 104;

BEGIN

   FOR I IN 100 .. max_count
   LOOP
      SELECT *
      INTO my_emp_table(I)
      FROM EMPLOYEES
      WHERE EMPLOYEE_ID = I;
   END LOOP;

   FOR I IN my_emp_table.first .. my_emp_table.last
   LOOP
      DBMS_OUTPUT.PUT_LINE(my_emp_table(I).LAST_NAME);
   END LOOP;

END;
/
--============================================================
--============================================================
-- Nested Tables
--============================================================
--============================================================
/*
In other words, it is a table within a table

- The nested table is a valid data type in a schema-level table, but an associative array is not. 
    Therefore, unlike associative arrays, nested tables can be stored in the database.
- The size of a nested table can increase dynamically, although the maximum size is 2 GB.
- The “key” cannot be a negative value (unlike in the associative array). Though reference is made to the first column as key, there is no key in a nested table. There is a column with numbers.
- Elements can be deleted from anywhere in a nested table, leaving a sparse table with nonsequential “keys.” The rows of a nested table are not in any particular order.
- When you retrieve values from a nested table, the rows are given consecutive subscripts starting from 1.

The key must also be in a sequence.

Syntax	
    TYPE type_name IS TABLE OF
     {column_type | variable%TYPE | table.column%TYPE} [NOT NULL]
     | table.%ROWTYPE

Example:
    TYPE location_type IS TABLE 
        OF locations.city%TYPE;
    
    offices location_type;

initialize nested table by using a constructor:
    offices := location_type('Bombay', 'Tokyo','Singapore', 'Oxford');


*/

SET SERVEROUTPUT ON;

DECLARE
   TYPE location_type IS TABLE
      OF LOCATIONS.CITY % TYPE;

   offices     location_type;
   table_count NUMBER;

BEGIN
   offices := location_type('Bombay', 'Tokyo', 'Singapore', 'Oxford');

   FOR I IN 1 .. offices.count()
   LOOP
      DBMS_OUTPUT.PUT_LINE(offices(I));
   END LOOP;

END;
/
--============================================================
--============================================================
-- VARRAY (variable-size array)
--============================================================
--============================================================
/*
A VARRAY is valid in a schema-level table.
Items of VARRAY type are called VARRAYs.
VARRAYs have a fixed upper bound. You have to specify the upper bound when you declare them. This is similar to arrays in C language. The maximum size of a VARRAY is 2 GB, as in nested tables.
    (although you can change the number of elements at run time)
The distinction between a nested table and a VARRAY is the physical storage mode. The elements of a VARRAY are stored inline with the table’s data unless the size of the VARRAY is greater than 4 KB. Contrast that with nested tables, which are always stored out-of-line.
You can create a VARRAY type in the database by using SQL.


Example:
    TYPE location_type IS VARRAY(3) 
        OF locations.city%TYPE;

    offices location_type;

-->Error: “Subscript outside of limit”    
*/

--============================================================
--============================================================
--============================================================

DECLARE
   TYPE coll_emp_hire_date IS TABLE
      OF DATE
      INDEX BY PLS_INTEGER;

   v_emp_hire_date coll_emp_hire_date;
   v_curr_index    PLS_INTEGER;

BEGIN
   v_emp_hire_date(109) := DATE '2015-12-03';
   v_emp_hire_date(105) := DATE '2018-02-22';
   v_emp_hire_date(100) := DATE '2016-04-15';
   v_emp_hire_date(120) := DATE '2019-07-11';

   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.first);
   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.last);
   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.prior(105));
   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.next(105));
   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.count);

--   v_emp_hire_date.delete(105);
--   DBMS_OUTPUT.PUT_LINE(v_emp_hire_date.count);

   /*
   FOR key IN v_emp_hire_date.first .. v_emp_hire_date.last
   LOOP

      IF v_emp_hire_date.exists(key) THEN
         DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_emp_hire_date(key), 'yyyy-mm-dd'));
      END IF;

   END LOOP;
   */
   /******************/
   v_curr_index := v_emp_hire_date.first;
   LOOP

      DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_emp_hire_date(v_curr_index), 'yyyy-mm-dd'));
      v_curr_index := v_emp_hire_date.next(v_curr_index);
      EXIT WHEN v_curr_index IS NULL;
   END LOOP;

END;

--------------------------
DECLARE
   TYPE coll_emp_info IS TABLE
      OF EMPLOYEES % ROWTYPE

;

   v_emp_info   coll_emp_info := coll_emp_info();
   -- 4 ORA-06531: Reference to uninitialized collection
   -- v_emp_info   coll_emp_info;
   v_curr_index NUMBER(3);

BEGIN

   --FOR I IN &p_emp_id .. &p_to_emp_id
   FOR I IN 105 .. 110
   LOOP
      v_emp_info.extend();

      SELECT *
      INTO v_emp_info(v_emp_info.last)
      FROM EMPLOYEES E
      WHERE E.EMPLOYEE_ID = I;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('first:' || v_emp_info.first);
   DBMS_OUTPUT.PUT_LINE('last:' || v_emp_info.last);
   DBMS_OUTPUT.PUT_LINE('n-1 -> prior-last:' || v_emp_info.prior(v_emp_info.last));
   DBMS_OUTPUT.PUT_LINE('2-> next-first:' || v_emp_info.next(v_emp_info.first));
   DBMS_OUTPUT.PUT_LINE('count:' || v_emp_info.count);

   --v_emp_info.delete(105);   
   --dbms_output.put_line(v_emp_info.count);*/

   FOR INDEXKEY IN v_emp_info.first .. v_emp_info.last
   LOOP

      --IF v_emp_info.exists(indexKey) THEN
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_emp_info(INDEXKEY).HIRE_DATE, 'yyyy-mm-dd'));
   --END IF;

   END LOOP;
   /******************/

--   v_curr_index := v_emp_info.first;
--   LOOP
--
--      DBMS_OUTPUT.PUT_LINE(v_emp_info(v_curr_index).EMPLOYEE_ID || ' --- ' || TO_CHAR(v_emp_info(v_curr_index).HIRE_DATE, 'yyyy-mm-dd'));
--      v_curr_index := v_emp_info.next(v_curr_index);
--      EXIT WHEN v_curr_index IS NULL;
--   END LOOP;

END;