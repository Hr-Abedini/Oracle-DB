--============================================================
--          Handling Exceptions
--============================================================
--------------------------------------------------What Is an Exception?
--ORA-01422: exact fetch returns more than requested number of rows
DECLARE
   v_lname VARCHAR2(15);

BEGIN
   SELECT LAST_NAME
   INTO v_lname
   FROM EMPLOYEES
   WHERE FIRST_NAME = 'John';

   DBMS_OUTPUT.PUT_LINE('John''s last name is :' || v_lname);
END;
/

--------------------------------------------------Handling the Exception: An Example
DECLARE
   v_lname VARCHAR2(15);

BEGIN
   SELECT LAST_NAME
   INTO v_lname
   FROM EMPLOYEES
   WHERE FIRST_NAME = 'John';

   DBMS_OUTPUT.PUT_LINE('John''s last name is :' || v_lname);

EXCEPTION
   WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE(' Your select statement retrieved 
    multiple rows. Consider using a cursor.');
END;
/

--------------------------------------------------
/*
An exception is a PL/SQL error that is raised during program execution.
An exception can be raised:
    -Implicitly by the Oracle Server
    -Explicitly by the program
An exception can be handled:
    -By trapping it with a handler
    -By propagating it to the calling environment

- NO_DATA_FOUND
- TOO_MANY_ROWS
- INVALID_CURSOR
- ZERO_DIVIDE
- DUP_VAL_ON_INDEX


- RAISE statement 
*/
--------------------------------------------------Exception Types
/*
Implicitly raised :
        - Predefined Oracle Server
        - Non-predefined Oracle Server


Explicitly raised
        - User-defined

*/
--------------------------------------------------Syntax to Trap Exceptions
/*
EXCEPTION
  WHEN exception1 [OR exception2 . . .] THEN
    statement1;
    statement2;
    . . .
  [WHEN exception3 [OR exception4 . . .] THEN
    statement1;
    statement2;
    . . .]
  [WHEN OTHERS THEN  --*******--
    statement1;
    statement2;
    . . .]

Note: PL/SQL declares predefined exceptions in the STANDARD package.
*/
-------------------------------------------------- Trapping Non-Predefined Oracle Server Errors
/*
Declarative section
    Declare: Name the exception.
    Associate: Use PRAGMA EXCEPTION_INIT.

EXCEPTION section 
    Reference: Handle the raised exception.


-- PRAGMA EXCEPTION_INIT function

Note: PRAGMA (also called pseudoinstructions) is the keyword 
      that signifies that the statement is a compiler directive, 
      which is not processed when the PL/SQL block is executed.

-- SQLERRM: SQL Error Message
*/

DECLARE
   E_INSERT_EXCEP EXCEPTION;
   -- non-predefined exceptions.
   PRAGMA EXCEPTION_INIT (E_INSERT_EXCEP, -01400);

BEGIN
   INSERT INTO DEPARTMENTS
   (
     DEPARTMENT_ID,
     DEPARTMENT_NAME
   )
   VALUES
   (
     280,
     NULL
   );

EXCEPTION
   WHEN E_INSERT_EXCEP THEN
       DBMS_OUTPUT.PUT_LINE('INSERT OPERATION FAILED');
       DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/

--------------------------------------------------  Functions for Trapping Exceptions
/*
SQLCODE: Returns the numeric value for the error code
SQLERRM: Returns the message associated with the error number

You cannot use SQLCODE or SQLERRM directly in a SQL statement. 
Instead, you must assign their values to local variables
*/
DECLARE
  error_code      NUMBER;
  error_message   VARCHAR2(255);
BEGIN
...
EXCEPTION
...
  WHEN OTHERS THEN

ROLLBACK;
    error_code := SQLCODE;
    error_message := SQLERRM;
INSERT INTO errors
(
  e_user,
  e_date,
  error_code,
  error_message
)
VALUES
(
  USER,
  SYSDATE,
  error_code,
  error_message
);
END;
/


DECLARE   
    err_num NUMBER;   
    err_msg VARCHAR2(100);
BEGIN   
    ...
EXCEPTION
      ...
    WHEN OTHERS THEN
      err_num := SQLCODE;
      err_msg := SUBSTR(SQLERRM, 1, 100);
INSERT INTO errors
VALUES
(
  err_num,
  err_msg
);
END;
/
--------------------------------------------------P8-20 Trapping User-Defined Exceptions
/*
Declare
    Declarative section: Name the exception.
Raise
    Executable section: Explicitly raise the exception by using the RAISE statement.


Reference
    Exception-handling section: Handle the raised exception.


*/
--------------------------------------------------
DECLARE
   v_deptno             NUMBER       := 500;
   v_name               VARCHAR2(20) := 'Testing';
   E_INVALID_DEPARTMENT EXCEPTION;

BEGIN
   UPDATE DEPARTMENTS
   SET DEPARTMENT_NAME = v_name
   WHERE DEPARTMENT_ID = v_deptno;

   IF SQL % NOTFOUND THEN
      RAISE E_INVALID_DEPARTMENT;
   END IF;

   COMMIT;

EXCEPTION
   WHEN E_INVALID_DEPARTMENT THEN
       DBMS_OUTPUT.PUT_LINE('No such department id.');
END;
/
-------------------------------------------------- 
DECLARE
  . . .
  e_no_rows	exception;
  e_integrity	exception

;
  PRAGMA EXCEPTION_INIT (e_integrity, -2292);
BEGIN -- outer block
    FOR c_record IN emp_cursor 
    LOOP
        BEGIN  -- inner block
            SELECT ...
            UPDATE ...
            IF SQL%NOTFOUND THEN
                RAISE e_no_rows;
            END IF;
        END;
    END LOOP;
EXCEPTION
  WHEN e_integrity THEN ...
  WHEN e_no_rows THEN ...
END;
/

--------------------------------------------------P8-23 RAISE_APPLICATION_ERROR Procedure
/*
Syntax:
raise_application_error (error_number,
		message[, {TRUE | FALSE}]);	

Is used in two different places:
    - Executable section
    - Exception section
*/
BEGIN
...
DELETE FROM EMPLOYEES
WHERE manager_id = v_mgr;

  IF SQL%NOTFOUND THEN
     RAISE_APPLICATION_ERROR(-20202,'This is not a valid manager');
  END IF;
   ...
EXCEPTION
   WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR (-20201,'Manager is not a valid employee.');
END;
/

--------------------------------------------------
--------------------------------------------------
-- Packages Standard
DECLARE
   v_employee_id NUMBER := 1000;

BEGIN

   IF v_employee_id > 999 THEN
      RAISE_APPLICATION_ERROR(-20001, 'مقدار نامعتبر');
   END IF;

END;
/

DECLARE
   v_employee_id NUMBER := 1000;

BEGIN

   IF v_employee_id > 999 THEN
      RAISE_APPLICATION_ERROR(-20002, 'کاربر نامعتبر');
   END IF;

END;
/

DECLARE
   v_employee_id NUMBER := -100;

BEGIN
   SELECT EMPLOYEE_ID
   INTO v_employee_id
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = v_employee_id;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR(-20003, 'کارمند مورد نظر یافت نشد');
END;
/

DECLARE
   v_department_name VARCHAR2(50) := 'IT';

BEGIN
   INSERT INTO DEPARTMENTS
   (
     DEPARTMENT_NAME
   )
   VALUES
   (
     v_department_name
   );

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN
       RAISE_APPLICATION_ERROR(-20004, 'مقدار تکراری');
   WHEN OTHERS THEN
       RAISE_APPLICATION_ERROR(-20000, SQLERRM()); 
END;

/