--============================================================
-- 07 - Manipulating Data by Using Subqueries
--============================================================
-------------------------------------------------- Inserting by Using a Subquery as a Target
/*
drop table loc;

create table loc 
as 
select * from locations
where 1 = 0 ;

truncate table loc;
*/

INSERT INTO
(
    SELECT
           l.LOCATION_ID,
           l.CITY,
           l.COUNTRY_ID
    FROM loc l
    JOIN COUNTRIES c
        ON (l.COUNTRY_ID = c.COUNTRY_ID)
    JOIN REGIONS
        USING (REGION_ID)
    WHERE REGION_NAME = 'Europe'
)
VALUES
  (
    3300,
    'Cardiff',
    'UK'
  );

COMMIT;


SELECT LOCATION_ID,
       CITY,
       COUNTRY_ID
FROM loc;

-------------------------------------------------- Using the WITH CHECK OPTION Keyword on DML Statements
-- ORA-01402: view WITH CHECK OPTION where-clause violation
SELECT COUNTRY_ID
FROM COUNTRIES
NATURAL
JOIN REGIONS
WHERE REGION_NAME = 'Europe';

-- Washington -> US  -> Americas
INSERT INTO
   (
     SELECT
            LOCATION_ID,
            CITY,
            COUNTRY_ID
     FROM loc
     WHERE COUNTRY_ID IN
         (
          SELECT
                 COUNTRY_ID
          FROM COUNTRIES
          NATURAL JOIN REGIONS
          WHERE REGION_NAME = 'Europe'
         )
    WITH CHECK OPTION)
    VALUES
      (
        3600,
        'Washington',
        'US'
      );

-- Berlin -> DE -> Europe
INSERT INTO
   (SELECT location_id,
		   city,
		   country_id
	FROM   loc
	WHERE  country_id IN (SELECT country_id
						  FROM   countries NATURAL
						  JOIN   regions
						  WHERE  region_name = 'Europe'
	WITH CHECK OPTION)
VALUES
   (3500,
	'Berlin',
	'DE');

-- Result
SELECT LOCATION_ID,
       CITY,
       COUNTRY_ID
FROM loc;

-------------------------------------------------- By View
-- drop view european_cities;
--
-- 1. Create a database view
CREATE OR REPLACE VIEW EUROPEAN_CITIES
AS
   SELECT LOCATION_ID,
          CITY,
          COUNTRY_ID
   FROM LOCATIONS
   WHERE COUNTRY_ID IN
         (
          SELECT
                 COUNTRY_ID
          FROM COUNTRIES
          NATURAL
          JOIN REGIONS
          WHERE REGION_NAME = 'Europe'
         )
   WITH CHECK OPTION;
-- 2. Verify the results by inserting data
-- ORA-01402: view WITH CHECK OPTION where-clause violation

INSERT INTO EUROPEAN_CITIES
VALUES
  (
    3400,
    'New York',
    'US'
  );


-------------------------------------------------- Using Correlated UPDATE	
/*
UPDATE table1 alias1
SET column = (SELECT expression
				FROM table2 alias2
				WHERE alias1.column =
				alias2.column);
*/
CREATE TABLE EMPL6
AS
SELECT *
FROM EMPLOYEES;


ALTER TABLE EMPL6
ADD (DEPARTMENT_NAME VARCHAR2 (25));

----------
UPDATE EMPL6 e
SET DEPARTMENT_NAME =
(
 SELECT
        DEPARTMENT_NAME
 FROM DEPARTMENTS d
 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
);

SELECT FIRST_NAME,
       LAST_NAME,
       DEPARTMENT_NAME
FROM EMPL6;

----------

/*UPDATE empl6
SET    salary =
	   (SELECT empl6.salary + rewards.pay_raise
		FROM   rewards
		WHERE  employee_id = empl6.employee_id
			   AND payraise_date = (SELECT MAX(payraise_date)
									FROM   rewards
									WHERE  employee_id = empl6.employee_id))
WHERE  empl6.employee_id IN (SELECT employee_id
							 FROM   rewards);
 */

-------------------------------------------------- Using Correlated DELETE
/*
DELETE FROM table1 alias1
WHERE  column operator (SELECT expression
		FROM   table2 alias2
		WHERE  alias1.column = alias2.column);
*/

DELETE FROM JOB_HISTORY JH
WHERE EMPLOYEE_ID =
      (
       SELECT
              EMPLOYEE_ID
       FROM EMPLOYEES E
       WHERE JH.EMPLOYEE_ID = E.EMPLOYEE_ID
           AND START_DATE =
           (
            SELECT
                   MIN(START_DATE)
            FROM JOB_HISTORY JH
            WHERE JH.EMPLOYEE_ID = E.EMPLOYEE_ID
           )
           AND 5 >
           (
            SELECT
                   COUNT(*)
            FROM JOB_HISTORY JH
            WHERE JH.EMPLOYEE_ID = E.EMPLOYEE_ID
            GROUP BY EMPLOYEE_ID
            HAVING COUNT(*) >= 4
           )
      );

---------- p208
DELETE FROM EMPL6 E
WHERE EMPLOYEE_ID =
      (
       SELECT
              EMPLOYEE_ID
       FROM emp_history
       WHERE EMPLOYEE_ID = E.EMPLOYEE_ID
      );
