------------------------------------------------ 
------------------------------------------------ Substitution Variable
------------------------------------------------ 
------------------------------------------------ Single-Ampersand
SELECT employee_id, 
       last_name, 
       salary, 
       department_id
FROM employees
WHERE employee_id = &employee_num ;

------------------------------------------------ Character and Date Values
-- Use single quotation marks for date and character values
-- job_title = IT_PROG, PU_MAN, ...
SELECT last_name, 
       department_id, 
       salary * 12
FROM employees
WHERE job_id = '&job_title' ;

------------------------------------------------ Specifying Column Names, Expressions, and Text
-- column_name: Salary
-- condition: salary > 1500
-- order_column: last_name
SELECT employee_id, 
       last_name, 
       job_id,
       -------------
       &column_name
       -------------
FROM employees
WHERE &condition
ORDER BY &order_column ;

------------------------------------------------ Using the Double-Ampersand
-- column_name: department_id 
-- SQL Window -> error: not all variable bound
-- ***** Command Window -> Run
SELECT employee_id, 
       last_name, 
       job_id, 
       -------------       
       &&column_name
       -------------       
FROM employees
ORDER BY &column_name ;

-- Single-Ampersand / same name
-- SQL Window     -> 1 dialog
-- Command Window -> 2 dialog 
SELECT employee_id, 
       last_name, 
       job_id, 
       -------------       
       &column_name
       -------------       
FROM employees
ORDER BY &column_name ;

------------------------------------------------ Using the DEFINE Command
------------------------------------------------ column
--SQL Window     -> 1 dialog
-- Command Window -> 2 dialog 
DEFINE column_name ='department_id'
--
SELECT employee_id, 
       last_name, 
       job_id, 
       -------------       
       &column_name
       -------------       
FROM employees
ORDER BY &&column_name;
--
UNDEFINE column_name

------------------------------------------------ variable
-- Command Window
DEFINE employee_num = 200
--
SELECT employee_id, 
       last_name, 
       salary, 
       department_id
FROM employees
WHERE employee_id = &employee_num ;
--
UNDEFINE employee_num

------------------------------------------------ Using the VERIFY Command
-- Command Window
SET VERIFY ON
--
SELECT employee_id, 
       last_name, 
       salary
FROM employees
WHERE employee_id = &employee_num;
