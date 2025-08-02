SELECT view_name,
       'select * from ' || view_name || ' order by 1;' as "SELECT",
	   'desc ' || view_name || ';' as "DESC"
FROM dba_views --all_views
WHERE view_name LIKE '%NLS%'
ORDER BY 1;

--------------------------------------------------------------------
SELECT V.VIEW_NAME,
	   'SELECT ' || LISTAGG (c.column_name, ', ') || '  FROM ' || V.VIEW_NAME "SELECT",
	   'desc ' || view_name || ';' as "DESC"
FROM DBA_VIEWS V
JOIN DBA_tab_columns c
   ON V.VIEW_NAME = c.table_name
WHERE V.VIEW_NAME LIKE '%NLS%'
GROUP BY VIEW_NAME
ORDER BY 1;


--------------------------------------------------------------------
select * from EXU9NLS order by 1;
select * from GV_$NLS_PARAMETERS order by 1;
select * from GV_$NLS_VALID_VALUES order by 1;
select * from NLS_DATABASE_PARAMETERS order by 1;
select * from NLS_INSTANCE_PARAMETERS order by 1;
select * from NLS_SESSION_PARAMETERS order by 1;
select * from V_$NLS_PARAMETERS order by 1;
select * from V_$NLS_VALID_VALUES order by 1;