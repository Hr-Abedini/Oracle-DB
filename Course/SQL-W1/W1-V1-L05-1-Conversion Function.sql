-- ANSI: American National Standards Institute
-- SQL/DS
-- DB2
--============================================================
-- **********  Conversion Functions
--============================================================
/*
 Data type conversion: Implicit, Explicit      
*/
------------------------------------------------ Implicit Data Type Conversion
/*
VARCHAR2 or CHAR <-> NUMBER
VARCHAR2 or CHAR <-> DATE

fmt: format
TO_CHAR(number|date [, fmt [,nlsparams] ] )
TO_NUMBER(char[,fmt[,nlsparams]])
TO_DATE(char[,fmt[,nlsparams]])

*/
------------------------------------------------ Using the TO_CHAR Function with Dates
/*
 TO_CHAR(date[,'format_model'])
 
YYYY  -> Full year in numbers
YEAR  -> Year spelled out (in English)
MM    -> Two-digit value for the month
MONTH -> Full name of the month
MON   -> Three-letter abbreviation of the month
DY    -> Three-letter abbreviation of the day of the week
DAY   -> Full name of the day of the week
DD    -> Numeric day of the month

*/

SELECT employee_id, 
       TO_CHAR(hire_date, 'MM/YY') Month_Hired,
       TO_CHAR(hire_date, 'DD-Mon-YYYY') hire_date
FROM employees
WHERE last_name = 'Higgins';

SELECT employee_id, 
       TO_CHAR(hire_date, 'YY') YY,
       TO_CHAR(hire_date, 'YYYY') YYYY,
       TO_CHAR(hire_date, 'YEAR') YEAR,
       TO_CHAR(hire_date, 'MM') MM,
       TO_CHAR(hire_date, 'MONTH') MONTH,
       TO_CHAR(hire_date, 'MON') MON,
       TO_CHAR(hire_date, 'DY') DY,
       TO_CHAR(hire_date, 'DAY') DAY,
       TO_CHAR(hire_date, 'DD') DD
FROM employees
WHERE last_name = 'Higgins';

------------------------------------------------ Elements of the Date Format Model
/*
Time elements: 
AM|PM (Meridian indicator)
HH or HH12 / HH24
MI
SS
SSSSS         -> Seconds past midnight (0–86399)
/ . ,         -> Punctuation is reproduced in the result.
TH            -> Ordinal number (for example, DDTH for 4TH)
SP            -> Spelled-out number (for example, DDSP for FOUR)
SPTH or THSP  ->  Spelled-out ordinal numbers (for example, DDSPTH for FOURTH)

double quotation marks: DD "of" MONTH
Number suffixes: ddspth -> __spth
*/

select TO_CHAR(sysdate, 'HH24:MI:SS AM'), 
       TO_CHAR(sysdate, 'DD "of" MONTH'),
       TO_CHAR(sysdate,'ddspth'),
       -----------------------------------------
       TO_CHAR(sysdate, 'HH:mi:SS:ss'),
       TO_CHAR(sysdate, 'HH:MI:SS pm'),
       TO_CHAR(sysdate, 'HH/mi.SS,ss - HH....MI'),
       
       TO_CHAR(sysdate,'MMspth'),
       TO_CHAR(sysdate,'YYYYspth'),
       TO_CHAR(sysdate,'YYYYspth'),
       
       TO_CHAR(sysdate,'MMthsp'),
       TO_CHAR(sysdate,'MMth'),
       TO_CHAR(sysdate,'MMsp')
from dual;

------------------------------------------------ Using the TO_CHAR Function with Dates
-- fm 
SELECT last_name,
       TO_CHAR(hire_date, 'fmDD Month YYYY') AS HIREDATE,
       TO_CHAR(hire_date, 'DD Month YYYY') 
FROM employees;

