--SET SERVEROUTPUT off;
SET SERVEROUTPUT On;
DECLARE
    v_fname VARCHAR(20);
BEGIN
    SELECT
        emp.first_name
    INTO v_fname
    FROM
        employees emp
    WHERE
        emp.employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE(' The First Name of the Employee is ' || v_fname);

END;

------------------------------------- 
-- ORA-01403: no data found
DECLARE
    v_fname VARCHAR(20);
BEGIN
    SELECT
        emp.first_name
    INTO v_fname
    FROM
        employees emp
    WHERE
        emp.employee_id = -1;
    
    DBMS_OUTPUT.PUT_LINE(' The First Name of the Employee is ' || v_fname);

END;