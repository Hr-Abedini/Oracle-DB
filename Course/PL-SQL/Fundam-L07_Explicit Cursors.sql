--============================================================
--          Using Explicit Cursors
--============================================================
/*
private SQL areas:
    to execute SQL statements and to store processing information

You can use explicit cursors to name a private SQL area and to access its stored information. 

active set: The set of rows returned by a multiple-row query 

--------------------------------------------------
syntax:
    CURSOR cursor_name IS
         select_statement;

*/
DECLARE
   /*
    defining a cursor in the declarative section and not retrieving any rows into the cursor.
   */
   CURSOR c_emp_cursor
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;

BEGIN
   NULL;
END;
/

---------------------
DECLARE
   v_locid NUMBER := 1700;

   CURSOR c_dept_cursor
   IS
      SELECT *
      FROM DEPARTMENTS
      WHERE LOCATION_ID = v_locid;

BEGIN
   NULL;
END;
/
--------------------------------------------------P7-11 Opening the Cursor
DECLARE
    CURSOR c_emp_cursor 
    IS 
       SELECT EMPLOYEE_ID,
              LAST_NAME
       FROM EMPLOYEES
       WHERE DEPARTMENT_ID = 30;
    ...
BEGIN
  OPEN c_emp_cursor;
  ...
END;

/

--------------------------------------------------P7-12 Fetching Data from the Cursor
-- 114  Raphaely

DECLARE
   CURSOR c_emp_cursor -- 2 columns
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;

   v_empno EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_lname EMPLOYEES.LAST_NAME % TYPE;

BEGIN
   OPEN c_emp_cursor;

   FETCH c_emp_cursor INTO v_empno, v_lname;

   DBMS_OUTPUT.PUT_LINE(v_empno || '  ' || v_lname);
END;
/

---------------------
/*
clear screen
cl scr
host clear 
ho clear
*/
DECLARE
   CURSOR c_emp_cursor  --2 Columns
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;

   v_empno EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_lname EMPLOYEES.LAST_NAME % TYPE;

BEGIN
   OPEN c_emp_cursor;

   LOOP
      FETCH c_emp_cursor INTO v_empno, v_lname;
      EXIT WHEN c_emp_cursor % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_empno || '  ' || v_lname);
   END LOOP;
END;
/

--------------------------------------------------P7-15 Closing the Cursor
DECLARE
   CURSOR c_emp_cursor  --2 Columns
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;

   v_empno EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_lname EMPLOYEES.LAST_NAME % TYPE;

BEGIN
   OPEN c_emp_cursor;

   LOOP
      FETCH c_emp_cursor INTO v_empno, v_lname;
      EXIT WHEN c_emp_cursor % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_lname);
   END LOOP;
   --**********
   CLOSE c_emp_cursor;
END;
/

--------------------------------------------------P7-16 Cursors and Records
DECLARE
   CURSOR c_emp_cursor  --2 columns
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;
   --**********
   v_emp_record c_emp_cursor % ROWTYPE;

BEGIN
   OPEN c_emp_cursor;

   LOOP
      FETCH c_emp_cursor INTO v_emp_record;
      EXIT WHEN c_emp_cursor % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_emp_record.EMPLOYEE_ID || ' ' || v_emp_record.LAST_NAME);
   END LOOP;

   CLOSE c_emp_cursor;
END;
/

--------------------------------------------------P7-17 Cursor FOR Loops
/*
Syntax:
    FOR record_name IN cursor_name LOOP   
        statement1;
        statement2;
        . . .
    END LOOP;
*/
DECLARE
   CURSOR c_emp_cursor --**
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = 30;

BEGIN

   FOR EMP_RECORD IN c_emp_cursor --**********
   LOOP
      DBMS_OUTPUT.PUT_LINE(EMP_RECORD.EMPLOYEE_ID || ' ' || EMP_RECORD.LAST_NAME);
   END LOOP;

END;
/

