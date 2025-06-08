--============================================================
/*
    04 - Interacting with Oracle Database Server: 
         SQL Statements in PL/SQL Programs
*/
--============================================================
-- SET SERVEROUTPUT ON;
-------------------------------------------------- SELECT Statements in PL/SQL
/*
SELECT  select_list
INTO	 {variable_name[, variable_name]...
	 | record_name}  
FROM	 table
[WHERE	 condition];
*/
--> First Name is : Jennifer
DECLARE
   v_fname VARCHAR2(25);
BEGIN
   SELECT FIRST_NAME
   INTO v_fname
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 200;

   DBMS_OUTPUT.PUT_LINE(' First Name is : ' || v_fname);
END;

--P4-7/Note
-- lesson titled “Handling Exceptions.”
-------- NO_DATA_FOUND
DECLARE
   v_fname VARCHAR2(25);
BEGIN
   SELECT FIRST_NAME
   INTO v_fname
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 0;

   DBMS_OUTPUT.PUT_LINE(' First Name is : ' || v_fname);
EXCEPTION WHEN NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('NO DATA FOUND');
END;
-------- TOO_MANY_ROWS 
DECLARE
   v_fname VARCHAR2(25);
BEGIN
   SELECT FIRST_NAME
   INTO v_fname
   FROM EMPLOYEES;
   
   DBMS_OUTPUT.PUT_LINE(' First Name is : ' || v_fname);
EXCEPTION WHEN TOO_MANY_ROWS THEN 
   DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS');
END;

--P4-8: lesson titled “Using Explicit Cursors.”
-------------------------------------------------- Retrieving Data in PL/SQL: Example
/*
Hire date is :17-JUN-03
Salary is :24000
*/
DECLARE
   v_emp_hiredate EMPLOYEES.HIRE_DATE %TYPE;
   v_emp_salary   EMPLOYEES.SALARY %TYPE;
BEGIN
   SELECT HIRE_DATE,
          SALARY
   INTO v_emp_hiredate,
        v_emp_salary
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 100;

   DBMS_OUTPUT.PUT_LINE('Hire date is :' || v_emp_hiredate);
   DBMS_OUTPUT.PUT_LINE('Salary is :' || v_emp_salary);
END;
-------------------------------------------------- Retrieving Data in PL/SQL
/*
    For instance, you cannot use group functions using the following syntax:
            V_sum_sal := SUM(employees.salary);

*/
-- The sum of salary is 28800
DECLARE
   v_sum_sal NUMBER(10, 2);
   v_deptno  NUMBER NOT NULL := 60;
BEGIN
   SELECT SUM(SALARY)-- group function
   INTO v_sum_sal
   FROM EMPLOYEES
   WHERE DEPARTMENT_ID = v_deptno;

   DBMS_OUTPUT.PUT_LINE('The sum of salary is ' || v_sum_sal);
END;
-------------------------------------------------- Naming Ambiguities
/*
precedence:
	1. names of database table columns 
	2. names of local variables and formal parameters 
	3. names of database tables
*/
/*
ORA-01422: exact fetch returns more than requested number of rows
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested
*/
DECLARE
   hire_date      employees.hire_date%TYPE;
   sysdate        hire_date%TYPE;
   employee_id    employees.employee_id%TYPE := 176;        
BEGIN
   SELECT 	hire_date, sysdate
   INTO   	hire_date, sysdate
   FROM   	employees
   WHERE  	employee_id = employee_id;        
END;

-------
/*
Note:   There is no possibility of ambiguity in the SELECT clause 
        because any identifier in the SELECT clause must be a database column name. 

        There is no possibility of ambiguity in the INTO clause 
        because identifiers in the INTO clause must be PL/SQL variables. 

        !!The possibility of confusion is present only in the WHERE clause!!
*/
-- sysdate = null

DECLARE
   hire_date      employees.hire_date%TYPE;
   sysdate        hire_date%TYPE;
   var_employee_id    employees.employee_id%TYPE := 176;        
BEGIN
   SELECT 	hire_date, sysdate
   INTO   	hire_date, sysdate
   FROM   	employees
   WHERE  	employee_id = var_employee_id;      

   DBMS_OUTPUT.PUT_LINE(var_employee_id || ' * ' || hire_date || ' * ' || sysdate);
END;
-------
DECLARE
   var_hire_date      employees.hire_date%TYPE;
   var_sysdate        var_hire_date%TYPE;
   var_employee_id    employees.employee_id%TYPE := 176;        
BEGIN
   SELECT 	hire_date, sysdate
   INTO   	var_hire_date, var_sysdate
   FROM   	employees
   WHERE  	employee_id = var_employee_id;      

   DBMS_OUTPUT.PUT_LINE(var_employee_id || ' * ' || var_hire_date || ' * ' || var_sysdate);
END;
-- *****
--> Remove All Records
/*
ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found
*Cause:    attempted to delete a parent key value that had a foreign
           dependency.
*Action:   delete dependencies first then parent or disable constraint.
*/

declare 
	last_name varchar2 (25) := 'King';
BEGIN
	DELETE FROM employees 
	WHERE last_name = last_name;
END;