SELECT last_name,
       TO_CHAR(hire_date,'fmDdspth "of" Month YYYY fmHH:MI:SS AM') HIREDATE,--12:00:00
       
       TO_CHAR(hire_date,'fmDdspth "of" Month YYYY HH:MI:SS AM') fmDate, --12:0:0
       TO_CHAR(hire_date,'Ddspth "of" Month YYYY fmHH:MI:SS AM') fmTime, --12:0:0
       TO_CHAR(hire_date,'Ddspth "of" Month YYYY HH:MI:SS AM') delFM
FROM employees;

------------------------------------------------ Using the TO_CHAR Function with Numbers
/*
 TO_CHAR(number[, 'format_model'])
 
 Elements:
   9 Represents a number
   0 Forces a zero to be displayed
   $ Places a floating dollar sign
   L Uses the floating local currency symbol
   . Prints a decimal point
   , Prints a comma as a thousands indicator
   
   
Element      Description                                                Example        Result
9            Numeric position (number of 9s determine display width)    999999         1234
0            Display leading zeros                                      099999         001234
$            Floating dollar sign                                       $999999        $1234
L            Floating local currency symbol                             L999999        FF1234
D            Returns the decimal character in the specified position.   9999D99        1234.00
             The default is a period (.).
.            Decimal point in position specified                        999999.99      1234.00
G            Returns the group separator in the specified position.     9G999          1,234
             You can specify multiple group separators 
             in a number format model.
,            Comma in position specified                                999,999        1,234
MI           Minus signs to right (negative values)                     999999MI       1234-
PR           Parenthesize negative numbers                              999999PR       <1234>
EEEE         Scientific notation (format must specify four Es)          99.999EEEE     1.234E+03
U            Returns in the specified position the “Euro”               U9999          €1234
             (or other) dual currency
V            Multiply by 10 n times (n = number of 9s after V)          9999V99        123400
S            Returns the negative or positive value                     S9999          -1234 or +1234
B            Display zero values as blank, not 0 B9999.99 1234.00

 */

SELECT TO_CHAR(salary, '$99,999.00') SALARY
FROM employees
WHERE last_name = 'Ernst';

------------------------------------------------ Using the TO_NUMBER and TO_DATE Functions
/*
TO_NUMBER(char[, 'format_model'])
TO_DATE(char[, 'format_model'])

fx : مطابقت دقیق
The fx modifier specifies the exact match for the character argument and date format model
of a TO_DATE function:
*/
-- 'May[b][b]24,[b]2007' - 'fxMonth[b]DD,[b]YYYY'
-- Error
-->   ORA-01858: a non-numeric character was found where a numeric was expected

SELECT last_name, 
       hire_date
FROM employees
WHERE hire_date = TO_DATE('May  24, 2007', 'fxMonth DD, YYYY');
--> OK
--fm
SELECT last_name, 
       hire_date
FROM employees
WHERE hire_date = TO_DATE('May  24, 2007', 'fmMonth DD, YYYY');
--fx
SELECT last_name, 
        hire_date
FROM employees
WHERE hire_date = TO_DATE('May 24, 2007', 'fxMonth DD, YYYY');

------------------------------------------------ Using TO_CHAR and TO_DATE Functions with the RR Date Format
SELECT last_name, 
       TO_CHAR(hire_date, 'DD-Mon-YYYY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-RR');


SELECT last_name, 
       TO_CHAR(hire_date, 'DD-Mon-YYYY'),
       TO_DATE(hire_date,'DD-Mon-RR'),
       TO_DATE('01-Jan-90','DD-Mon-RR')
FROM employees;

------
SELECT last_name, 
       TO_CHAR(hire_date, 'DD-Mon-yyyy')
FROM employees
WHERE TO_DATE(hire_date, 'DD-Mon-yy') < '01-Jan-90';
 

SELECT last_name, 
       TO_CHAR(hire_date, 'DD-Mon-yyyy'),
       TO_DATE(hire_date, 'DD-Mon-yy'),
       TO_DATE(hire_date,'DD-Mon-RR')
FROM employees;
