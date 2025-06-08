--============================================================
-- 08 - Controlling User Access
--============================================================
-------------------------------------------------- System Privileges
select * from SYSTEM_PRIVILEGE_MAP;
-------------------------------------------------- Creating Users
/*
CREATE USER user
IDENTIFIED BY password;
*/
CREATE USER demo
IDENTIFIED BY demo;

GRANT "CONNECT" TO "DEMO" ;
-------------------------------------------------- User System Privileges
/*
GRANT privilege [, privilege...]
TO user [, user| role, PUBLIC...];

• An application developer, for example, may have the
following system privileges:
	- CREATE SESSION
	- CREATE TABLE
	- CREATE SEQUENCE
	- CREATE VIEW
	- CREATE PROCEDURE ...
*/

-- Current system privileges 
select PRIVILEGE  from SESSION_PRIVS;

-------------------------------------------------- Granting System Privileges
GRANT
	CREATE SESSION,
	CREATE TABLE,
	CREATE SEQUENCE,
	CREATE VIEW
TO demo;

-------------------------------------------------- Creating and Granting Privileges to a Role
/*
Roles are typically created for a database application

CREATE USER alice
IDENTIFIED BY alice;
*/
-- Create a role:
CREATE ROLE manager;

-- Grant privileges to a role:
GRANT
	CREATE TABLE,
	CREATE VIEW
TO manager;

-- Grant a role to users
GRANT manager TO alice;

-------------------------------------------------- Changing Your Password
-- SQL*Plus has a PASSWORD command (PASSW)
ALTER USER demo
IDENTIFIED BY demo;
