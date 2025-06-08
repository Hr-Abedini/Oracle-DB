--============================================================ Function-Based Indexes
/*
• A function-based index is based on expressions.
• The index expression is built from table columns,
	constants, SQL functions, and user-defined functions.

*/
-------------------------------------------------- P91
CREATE INDEX upper_dept_name_idx
	ON dept2(UPPER(department_name));

SELECT *
FROM dept2
WHERE UPPER(department_name) = 'SALES';	
	
----------
CREATE INDEX upper_last_name_idx 
	ON emp2 (UPPER(last_name));
	
SELECT *
FROM emp2
WHERE upper(last_name) = 'KING';	

---------- Full Table Scan
SELECT *
FROM employees
WHERE upper(last_name) IS NOT NULL
ORDER BY upper(last_name);