--------------------------------------------------P7-19 Explicit Cursor Attributes
/*
%ISOPEN:    Evaluates to TRUE if the cursor is open

%NOTFOUND
%FOUND
%ROWCOUNT:  Evaluates to the total number of rows returned so far

--------------------- %ISOPEN Attribute
IF NOT c_emp_cursor%ISOPEN THEN
	OPEN c_emp_cursor;
END IF;
LOOP
  FETCH c_emp_cursor...

*/
DECLARE
   CURSOR c_emp_cursor
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES;

   v_emp_record c_emp_cursor % ROWTYPE;

BEGIN
   OPEN c_emp_cursor;

   LOOP
      FETCH c_emp_cursor INTO v_emp_record;
      EXIT WHEN c_emp_cursor % ROWCOUNT > 10 OR c_emp_cursor % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_emp_record.EMPLOYEE_ID || ' ' || v_emp_record.LAST_NAME);
   END LOOP;
   CLOSE c_emp_cursor;
END;
/

--------------------------------------------------P7-22 Cursor FOR Loops Using Subqueries
BEGIN

   FOR EMP_RECORD IN
   (
    SELECT
           EMPLOYEE_ID,
           LAST_NAME
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 30
   )
   LOOP
      --X -> ?%ROWCOUNT, ?%NOTFOUND
      DBMS_OUTPUT.PUT_LINE(EMP_RECORD.EMPLOYEE_ID || ' ' || EMP_RECORD.LAST_NAME);
   END LOOP;

END;
/

--------------------------------------------------P7-24 Cursors with Parameters
/*
Syntax:
    CURSOR cursor_name [(parameter_name datatype, ...)]
    IS
        select_statement;
    ....
    OPEN		cursor_name(parameter_value,.....) ;


Parameter data types are the same as those for scalar variables,
but you do not give them sizes. 

---------------------
DECLARE
    CURSOR   c_emp_cursor (deptno NUMBER) 
    IS
        SELECT  employee_id, last_name
        FROM    employees
        WHERE   department_id = deptno;
   ...
BEGIN
  OPEN c_emp_cursor (10);
  ...
  CLOSE c_emp_cursor;
  OPEN c_emp_cursor (20);
  ...

---------------------
DECLARE
    CURSOR c_emp_cursor(p_deptno NUMBER, p_job VARCHAR2)
    IS
       SELECT ...    
BEGIN
   FOR emp_record IN c_emp_cursor(10, 'Sales') 
   LOOP ...


*/
DECLARE
   CURSOR c_emp_cursor(dep_id NUMBER)
   IS
      SELECT EMPLOYEE_ID,
             LAST_NAME
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = dep_id;

   v_emp_record c_emp_cursor % ROWTYPE;

BEGIN

   DBMS_OUTPUT.PUT_LINE('-----------------------Dep ID:30');

   OPEN c_emp_cursor (30);

   LOOP
      FETCH c_emp_cursor INTO v_emp_record;
      EXIT WHEN c_emp_cursor % ROWCOUNT > 10 OR c_emp_cursor % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_emp_record.EMPLOYEE_ID || ' ' || v_emp_record.LAST_NAME);
   END LOOP;
   CLOSE c_emp_cursor;

   DBMS_OUTPUT.PUT_LINE('-----------------------Dep ID:40');

   FOR EMP_RECORD IN c_emp_cursor(40) --**
   LOOP
      DBMS_OUTPUT.PUT_LINE(EMP_RECORD.EMPLOYEE_ID || ' ' || EMP_RECORD.LAST_NAME);
   END LOOP;

END;
/

--------------------------------------------------P7-27 FOR UPDATE Clause
/*
Locking rows and referencing the current row

Syntax:
    SELECT	... 
    FROM		...
    FOR UPDATE [OF column_reference][NOWAIT | WAIT n];

***  You see the updated data only when you reopen the cursor
Therefore, it is better to have locks on the rows before you update or delete rows.


The FOR UPDATE clause is the last clause in a SELECT statement,
even after ORDER BY (if it exists)

you can use the FOR UPDATE clause to confine row locking to particular tables. 
FOR UPDATE OF col_name(s) locks rows only in tables that contain col_name(s).

NOWAIT:
The optional NOWAIT keyword tells the Oracle Server not to wait 
if the requested rows have been locked by another user.

If the rows are locked by another session and you have specified NOWAIT, 
opening the cursor results in an error.

wait n:
If the rows are still locked after n seconds, an error is returned.


It is not mandatory for the FOR UPDATE OF clause to refer to a column, 
but it is recommended for better readability and maintenance.
*/

