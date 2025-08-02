SELECT tablespace_name,
	   status,
	   CONTENTS,
	   EXTENT_MANAGEMENT
FROM dba_tablespaces
WHERE tablespace_name LIKE 'APEX%';
-----------------------------------------------------------------
/*
SELECT *
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME LIKE 'APEX%';
*/
SELECT tablespace_name,
	   file_name,
	   ROUND(bytes / 1024 / 1024, 2) AS size_mb,
	   ROUND(bytes / 1024 / 1024 / 1024, 2) AS size_gb
FROM DBA_DATA_FILES
WHERE TABLESPACE_NAME LIKE 'APEX%';


SELECT username,
	   default_tablespace,
	   temporary_tablespace
FROM dba_users
WHERE default_tablespace LIKE 'APEX%'
ORDER BY username;






