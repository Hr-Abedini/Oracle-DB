---------------------------------------------------
GRANT SELECT ON V_$MYSTAT TO hr;
GRANT SELECT ON v_$session TO hr;

---------------------------------------------------
SELECT *
FROM V$mystat;


SELECT *
FROM V$statname;
---------------------------------------------------
SELECT E.Department_id,
       Round(Count(E.Department_id) /
       (
        SELECT Count(*)
        FROM hr.Employees
       ) * 100, 2) TotalPercent
FROM hr.Employees E
GROUP BY E.Department_id
ORDER BY 1;

--------------- Check Plan
-- table access full
SELECT *
FROM Employees E
WHERE E.Department_id = 50;

-- index range scan
SELECT *
FROM Employees E
WHERE E.Department_id = 20;