--------------------------------------------------P7-29 WHERE CURRENT OF Clause
/*
Syntax:
    WHERE CURRENT OF cursor ;

UPDATE employees 
    SET    salary = ... 
    WHERE CURRENT OF c_emp_cursor;


Syntax:

Use cursors to update or delete the current row.
Include the FOR UPDATE clause in the cursor query to first lock the rows.
Use the WHERE CURRENT OF clause to reference the current row from an explicit cursor.

*/

DECLARE

   CURSOR curs_emp(prm_name NUMBER)
   IS
      SELECT E.FIRST_NAME,
             E.LAST_NAME
      FROM EMPLOYEES E
      WHERE E.DEPARTMENT_ID = prm_name
      FOR UPDATE OF E.FIRST_NAME, E.LAST_NAME;

   rec_emp curs_emp % ROWTYPE;

BEGIN

   OPEN curs_emp (30);
   FETCH curs_emp INTO rec_emp; --1
   FETCH curs_emp INTO rec_emp; --2   


   IF curs_emp % NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('Not Found Data!');

   ELSE
      DELETE FROM EMPLOYEES
      WHERE CURRENT OF curs_emp;

      DBMS_OUTPUT.PUT_LINE('Delete: ' || rec_emp.LAST_NAME || ' - ' || rec_emp.FIRST_NAME);

      FETCH curs_emp INTO rec_emp; --3

      IF curs_emp % FOUND THEN
         UPDATE EMPLOYEES
         SET FIRST_NAME = 'test'
         WHERE CURRENT OF curs_emp;

         DBMS_OUTPUT.PUT_LINE('Update: ' || rec_emp.LAST_NAME || ' - ' || rec_emp.FIRST_NAME);
      END IF;
   --COMMIT;

   END IF;

   CLOSE curs_emp;



END;
/

SELECT E.FIRST_NAME,
       E.LAST_NAME
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID = 30;

ROLLBACK;

/
--======================================================
--******************************************************
--======================================================
-------------------------------------------------------- Current Of
DECLARE
   row_emp EMPLOYEES%ROWTYPE;

   CURSOR cur
   IS
   SELECT *
   FROM EMPLOYEES
   WHERE TO_CHAR(HIRE_DATE, 'RRRR') < '2000'
   FOR UPDATE;

BEGIN

   OPEN cur;

   LOOP
      FETCH cur INTO row_emp;

      EXIT WHEN cur%NOTFOUND;

      INSERT INTO employees_archive
      VALUES row_emp;

      DELETE FROM EMPLOYEES
      WHERE CURRENT OF cur;
   END LOOP;

   COMMIT;

   CLOSE cur;
END;
/
----------------------
DECLARE
   l_n_sal   EMPLOYEES.SALARY % TYPE;
   l_r_rowid ROWID;

   CURSOR cur
   IS
      SELECT E.ROWID,
             E.SALARY
      FROM EMPLOYEES E,
           DEPARTMENTS D
      WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
            AND D.DEPARTMENT_NAME = 'IT' FOR UPDATE OF E.EMPLOYEE_ID;

BEGIN

   OPEN cur;

   LOOP

      FETCH cur INTO l_r_rowid, l_n_sal;

      UPDATE EMPLOYEES
      SET SALARY = l_n_sal * 1.10
      WHERE ROWID = l_r_rowid;
      -- ORA-01410: invalid ROWID
      --WHERE CURRENT OF cur;

      EXIT WHEN cur % NOTFOUND;

   END LOOP;

END;

