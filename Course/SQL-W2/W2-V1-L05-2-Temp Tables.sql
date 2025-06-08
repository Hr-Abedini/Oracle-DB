-------------------------------------------------- Temporary Tables
/*
A temporary table is a table that holds data that exists 
only for the duration of a 
transaction or session.

CREATE GLOBAL TEMPORARY TABLE tablename
ON COMMIT [PRESERVE | DELETE] ROWS

COMMIT Delete ROWS-> transaction
COMMIT PRESERVE ROWS-> Session
*/

CREATE GLOBAL TEMPORARY TABLE cart
(
	n NUMBER,
	d DATE
)
ON COMMIT DELETE ROWS;


CREATE GLOBAL TEMPORARY TABLE today_sales
ON COMMIT PRESERVE ROWS 
AS
SELECT * FROM orders
WHERE order_date = SYSDATE;

-------------------------------------------------------
--KILL processid
drop table "HR"."TMP_DEP_INFO1" PURGE;
------------------------------------------------------- PRESERVE (Session)
CREATE GLOBAL TEMPORARY TABLE tmp_dep_info1 
(
  department_id number ,
  count number(5),
  sum_salary number
) 
ON COMMIT PRESERVE ROWS;

-- ORA-00942: table or view does not exist
INSERT INTO tmp_dep_info1
	SELECT e.department_id,
	       COUNT(*)      cnt,
	       SUM(e.salary) sum_salary
	FROM employees e
	GROUP BY e.department_id;
	
select count(*) from tmp_dep_info1 ;	
commit;
select count(*) from tmp_dep_info1 ;

------------------------------------------------------- DELETE (Transaction)
--KILL processid
drop table "HR"."TMP_DEP_INFO1" PURGE;
------------------------------------------------------- 
CREATE GLOBAL TEMPORARY TABLE tmp_dep_info1 
(
  department_id number ,
  count number(5),
  sum_salary number
) 
ON COMMIT DELETE ROWS;

-- ORA-00942: table or view does not exist
INSERT INTO tmp_dep_info1
	SELECT e.department_id,
	       COUNT(*)      cnt,
	       SUM(e.salary) sum_salary
	FROM employees e
	GROUP BY e.department_id;
	
select count(*) from tmp_dep_info1 ;	
commit;
select count(*) from tmp_dep_info1 ;
