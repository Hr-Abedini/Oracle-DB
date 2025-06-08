--============================================================
/*
    04 - Interacting with Oracle Database Server: 
         SQL Statements in PL/SQL Programs
*/
--============================================================
--P4-14 Using PL/SQL to Manipulate Data
-------------------------------------------------- Inserting Data: Example
BEGIN
   INSERT INTO EMPLOYEES
     (
       EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       EMAIL,
       HIRE_DATE,
       JOB_ID,
       SALARY
     )
   VALUES
     (
       EMPLOYEES_SEQ.NEXTVAL,
       'Ruth',
       'Cores',
       'RCORES',
       CURRENT_DATE,
       'AD_ASST',
       4000
     );
END;

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Ruth';

--COMMIT;
--ROLLBACK;

-------------------------------------------------- Updating Data: Example
DECLARE					
  sal_increase   employees.salary%TYPE := 800;   
BEGIN
  UPDATE	employees
  SET		salary = salary + sal_increase
  WHERE	job_id = 'ST_CLERK';
END;

select * from employees
WHERE	job_id = 'ST_CLERK';

--COMMIT;
--ROLLBACK; 
-------------------------------------------------- Deleting Data: Example
DECLARE
  deptno   employees.department_id%TYPE := 10; 
BEGIN							
  DELETE FROM   employees
  WHERE  department_id = deptno;
END;

select * from employees
WHERE  department_id = 10;

--ROLLBACK; 
-------------------------------------------------- Merging Rows
-- SELECT * FROM HR.COPY_EMP;
-- drop table  HR.COPY_EMP;
-- create table COPY_EMP as select * from employees where 1=0;
/*
MERGE INTO target_table 
USING source_table 
ON search_condition
    WHEN MATCHED THEN
        UPDATE SET col1 = value1, col2 = value2,...
        WHERE <update_condition>
        [DELETE WHERE <delete_condition>]
    WHEN NOT MATCHED THEN
        INSERT (col1,col2,...)
        values(value1,value2,...)
        WHERE <insert_condition>;

*/

BEGIN
   MERGE INTO COPY_EMP c
      USING EMPLOYEES e
      ON (e.EMPLOYEE_ID = c.EMPLOYEE_ID)
   WHEN MATCHED THEN
      UPDATE
      SET c.FIRST_NAME     = e.FIRST_NAME,
          c.LAST_NAME      = e.LAST_NAME,
          c.EMAIL          = e.EMAIL,
          c.PHONE_NUMBER   = e.PHONE_NUMBER,
          c.HIRE_DATE      = e.HIRE_DATE,
          c.JOB_ID         = e.JOB_ID,
          c.SALARY         = e.SALARY,
          c.COMMISSION_PCT = e.COMMISSION_PCT,
          c.MANAGER_ID     = e.MANAGER_ID,
          c.DEPARTMENT_ID  = e.DEPARTMENT_ID
      
      --DELETE WHERE c.MANAGER_ID = 103
   /*
   use smycolon (;)
   PLS-00103: Encountered the symbol "VALUES" when expecting one of the following:                          
   */
   WHEN NOT MATCHED THEN
      INSERT
      VALUES
        (
          e.EMPLOYEE_ID,
          e.FIRST_NAME,
          e.LAST_NAME,
          e.EMAIL,
          e.PHONE_NUMBER,
          e.HIRE_DATE,
          e.JOB_ID,
          e.SALARY,
          e.COMMISSION_PCT,
          e.MANAGER_ID,
          e.DEPARTMENT_ID
        )        
        ; -- end ***
END;

SELECT *
FROM copy_emp;

truncate TABLE  copy_emp;