/
--------------------------------------------------------1.TYPE
DECLARE
   CURSOR cur_emp
   IS
      SELECT E.EMPLOYEE_ID,
             E.FIRST_NAME || ' ' || E.LAST_NAME AS FL_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

   v_emp_id  EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_fl_name EMPLOYEES.FIRST_NAME % TYPE;

BEGIN
   OPEN cur_emp;

   LOOP
      FETCH cur_emp
      INTO v_emp_id, v_fl_name;

      EXIT WHEN cur_emp % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_emp_id || ' ' || v_fl_name);

   END LOOP;

   CLOSE cur_emp;

END;
/

--------------------------------------------------------2.ROWTYPE
DECLARE
   CURSOR cur_emp
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME AS FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

   v_emp_rec cur_emp % ROWTYPE;

BEGIN
   OPEN cur_emp;

   LOOP
      FETCH cur_emp
      INTO v_emp_rec;

      EXIT WHEN cur_emp % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(v_emp_rec.EMPLOYEE_ID || ' ' || v_emp_rec.fl_name);

   END LOOP;

   CLOSE cur_emp;

END;
/

--------------------------------------------------------3.Index Table - BULK COLLECT
-- Key number = 1 .. 107
DECLARE
   CURSOR cur_emp
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME AS FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

   TYPE emp_coll_type IS TABLE
      OF cur_emp % ROWTYPE
      INDEX BY PLS_INTEGER;

   v_emp_coll emp_coll_type;

BEGIN
   OPEN cur_emp;

   FETCH cur_emp BULK COLLECT
   INTO v_emp_coll;

   CLOSE cur_emp;

   FOR I IN v_emp_coll.first .. v_emp_coll.last
   LOOP
      DBMS_OUTPUT.PUT_LINE(v_emp_coll(I).EMPLOYEE_ID || ' ' || v_emp_coll(I).SALARY || ' ' || v_emp_coll(I).fl_name);
   END LOOP;

END;
/

--------------------------------------------------------4.Select-BULK Collect
-- Key number = 1 .. 107
DECLARE

   TYPE emp_coll_type IS TABLE
      OF EMPLOYEES % ROWTYPE
      INDEX BY PLS_INTEGER;

   v_emp_coll emp_coll_type;

BEGIN
   SELECT *
   BULK COLLECT INTO v_emp_coll
   FROM EMPLOYEES;

   DBMS_OUTPUT.PUT_LINE(v_emp_coll.first);
   DBMS_OUTPUT.PUT_LINE(v_emp_coll.last);

END;

/

--------------------------------------------------------5
DECLARE
   CURSOR cur_emp(prm_dep_id DEPARTMENTS.DEPARTMENT_ID % TYPE)
   IS
      SELECT E.EMPLOYEE_ID,
             E.FIRST_NAME || ' ' || E.LAST_NAME AS FL_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID = prm_dep_id;

   v_emp_id  EMPLOYEES.EMPLOYEE_ID % TYPE;
   v_fl_name EMPLOYEES.FIRST_NAME % TYPE;

BEGIN
   OPEN cur_emp (&p_dep_id1);

   LOOP
      FETCH cur_emp
      INTO v_emp_id, v_fl_name;

      EXIT WHEN cur_emp % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_emp_id || ' ' || v_fl_name);

   END LOOP;

   CLOSE cur_emp;
   /******************/
   DBMS_OUTPUT.PUT_LINE('/*********************/');
   /******************/
   OPEN cur_emp (&p_dep_id2);

   LOOP
      FETCH cur_emp
      INTO v_emp_id, v_fl_name;
      EXIT WHEN cur_emp % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_emp_id || ' ' || v_fl_name);

   END LOOP;

   CLOSE cur_emp;

END;
/

-------------------------------------------------------- 6
DECLARE
   CURSOR cur_emp
   IS
      SELECT E.EMPLOYEE_ID,
             E.FIRST_NAME || ' ' || E.LAST_NAME FL_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

