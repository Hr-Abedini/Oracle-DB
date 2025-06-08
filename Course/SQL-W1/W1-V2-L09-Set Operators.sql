--============================================================
-- **********  Using the Set Operators
--============================================================
/*
Use a set operator to combine multiple queries into a single query

    UNION          Rows from both queries after eliminating duplications
    UNION ALL      Rows from both queries, including all duplications
    INTERSECT      Rows that are common to both queries
    MINUS          Rows in the first query that are not present in the second query
    
Set Operator Rules
    • The expressions in the SELECT lists must match in   number.
    • The data type of each column in the subsequent query 
        must match the data type of its corresponding column in the first query.
    • Parentheses can be used to alter the sequence of execution.
    • ORDER BY clause can appear only at the very end of the statement.

Oracle Server and Set Operators
    • Duplicate rows are automatically eliminated except in UNION ALL.
    • Column names from the first query appear in the result.
    • The output is sorted in ascending order by default except in UNION ALL.

*/

-- !!! not exists table: retired_employees !!!
------------------------------------------------ Using the UNION Operator

SELECT Job_id
FROM Employees
  UNION
SELECT Job_id
FROM Job_history;

------------------------------------------------ Using the UNION ALL Operator
SELECT Job_id,
       Department_id
FROM Employees
  UNION ALL
SELECT Job_id,
       Department_id
FROM Job_history
ORDER BY Job_id;

------------------------------------------------ Using the INTERSECT Operator
SELECT Job_id,
       Department_id
FROM Employees
  INTERSECT
SELECT Job_id,
       Department_id
FROM Job_history
ORDER BY Job_id;

------------------------------------------------ Using the MINUS Operator
SELECT Job_id,
       Department_id
FROM Employees
  MINUS
SELECT Job_id,
       Department_id
FROM Job_history
ORDER BY Job_id;

------------------------------------------------ Matching SELECT Statements
SELECT Location_id,
       Department_name "Department",
       To_Char(NULL)   "Warehouse location"
FROM Departments
  UNION
SELECT Location_id,
       To_Char(NULL) "Department",
       State_province
FROM Locations;



SELECT First_name,
       Job_id,
       To_Date(Hire_date) "HIRE_DATE"
FROM Employees
  UNION
SELECT First_name,
       Job_id,
       To_Date(NULL) "HIRE_DATE"
FROM Employees;

------------------------------------------------ Using the ORDER BY Clause in Set Operations
/*
	• The ORDER BY clause can appear only once at the end of the compound query.
	• Component queries cannot have individual ORDER BY clauses.
	• The ORDER BY clause recognizes only the columns of the first SELECT query.
	• By default, the first column of the first SELECT query is used 
		to sort the output in an ascending order.

*/

SELECT Employee_id,
       Job_id,
       Salary
FROM Employees
  UNION
SELECT Employee_id,
       Job_id,
       0
FROM Job_history
ORDER BY 2;
