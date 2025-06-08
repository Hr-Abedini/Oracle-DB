--============================================================
-- 04 - Interacting with Oracle Database Server: SQL Statements in PL/SQL Programs
--============================================================
-------------------------------------------------- 
-- SQL CURSOR
--------------------------------------------------
/*
There are two types of cursors: implicit and explicit.

Implicit: Created and managed internally by the Oracle Server to process SQL statements
Explicit: Declared explicitly by the programmer

a private memory area called the "context area" for processing SQL statements
A cursor is a pointer to the context area

SQL Cursor Attributes for Implicit Cursors  
    SQL%ROWCOUNT
    SQL%FOUND:  (1 =< row count) => true  
    SQL%NOTFOUND

lesson titled “Using Explicit Cursors.”
*/

--EMPLOYEEs: ORA-02292: integrity constraint (HR.JHIST_EMP_FK) violated - child record found
/*

drop table temp_emp;
create table temp_emp as (select * from employees);

truncate table   temp_emp;

insert into  temp_emp 
select * from employees;

*/
DECLARE
   v_rows_affected VARCHAR2(50);
   v_empno         EMPLOYEES.EMPLOYEE_ID % TYPE := 176;
BEGIN
      DELETE FROM TEMP_EMP 
      WHERE EMPLOYEE_ID = v_empno;

   --v_rows_deleted := (SQL%ROWCOUNT || ' row deleted.');   
  
   v_rows_affected := 'Count: ' || NVL(SQL%ROWCOUNT, 0);
   v_rows_affected := v_rows_affected || ' - Found:' || CASE
                                                        WHEN SQL%FOUND THEN 'TRUE'
                                                        ELSE 'FALSE'
                                                    END;
   v_rows_affected := v_rows_affected || ' - Not found:' || CASE
                                                           WHEN SQL%NOTFOUND THEN 'TRUE'
                                                           ELSE 'FALSE'
                                                       END;
   --PLS-00382: expression is of wrong type
   --v_rows_affected :=SQL%FOUND;
   

   -- PLS-00306: wrong number or types of arguments in call to 'TO_CHAR'
   --v_rows_affected :=  TO_CHAR( SQL%FOUND);


   

   DBMS_OUTPUT.PUT_LINE(v_rows_affected);

END;