BEGIN

   FOR R IN cur_emp
   LOOP

      DBMS_OUTPUT.PUT_LINE(R.EMPLOYEE_ID || ' ' || R.fl_name);

   END LOOP;

END;
/

--------------------------------------------------------7
DECLARE
   CURSOR cur_emp
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

   v_emp_rec cur_emp % ROWTYPE;

BEGIN

   FOR R IN cur_emp
   LOOP
      v_emp_rec := R;

      DBMS_OUTPUT.PUT_LINE(v_emp_rec.EMPLOYEE_ID || ' ' || v_emp_rec.fl_name);

   END LOOP;

END;
/

--------------------------------------------------------8
DECLARE
   CURSOR cur_emp(p_dep_id NUMBER)
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID = p_dep_id;

   TYPE emp_coll_type IS TABLE
      OF cur_emp % ROWTYPE
      INDEX BY PLS_INTEGER;
   v_emp_coll emp_coll_type;
   v_dep_id   DEPARTMENTS.DEPARTMENT_ID % TYPE := 10;

BEGIN

<< outer_loop >>
   LOOP

      FOR R IN cur_emp(v_dep_id)
      LOOP
         v_emp_coll(R.EMPLOYEE_ID) := R;
      END LOOP;

      /****************/
      v_dep_id := v_dep_id + 10;
      EXIT WHEN v_dep_id > 100;
   /****************/
   END LOOP outer_loop;
   /****************/

   FOR I IN v_emp_coll.first .. v_emp_coll.last
   LOOP

      IF v_emp_coll.exists(I) THEN
         DBMS_OUTPUT.PUT_LINE(v_emp_coll(I).EMPLOYEE_ID || ' ' || v_emp_coll(I).SALARY || ' ' || v_emp_coll(I).fl_name);
      END IF;

   END LOOP;

   DBMS_OUTPUT.PUT_LINE('/****************/');

END;
/

--------------------------------------------------------9
--------------------------------------------------------10
--------------------------------------------------------11
DECLARE
   TYPE emp_info_coll IS TABLE
      OF EMPLOYEES % ROWTYPE
      INDEX BY PLS_INTEGER;
   v_emp_info emp_info_coll;

BEGIN

   FOR R IN
   (
    SELECT
           *
    FROM EMPLOYEES E
    WHERE E.DEPARTMENT_ID IN (20, 90, 110)
   )
   LOOP
      v_emp_info(R.EMPLOYEE_ID) := R;

   END LOOP;

   FOR I IN v_emp_info.first .. v_emp_info.last
   LOOP
      -- ORA-01403: no data found
      -- IF v_emp_info.exists(I) THEN
      DBMS_OUTPUT.PUT_LINE(v_emp_info(I).EMPLOYEE_ID || ' --- ' || v_emp_info(I).FIRST_NAME || ' ' || v_emp_info(I).LAST_NAME);
   -- END IF;

   END LOOP;

END;
/

--------------------------------------------------------12 - For Update
DECLARE
   CURSOR cur
   IS
      SELECT *
      FROM EMPLOYEES E
      WHERE E.DEPARTMENT_ID BETWEEN 50 AND 80
      FOR UPDATE;
   TYPE coll_emp IS TABLE
      OF cur % ROWTYPE;
   v_emp coll_emp;

BEGIN
   OPEN cur;
   FETCH cur BULK COLLECT
   INTO v_emp;
   CLOSE cur;

   dbms_lock.sleep(50);

   FOR I IN v_emp.first .. v_emp.last
   LOOP
      UPDATE EMPLOYEES E
      SET E.SALARY = 1
      WHERE E.EMPLOYEE_ID = v_emp(I).EMPLOYEE_ID;
   END LOOP;

END;
/

--------------------------------------------------------13
SELECT *
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID = 106 FOR UPDATE
/

--------------------------------------------------------14
DECLARE
   CURSOR cur
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID BETWEEN 50 AND 80
      FOR UPDATE OF JOB_ID;

   TYPE coll_emp IS TABLE
      OF cur % ROWTYPE;
   v_emp coll_emp;

