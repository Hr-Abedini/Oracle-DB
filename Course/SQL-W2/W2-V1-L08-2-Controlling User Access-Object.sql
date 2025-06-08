--============================================================
-- 08 - Controlling User Access
--============================================================
-------------------------------------------------- Object Privileges
/*
An object privilege is a privilege or right to perform a particular action on a specific table, view,
sequence, or procedure.

GRANT object_priv [(columns)]
ON object
TO {user|role|PUBLIC}
[WITH GRANT OPTION];
*/
-- user: demo -> ORA-00942: table or view does not exist
select * from hr.employees;
-- user: admin
GRANT SELECT ON hr.employees TO demo;
--revoke SELECT ON hr.employees from demo;
--
--* update specific columns
--* hr.departments
--* departments -> ORA-00942: table or view does not exist
GRANT update (department_name, location_id)
ON hr.departments
TO demo, manager;

--* admin user
grant create synonym to demo;
--* demo user
-- drop synonym emp;
CREATE SYNONYM emp FOR hr.employees;

SELECT * FROM emp;

-------------------------------------------------- Passing On Your Privileges
-- Give a user authority to pass along privileges
GRANT select, insert
ON departments
TO demo
WITH GRANT OPTION;

-- Allow all users on the system to query data from DEPARTMENTS table
GRANT select
ON departments
TO PUBLIC;

-------------------------------------------------- Confirming Granted Privileges
-- System privileges granted to roles
select * from ROLE_SYS_PRIVS;
-- Table privileges granted to roles
select * from ROLE_TAB_PRIVS;
-- Roles accessible by the user
select * from USER_ROLE_PRIVS;
-- System privileges granted to the user
select * from USER_SYS_PRIVS ;
-- Object privileges granted on the user’s objects
select * from USER_TAB_PRIVS_MADE;
-- Object privileges granted to the user
select * from USER_TAB_PRIVS_RECD ;
-- Object privileges granted on the columns of the user’s objects
select * from USER_COL_PRIVS_MADE;
-- Object privileges granted to the user on specific columns
select * from USER_COL_PRIVS_RECD;

/*
Note: The ALL_TAB_PRIVS_MADE dictionary view describes all the object grants made by
the user or made on the objects owned by the user.
*/
select * from ALL_TAB_PRIVS_MADE;

-------------------------------------------------- Revoking Object Privileges
/*
REVOKE {privilege [, privilege...]|ALL}
ON object
FROM {user[, user...]|role|PUBLIC}
[CASCADE CONSTRAINTS];
*/
GRANT SELECT,INSERT ON hr.departments TO demo;

REVOKE SELECT,INSERT ON hr.departments FROM demo;