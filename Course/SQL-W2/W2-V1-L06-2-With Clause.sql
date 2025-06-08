--============================================================
-- Retrieving Data by Using Subqueries
--============================================================
-------------------------------------------------- WITH Clause
WITH
  cnt_dept
  AS
    (
     SELECT
            DEPARTMENT_ID,
            COUNT(1) num_emp
     FROM EMPLOYEES
     GROUP BY DEPARTMENT_ID
    )

SELECT EMPLOYEE_ID,
       SALARY / num_emp
FROM EMPLOYEES e
JOIN cnt_dept c
     ON (e.DEPARTMENT_ID = c.DEPARTMENT_ID);

-------------------------------------------------- Recursive WITH Clause	
/*
drop table flights;

create table flights (source, Destin,Flight_Time)
as 
select 'San Jose', 'Los Angeles' , 1.3 from dual
union
select 'New York', 'Boston', 1.1 from dual
union
select 'Los Angeles', 'New York' ,5.8 from dual;

select * from flights;

--5.8 = Los Angeles  (5.8)-> New York
--1.1 = New York     (1.1)-> Boston
--1.3 = San Jose     (1.3)-> Los Angeles

--6.9 = Los Angeles  (5.8)-> New York    (1.1)-> Boston 

--7.1 = San Jose     (1.3)-> Los Angeles (5.8)->  New York
--8.2 = San Jose     (1.3)-> Los Angeles (5.8)->  New York (1.1)-> Boston
*/
WITH
  reachable_from (source, destin, Calc_Flight_Path, Total_Flight_Time, "CalcTotalTime","Level")
  AS
    (
     SELECT
            source,
            destin,
            source || '  (' || TO_CHAR(FLIGHT_TIME) || ')' || ' ->  ' || destin,
            FLIGHT_TIME,
            TO_CHAR(FLIGHT_TIME) ,
            1 
     FROM FLIGHTS
       UNION ALL
     SELECT
            incoming.source,
            outgoing.destin,
            incoming.Calc_Flight_Path || '  (' || TO_CHAR(outgoing.FLIGHT_TIME) || ')' || '->  ' || outgoing.destin,
            incoming.Total_Flight_Time + outgoing.FLIGHT_TIME,
            incoming."CalcTotalTime" || ' + ' || TO_CHAR(outgoing.FLIGHT_TIME),
            incoming."Level" + 1
     FROM reachable_from incoming,
          FLIGHTS outgoing
     WHERE incoming.destin = outgoing.source
    )

SELECT *
FROM reachable_from;