BEGIN
   OPEN cur;

   FETCH cur BULK COLLECT
   INTO v_emp;

   CLOSE cur;

   dbms_lock.sleep(50);

   FOR I IN v_emp.first .. v_emp.last
   LOOP
      UPDATE EMPLOYEES E
      SET E.SALARY = 1
      WHERE E.EMPLOYEE_ID = v_emp(I).EMPLOYEE_ID;
   END LOOP;

END;
/
--------------------------------------------------------15

SELECT T.*,
       T.ROWID
FROM DEPARTMENTS T;
/
--------------------------------------------------------16
DECLARE
   CURSOR cur
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID BETWEEN 50 AND 80
      FOR UPDATE OF JOB_ID;

BEGIN

   FOR R IN cur
   LOOP
      UPDATE EMPLOYEES E
      SET E.SALARY = 1
      WHERE CURRENT OF cur;
      dbms_lock.sleep(10);
   END LOOP;

END;
/

--------------------------------------------------------17
DECLARE
   CURSOR cur_emp(p_dep_id NUMBER)
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID = p_dep_id;

   TYPE emp_coll_type IS TABLE
      OF cur_emp % ROWTYPE
      INDEX BY PLS_INTEGER;
   v_emp_coll emp_coll_type;
   v_dep_id   DEPARTMENTS.DEPARTMENT_ID % TYPE := 10;

BEGIN

<< outer_loop >>
   LOOP

      v_emp_coll := emp_coll_type();

      FOR R IN cur_emp(v_dep_id)
      LOOP
         v_emp_coll(R.EMPLOYEE_ID) := R;
      END LOOP;
      /****************/

      FOR I IN v_emp_coll.first .. v_emp_coll.last
      LOOP

         IF v_emp_coll.exists(I) THEN
            DBMS_OUTPUT.PUT_LINE(v_emp_coll(I).EMPLOYEE_ID || ' ' || v_emp_coll(I).SALARY || ' ' || v_emp_coll(I).fl_name);
         END IF;

      END LOOP;

      /****************/
      v_dep_id := v_dep_id + 10;
      EXIT WHEN v_dep_id > 100;
   /****************/
   END LOOP outer_loop;
   /****************/

   DBMS_OUTPUT.PUT_LINE('/****************/');

END;
/

--------------------------------------------------------18
DECLARE
   CURSOR cur_emp(p_dep_id NUMBER)
   IS
      SELECT E.EMPLOYEE_ID,
             E.SALARY,
             E.FIRST_NAME || ' ' || E.LAST_NAME FL_NAME,
             D.DEPARTMENT_NAME
      FROM EMPLOYEES E
      INNER JOIN DEPARTMENTS D
           ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
      WHERE E.DEPARTMENT_ID = p_dep_id;

   TYPE emp_coll_type IS TABLE
      OF cur_emp % ROWTYPE
      INDEX BY PLS_INTEGER;
   v_emp_coll emp_coll_type;
   v_dep_id   DEPARTMENTS.DEPARTMENT_ID % TYPE := 10;

BEGIN

<< outer_loop >>
   LOOP

      FOR R IN cur_emp(v_dep_id)
      LOOP
         v_emp_coll(R.EMPLOYEE_ID) := R;
      END LOOP;
      /****************/

      FOR I IN v_emp_coll.first .. v_emp_coll.last
      LOOP

         IF v_emp_coll.exists(I) THEN
            DBMS_OUTPUT.PUT_LINE(v_emp_coll(I).EMPLOYEE_ID || ' ' || v_emp_coll(I).SALARY || ' ' || v_emp_coll(I).fl_name);
         END IF;

      END LOOP;

      /****************/
      v_dep_id := v_dep_id + 10;
      EXIT WHEN v_dep_id > 100;
   /****************/
   END LOOP outer_loop;
   /****************/

   DBMS_OUTPUT.PUT_LINE('/****************/');

END;
/

--------------------------------------------------------19
--------------------------------------------------------20