--============================================================
-- **********  Removing a Row from a Table
--============================================================
/*
DELETE Statement:
    DELETE [FROM] table
    [WHERE condition];

*/
-- create table copy_emp as  select * from employees where 1=0;
-- insert into copy_emp  select * from employees;
-- select * from copy_emp;
------------------------------------------------ Deleting Rows from a Table
-- ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
DELETE FROM Departments
WHERE Department_name = 'Finance';

--Delete All
DELETE FROM Copy_emp;

SELECT *
FROM Copy_emp;

-------------------
SELECT *
FROM Departments
WHERE Department_name = 'Finance';

DELETE FROM Employees
WHERE Employee_id = 114;

DELETE FROM Departments
WHERE Department_id IN (30, 40);

------------------------------------------------ Deleting Rows Based on Another Table
DELETE FROM Employees
WHERE Department_id IN
      (
       SELECT Department_id
       FROM Departments
       WHERE Department_name LIKE '%Public%'
      );

------------------------------------------------ TRUNCATE Statement
/*
TRUNCATE TABLE table_name;

The TRUNCATE statement is a 
data definition language (DDL) statement 
and generates no rollback information
*/
SELECT *
FROM Copy_emp;

--!!! No Rollback !!!
TRUNCATE TABLE Copy_emp;
