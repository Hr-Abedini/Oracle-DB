------------------------------------------------ Multiple-Row Subqueries
/*

IN         Equal to any member in the list

ANY        Must be preceded by =, !=, >, <, <=, >=. 
           Returns TRUE if at least one element exists 
           in the result set of the subquery 
           for which the relation is TRUE.

ALL        Must be preceded by =, !=, >, <, <=, >=. 
           Returns TRUE if the relation is TRUE for all elements 
           in the result set of the subquery
		   
The NOT operator can be used with IN, ANY, and ALL operators.		   
*/
------------------------------------------------ IN
SELECT Last_name,
       Salary,
       Department_id
FROM Employees
WHERE Salary IN
      (
       SELECT Min(Salary)
       FROM Employees
       GROUP BY Department_id
      );


SELECT Last_name,
       Salary,
       Department_id
FROM Employees
WHERE Salary IN (2500, 4200, 4400, 6000, 7000, 8300, 8600, 17000);

------------------------------------------------ ANY
/*
	• < ANY means less than the maximum.
	• > ANY means more than the minimum.
	• = ANY is equivalent to IN.
*/
SELECT *
FROM Employees E2
WHERE E2.Job_id = 'IT_PROG';

-----------------------------
-- 76 Rows
SELECT Employee_id,
       Last_name,
       Job_id,
       Salary
FROM Employees
WHERE Salary < ANY
      (
       SELECT Salary
       FROM Employees
       WHERE Job_id = 'IT_PROG'
      )
      AND Job_id <> 'IT_PROG'
ORDER BY 1;

 
---------------->*** equal by:
SELECT DISTINCT E1.Employee_id,
                E1.Last_name,
                E1.Job_id,
                E1.Salary
FROM Employees E1
INNER JOIN Employees E2
     ON E2.Job_id = 'IT_PROG'
        AND E1.Salary < E2.Salary

WHERE E1.Job_id <> 'IT_PROG'
ORDER BY 1;

------------------------------------------------ ALL
/*
	• > ALL means more than the maximum  
	• < ALL means less than the minimum
*/
-- 44 Rows
SELECT Employee_id,
       Last_name,
       Job_id,
       Salary
FROM Employees
WHERE Salary < ALL
      (
       SELECT Salary
       FROM Employees
       WHERE Job_id = 'IT_PROG'
      )
      AND Job_id <> 'IT_PROG'
ORDER BY 1;

---------------->*** equal by:
SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   JOB_ID,
	   SALARY
FROM EMPLOYEES
WHERE SALARY < (
	 SELECT min(SALARY)
	 FROM EMPLOYEES
	 WHERE JOB_ID = 'IT_PROG'
   )
   AND JOB_ID <> 'IT_PROG'
ORDER BY 1;

-- or

WITH cte1 AS (
	 SELECT e1.EMPLOYEE_ID,
			e1.LAST_NAME,
			e1.JOB_ID,
			e1.SALARY,
			Rowno,
			CASE
				WHEN e1.SALARY < e2.SALARY THEN 1
				ELSE 0
			END "StatusAll"
	 FROM EMPLOYEES e1,
		  (
			  SELECT ROWNUM AS rowno,
					 e.*
			  FROM EMPLOYEES e
			  WHERE e.JOB_ID = 'IT_PROG'
		  ) e2
	 WHERE e1.JOB_ID <> 'IT_PROG'
   )

SELECT EMPLOYEE_ID,
	   LAST_NAME,
	   JOB_ID,
	   SALARY,
	   SUM("StatusAll")
FROM cte1
GROUP BY EMPLOYEE_ID,
		 LAST_NAME,
		 JOB_ID,
		 SALARY
HAVING SUM("StatusAll") = MAX(Rowno)
ORDER BY 1;



------------------------------------------------ Multiple-Column Subqueries
/*
SELECT column, column, ...
FROM table
WHERE (column, column, ...) IN
					(SELECT column, column, ...
					 FROM table
					 WHERE condition);
*/
-- 12 Rows
SELECT First_name,
       Department_id,
       Salary
FROM Employees
WHERE (Salary, Department_id) IN
      (
       SELECT Min(Salary),
              Department_id
       FROM Employees
       GROUP BY Department_id
      )
ORDER BY Department_id;

---------------->*** equal by:
SELECT e1.FIRST_NAME,
	   e1.DEPARTMENT_ID,
	   e1.SALARY
FROM EMPLOYEES e1
INNER JOIN (
	SELECT MIN(SALARY) AS SALARY,
		   DEPARTMENT_ID
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
) e2
   ON e1.SALARY = e2.SALARY
   AND e1.DEPARTMENT_ID = e2.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- Or
SELECT e1.FIRST_NAME,
	   e1.DEPARTMENT_ID,
	   e1.SALARY
FROM EMPLOYEES e1
cross JOIN (
	SELECT MIN(SALARY) AS salary,
		   DEPARTMENT_ID
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
) e2
where e1.SALARY = e2.SALARY
   AND e1.DEPARTMENT_ID = e2.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;
------------------------------------------------ Null Values in a Subquery
-- rows: 0
SELECT EMP.Last_name
FROM Employees EMP
WHERE EMP.Employee_id NOT IN
      (
       SELECT MGR.Manager_id
       FROM Employees MGR
      );
							   
