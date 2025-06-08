------------------------------------------------
------------------------------------------------ Working with Dates
------------------------------------------------
-- stores dates format: century, year, month, day, hours, minutes and seconds
-- default date display format: DD-MON-RR
-- Valid Oracle dates are
--		between January 1, 4712 B.C., and December 31, 9999 A.D.
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------ HIRE_DATE  type:  DATE  
SELECT LAST_NAME,
	   HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE < '01-FEB-2008';

------------------------------------------------
/*
RR: [Relative/Rolling] Range 
RR Date Format: 

----------------------------------------------------------------
[C]urrent Year  |  [S]pecified Date  |  RR Format  |  YY Format
----------------------------------------------------------------
  1995             27-OCT-95            1995           1995
  1995             27-OCT-17            2017           1917
  2001             27-OCT-17            2017           2017
  2001             27-OCT-95            1995           2095

-----------------------------------------------------------------
[c]: two digits of the current year
[s]: specified two-digit year
-----------------------------------------------------------------
[c]: between 0  and 49
    [s] between 0  and 49 -> The return date is in the "current century"
    [s] between 50 and 99 -> The return date is in the "century before the current one" -> century - 1   
    
[c]: between 50 and 99
    [s] between 0  and 49 -> The return date is in the "century after the current one" -> century + 1
    [s] between 50 and 99 -> The return date is in the "current century"  

[c] and [s]: (between 0 and 49)  or (between 50 and 99)
             ->  The return date is in the "current century"
       

-----------------------------------------------------------------
			|		[S] 0..49		|		[S] 50..99			|
-----------------------------------------------------------------
[C] 0..49	|	current century		|		century - 1			|
[C] 0..50	|	century + 1			|		current century		|
-----------------------------------------------------------------	     


[a]: 0  and 49
[b]: 50 and 99
---------------------------------------------------------------------------
Current Year | Given Date             | Interpreted (RR) | Interpreted (YY)
---------------------------------------------------------------------------
1994           27-OCT-95   [b = b]          1995               1995  
1994           27-OCT-17   [b > a]          2017               1917
2001           27-OCT-17   [a = a]          2017               2017
2048           27-OCT-52   [a < b]          1952               2052
2051           27-OCT-47   [b > a]          2147               2047

---------------------------------------------------------------------------
This data is stored internally as follows:
CENTURY  YEAR  MONTH   DAY  HOUR  MINUTE  SECOND
 19       03    06     17    17    10      43
---------------------------------------------------------------------------
*/



------------------------------------------------ Using the SYSDATE Function
/* 
SYSDATE returns the current date and time set for the operating system on which the
database resides. Therefore, if you are in a place in Australia and connected to a remote
database in a location in the United States (U.S.), the sysdate function will return the U.S.
date and time. 

In that case, you can use the CURRENT_DATE function that returns the current
date in the session time zone.
*/
------------------------------------------------
--> 2023-09-04 5:44:54 PM	| 04-SEP-23 05.44.54.760000 PM +03:30
SELECT SYSDATE,
	   SYSTIMESTAMP
FROM DUAL;

-- from the user session
-->	+03:30	| 2023-08-27 8:44:08 AM	| 27-AUG-23 08.44.08.577000 AM +03:30
SELECT SESSIONTIMEZONE,
	   CURRENT_DATE,
	   CURRENT_TIMESTAMP
FROM DUAL;

------------------------------------------------ Arithmetic with Dates
-- date (+/-) number 	-> Date				-> Adds/Subtracts a number of days to a date
-- date + number/24 	-> Date 			-> Adds a number of hours to a date
-- date – date      	-> Number of days 	-> Subtracts one date from another
SELECT LAST_NAME,
	   (SYSDATE - HIRE_DATE) / 7 AS WEEKS,
	   (TO_DATE('20-AUG-12') - HIRE_DATE) / 7 AS WEEKS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90;

------------------------------------------------
------------------------------------------------ Date-Manipulation Functions
------------------------------------------------
/*
MONTHS_BETWEEN:    Number of months between two dates
ADD_MONTHS:        Add calendar months to date
NEXT_DAY:          Week day of the date specified
LAST_DAY:          Last day of the month
ROUND:             Round date
TRUNC:             Truncate date
*/
SELECT NEXT_DAY('01-SEP-05', 'FRIDAY'),
	   LAST_DAY('01-FEB-05'),
	   MONTHS_BETWEEN('01-SEP-05', '11-JAN-04'),
	   ADD_MONTHS('31-JAN-04', 1)
