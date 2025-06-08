------------------------------------------------ Datetime Data Types
/*
Date                      | TIMESTAMP with fractional seconds
INTERVAL YEAR TO MONTH    | Stored as an interval of years and months
INTERVAL DAY TO SECOND    | Stored as an interval of days, hours, minutes,and seconds

INTERVAL YEAR [(year_precision)] TO MONTH
INTERVAL 'year[-month]' leading (precision) TO trailing

INTERVAL DAY [(day_precision)] TO SECOND [(fractional_seconds_precision)]
INTERVAL leading (leading_precision) to trailing(fractional_seconds_precision)

*/
DROP TABLE candidates;
--v23c: drop table if exists candidates;


CREATE TABLE candidates (
    candidate_id       NUMBER,
    first_name         VARCHAR2(50) NOT NULL,
    last_name          VARCHAR2(50) NOT NULL,
    job_title          VARCHAR2(255) NOT NULL,
    year_of_experience INTERVAL YEAR TO MONTH,
    PRIMARY KEY ( candidate_id )
);
------*
INSERT INTO candidates (
    candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
) VALUES (
    1,
    'Camila',
    'Kramer',
    'SCM Manager',
    INTERVAL '10-2' YEAR TO MONTH
);
------*
INSERT INTO candidates (
    candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
) VALUES (
    2,
    'Keila',
    'Doyle',
    'SCM Staff',
    INTERVAL '9' MONTH
);	
------*
SELECT *
FROM candidates;

------------------------------------------------ Appendix: INTERVAL YEAR TO MONTH Literals

SELECT INTERVAL '120-3' YEAR ( 3 ) TO MONTH,
       INTERVAL '120-3' YEAR ( 3 ) TO MONTH,
       INTERVAL '105' YEAR ( 3 ),
       INTERVAL '500' MONTH ( 3 ),
       INTERVAL '9' YEAR,
       INTERVAL '40' MONTH --40/12  -> 3y-4m
       -- Invalid interval because ‘180’ has 3 digits which are greater than the default precision (2)
       --INTERVAL '180' YEAR 
FROM dual;

------------------------------------------------ Appendix: INTERVAL DAY TO SECOND
SELECT INTERVAL '11 10:09:08.555' DAY TO SECOND ( 3 ),
       INTERVAL '11 10:09' DAY TO MINUTE,
       INTERVAL '100 10' DAY ( 3 ) TO HOUR,
       INTERVAL '999' DAY ( 3 ),
       INTERVAL '09:08:07.6666666' HOUR TO SECOND ( 7 ),
       INTERVAL '09:30' HOUR TO MINUTE,
       INTERVAL '8' HOUR,
       INTERVAL '15:30' MINUTE TO SECOND,
       INTERVAL '30' MINUTE,
       INTERVAL '5' DAY,
       INTERVAL '40' HOUR,
       INTERVAL '15' MINUTE,
       INTERVAL '250' HOUR ( 3 )
-- Rounded to 15.679 seconds. Because the precision is 3, the fractional second ‘6789’ is rounded to ‘679’
--INTERVAL '15.6789' SECOND(2,3)
FROM dual;

------------------------------------------------ 
CREATE TABLE candidates (
    candidate_id       NUMBER,
    first_name         VARCHAR2(50) NOT NULL,
    last_name          VARCHAR2(50) NOT NULL,
    job_title          VARCHAR2(255) NOT NULL,
    year_of_experience INTERVAL YEAR TO MONTH,
    --  Month_Min INTERVAL MONTH to MINUTEs,
    day_to_second      INTERVAL DAY TO SECOND,
    PRIMARY KEY ( candidate_id )
);
INSERT INTO candidates (
    candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience,
    day_to_second
) VALUES (
    1,
    'Camila',
    'Kramer',
    'SCM Manager',
    INTERVAL '10-2' YEAR TO MONTH,
    INTERVAL '5 10:20:33.555' DAY TO SECOND
);
--------
SELECT *
FROM candidates;
--------
DROP TABLE candidates;