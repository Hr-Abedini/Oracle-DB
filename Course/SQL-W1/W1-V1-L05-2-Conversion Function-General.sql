--============================================================
-- **********  Conversion Functions: General Functions
--============================================================
/*
• NVL (expr1, expr2)
• NVL2 (expr1, expr2, expr3)
• NULLIF (expr1, expr2)
• COALESCE (expr1, expr2, ..., exprn)

NVL         Converts a null value to an actual value

NVL2        If expr1 is not null, NVL2 returns expr2. 
            If expr1 is null, NVL2 returns expr3. 
            The argument expr1 can have any data type.

NULLIF      Compares two expressions and returns null if they are equal; 
            returns the first expression if they are not equal
            
COALESCE    Returns the first non-null expression in the expression list
*/
------------------------------------------------ Using the NVL Function
SELECT last_name,
	   salary,
	   NVL(commission_pct, 0),
	   (salary * 12) + (salary * 12 * NVL(commission_pct, 0)) AN_SAL
FROM employees;

------------------------------------------------ Using the NVL2 Function
SELECT last_name,
	   salary,
	   commission_pct,
	   NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM employees
WHERE department_id IN (50, 80);

------------------------------------------------ Using the NULLIF Function
SELECT first_name,
	   LENGTH(first_name) "expr1",
	   last_name,
	   LENGTH(last_name) "expr2",
	   NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees;

------------------------------------------------ Using the COALESCE Function
SELECT last_name,
	   salary,
	   commission_pct,
	   COALESCE((salary + (commission_pct * salary)), salary + 2000) "New Salary"
FROM employees;