FROM DUAL;


SELECT EMPLOYEE_ID,
	   HIRE_DATE,
	   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) TENURE,
	   ADD_MONTHS(HIRE_DATE, 6) REVIEW,
	   NEXT_DAY(HIRE_DATE, 'FRIDAY'),
	   LAST_DAY(HIRE_DATE)
FROM EMPLOYEES
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) < 150;

------------------------------------------------ Using ROUND and TRUNC Functions with Dates
/*
 Year: months 1-6 result in January 1 of the current year. 
       months 7-12 result in January 1 of the next year.

 Month: dates 1-15 result in the first day of the current month.
        Dates 16-31 result in the first day of the next month
*/
SELECT SYSDATE,
	   TRUNC(SYSDATE, 'MONTH'),
	   TRUNC(SYSDATE, 'YEAR'),
	   ROUND(SYSDATE, 'MONTH'),
	   ROUND(SYSDATE, 'YEAR')
FROM DUAL;


SELECT ROUND(TO_DATE('20-Aug-03'), 'MONTH'),  -- 01-AUG-03
	   ROUND(TO_DATE('20-Aug-03'), 'YEAR'),	  -- 01-JAN-04
	   TRUNC(TO_DATE('20-Aug-03'), 'MONTH'),  -- 01-JUL-03
	   TRUNC(TO_DATE('25-Aug-03'), 'YEAR')	  -- 01-JAN-03
FROM DUAL;


SELECT EMPLOYEE_ID,
	   HIRE_DATE,
	   ROUND(HIRE_DATE, 'MONTH'),
	   TRUNC(HIRE_DATE, 'MONTH')
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%04';

------------------------------------------------
------------------------------------------------ ***
-- 24H, 60M, 60S
------------------------------------------------
SELECT E.EMPLOYEE_ID,
	   E.HIRE_DATE,
	   E.HIRE_DATE + 1 / 24 AS "1 Hour",
	   E.HIRE_DATE + 5 / 24 / 60 AS "5 minutes",
	   E.HIRE_DATE + 5 / (24 * 60) AS "5 minutes",
	   E.HIRE_DATE + 1 / 24 / 60 AS "1 min",
	   E.HIRE_DATE + 55 / 24 / 60 / 60 AS "55 sec",
	   E.HIRE_DATE + 55 / (24 * 60 * 60) AS "55 sec"
FROM EMPLOYEES E;


--> twenty twenty-three	| AUGUST   
SELECT TO_CHAR(SYSDATE, 'year'),
	   TO_CHAR(SYSDATE, 'MONTH')
FROM DUAL;

--> TWENTY TWENTY-THREE of 09:08:13
SELECT TO_CHAR(SYSDATE, 'YEAR "of" HH24:mi:ss')
FROM DUAL;

------------------------------------------------***
SELECT e.EMPLOYEE_ID,
	   e.FIRST_NAME,
	   TO_CHAR(e.HIRE_DATE, 'YYYY/MM/DD', 'nls_calendar=persian'),
	   TO_CHAR(e.HIRE_DATE, 'YEAR "of" HH24:mi:ss', 'nls_calendar=persian'),
	   TO_CHAR(e.HIRE_DATE, 'Day', 'nls_calendar=persian')
FROM EMPLOYEES e
WHERE TO_CHAR(e.HIRE_DATE, 'YYYY', 'nls_calendar=persian') BETWEEN 1380 AND 1382;


SELECT *
FROM NLS_SESSION_PARAMETERS
WHERE parameter IN ('NLS_LANGUAGE',
  'NLS_DATE_FORMAT',
  'NLS_CALENDAR',
  'NLS_DATE_FORMAT',
  'NLS_TIME_FORMAT',
  'NLS_TIMESTAMP_FORMAT',
  'NLS_TIME_TZ_FORMAT',
  'NLS_TIMESTAMP_TZ_FORMAT');


SELECT TO_DATE('49-12-31', 'RR-MM-DD'), -- 2049-12-31
	   TO_DATE('50-01-01', 'RR-MM-DD') 	-- 1950-01-01
FROM DUAL;


