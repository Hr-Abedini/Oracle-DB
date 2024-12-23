DESCRIBE DICT;
DESCRIBE DICTIONARY;
--============================================================ dictionary
SELECT *
FROM DICT
ORDER BY 1;
--============================================================
SELECT Count(0) "Total",
       Sum(
       CASE
           WHEN TABLE_NAME LIKE 'ALL_%' THEN 1
           ELSE 0
       END
       )        "All",
       Sum(
       CASE
           WHEN TABLE_NAME LIKE 'USER_%' THEN 1
           ELSE 0
       END
       )        "User",
       Sum(
       CASE
           WHEN TABLE_NAME LIKE 'DBA_%' THEN 1
           ELSE 0
       END
       )        "DBA",
       Sum(
       CASE
           WHEN TABLE_NAME LIKE 'v$_%' THEN 1
           ELSE 0
       END
       )        "V$"
FROM DICT;

--============================================================ ALL
SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'ALL_%'
ORDER BY 1;

--============================================================ DBA
SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'DBA_%'
ORDER BY 1;

--============================================================ User
SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'USER_%'
ORDER BY 1;

--============================================================ No ALL, DBA, User
SELECT *
FROM DICT
WHERE TABLE_NAME NOT LIKE 'ALL_%'
      AND TABLE_NAME NOT LIKE 'DBA_%'
      AND TABLE_NAME NOT LIKE 'USER_%'
ORDER BY 1;

--============================================================
SELECT *
FROM DICT D
WHERE D.TABLE_NAME LIKE '%IND%';


