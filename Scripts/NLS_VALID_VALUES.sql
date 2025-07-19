SELECT PARAMETER,
	   COUNT(*) total,
	   SUM(DECODE(ISDEPRECATED, 'TRUE', 1, 0)) is_deprecated,
	   SUM(DECODE(ISDEPRECATED, 'FALSE', 1, 0)) is_not_deprecated
FROM V$NLS_VALID_VALUES
GROUP BY PARAMETER;

-------------------------------------------------- LANGUAGE
SELECT *
FROM V$NLS_VALID_VALUES
WHERE PARAMETER = 'LANGUAGE';

-------------------------------------------------- TERRITORY
SELECT *
FROM V$NLS_VALID_VALUES
WHERE PARAMETER = 'TERRITORY';

-------------------------------------------------- CHARACTERSET
SELECT *
FROM V$NLS_VALID_VALUES
WHERE PARAMETER = 'CHARACTERSET';

-------------------------------------------------- SORT
SELECT *
FROM V$NLS_VALID_VALUES
WHERE PARAMETER = 'SORT';



