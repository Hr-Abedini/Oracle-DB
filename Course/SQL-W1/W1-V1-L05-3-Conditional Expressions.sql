--============================================================
-- **********  Conditional expressions
--============================================================
/*
IF-THEN-ELSE logic

–---- CASE expression
CASE expr WHEN comparison_expr1 THEN return_expr1
         [ WHEN comparison_expr2 THEN return_expr2
          WHEN comparison_exprn THEN return_exprn
          ELSE else_expr
         ]
END

–---- Searched CASE expression
CASE
    WHEN condition1 THEN use_expression1
    WHEN condition2 THEN use_expression2
    WHEN condition3 THEN use_expression3
    ELSE default_use_expression
END

----– DECODE function
DECODE(col|expression, 
           search1, result1
          [, search2, result2,...,]
          [, default]
      )
*/

------------------------------------------------ Using the CASE Expression
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY,
	   CASE JOB_ID
		   WHEN 'IT_PROG' THEN 1.10 * SALARY
		   WHEN 'ST_CLERK' THEN 1.15 * SALARY
		   WHEN 'SA_REP' THEN 1.20 * SALARY
		   ELSE SALARY
	   END "REVISED_SALARY"
FROM EMPLOYEES;

------------------------------------------------ Searched CASE Expression
SELECT LAST_NAME,
	   SALARY,
	   (CASE
		   WHEN SALARY < 5000 THEN 'Low'
		   WHEN SALARY < 10000 THEN 'Medium'
		   WHEN SALARY < 20000 THEN 'Good'
		   ELSE 'Excellent'
	   END) qualified_salary
FROM EMPLOYEES;

------------------------------------------------ Using the DECODE Function
/*
IF job_id = 'IT_PROG' THEN salary = salary*1.10
IF job_id = 'ST_CLERK' THEN salary = salary*1.15
IF job_id = 'SA_REP' THEN salary = salary*1.20
ELSE salary = salary
*/
SELECT LAST_NAME,
	   JOB_ID,
	   SALARY,
	   DECODE(JOB_ID,
	   'IT_PROG', 1.10 * SALARY,
	   'ST_CLERK', 1.15 * SALARY,
	   'SA_REP', 1.20 * SALARY,
	   SALARY
	   ) revised_salary
FROM EMPLOYEES;

/*
Monthly Salary Range        Tax Rate
$0.00–1,999.99              00%
$2,000.00–3,999.99          09%
$4,000.00–5,999.99          20%
$6,000.00–7,999.99          30%
$8,000.00–9,999.99          40%
$10,000.00–11,999.99        42%
$12,200.00–13,999.99        44%
$14,000.00 or greater       45%
*/
SELECT LAST_NAME,
	   SALARY,
	   DECODE(TRUNC(SALARY / 2000, 0),
			   0, 0.00,
			   1, 0.09,
			   2, 0.20,
			   3, 0.30,
			   4, 0.40,
			   5, 0.42,
			   6, 0.44,
			   0.45
	   ) tax_rate
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

