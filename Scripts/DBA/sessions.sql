--============================================================
SELECT *
FROM   v$session;
/
--============================================================
SELECT sid,
	   serial#,
	   osuser,
	   machine,
	   program,
	   module
FROM   v$session;
/
--============================================================
SELECT NVL(s.username, '(oracle)') AS username,
	   s.osuser,
	   s.sid,
	   s.serial#,
	   p.spid,
	   s.lockwait,
	   s.status,
	   s.service_name,
	   s.machine,
	   s.program,
	   TO_CHAR(s.logon_Time, 'YYYY/mm/dd - HH24:MI:SS', 'nls_calendar=persian') AS logon_time,
	   s.last_call_et AS last_call_et_secs,
	   s.module,
	   s.action,
	   s.client_info,
	   s.client_identifier
FROM   v$session s,
	   v$process p
WHERE  s.paddr = p.addr
ORDER  BY s.username,
		  s.osuser;
