--============================================================
-- **********  Group Functions
--============================================================
/*
• AVG
• COUNT
• MAX
• MIN
• SUM
• LISTAGG
• STDDEV
• VARIANCE



AVG([DISTINCT|ALL]n)            Average value of n, ignoring null values
COUNT                           Number of rows, where expr evaluates to something other than null 
                               (count all selected rows using *, including duplicates and rows with nulls)

MAX([DISTINCT|ALL]expr)        Maximum value of expr, ignoring null values
MIN([DISTINCT|ALL]expr)        Minimum value of expr, ignoring null values
STDDEV([DISTINCT|ALL]n)        Standard deviation of n, ignoring null values
SUM([DISTINCT|ALL]n)           Sum values of n, ignoring null values

LISTAGG                        Orders data within each group specified in
                               the ORDER BY clause and then concatenates
                               the values of the measure column
                               
VARIANCE([DISTINCT|ALL]n) Variance of n, ignoring null values


syntax:
  SELECT group_function(column), ...
  FROM table
  [WHERE condition];

*/
------------------------------------------------ Using the AVG and SUM Functions
SELECT AVG(salary), 
       MAX(salary),
       MIN(salary), 
       SUM(salary)
FROM employees
WHERE job_id LIKE '%REP%';

------------------------------------------------ Using the MIN and MAX Functions
SELECT MIN(hire_date), 
       MAX(hire_date)
FROM employees;

SELECT MIN(last_name), 
       MAX(last_name)
FROM employees;

------------------------------------------------ Using the COUNT Function
/*
• COUNT(*)
• COUNT(expr)
• COUNT(DISTINCT expr)
*/

SELECT COUNT(*)
FROM employees
WHERE department_id = 50;

--> 0 row
-- returns the number of rows with non-null values for expr:
SELECT COUNT(commission_pct)
FROM employees
WHERE department_id = 50;

SELECT COUNT(-1)
FROM employees
WHERE department_id = 50;

SELECT COUNT(DISTINCT department_id)
FROM employees;

--============================================================ Group Functions and Null Values
SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(NVL(commission_pct, 0))
FROM employees;

------------------------------------------------ Grouping rows / Creating Groups of Data
/*
• Grouping rows:
    – GROUP BY clause
    – HAVING clause
    
SELECT column, group_function(column)
FROM table
[WHERE condition]
[GROUP BY group_by_expression]
[ORDER BY column];
*/

SELECT department_id, 
      AVG(salary)
FROM employees
GROUP BY department_id ;

SELECT AVG(salary)
FROM employees
GROUP BY department_id ;

SELECT department_id, 
       AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary);
------------------------------------------------ Grouping by More Than One Column
SELECT department_id, 
       job_id, 
       sum(salary)
FROM employees
GROUP BY department_id, 
         job_id
ORDER BY job_id;

------------------------------------------------ Using the GROUP BY Clause on Multiple Columns
SELECT department_id, 
       job_id, 
       SUM(salary)
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;

------------------------------------------------ Illegal Queries Using Group Functions
-- ORA-00937: not a single-group group function
SELECT department_id, 
       COUNT(last_name)
FROM employees
--group by department_id
;

-- ORA-00979: not a GROUP BY expression
SELECT department_id, 
       job_id, 
       COUNT(last_name)
FROM employees
GROUP BY department_id
         --,job_id
;

------------------------------------------------ Illegal Queries Using Group Functions
-- ORA-00934: group function is not allowed here
SELECT department_id, 
       AVG(salary)
FROM employees
WHERE AVG(salary) > 8000 -- err
GROUP BY department_id;

------------------------------------------------ Restricting Group Results with the HAVING Clause
/*
SELECT column, group_function
FROM table
[WHERE condition]
[GROUP BY group_by_expression]
[HAVING group_condition]
[ORDER BY column];

*/

SELECT department_id, 
       AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000;


SELECT department_id, 
       MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary)>10000 ;


SELECT job_id, 
      SUM(salary) PAYROLL
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary);

--============================================================ Nesting group functions
SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;

