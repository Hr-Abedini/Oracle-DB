--==================================================
-- Build a pipelined table function.
-- https://oracle-base.com/articles/misc/pipelined-table-functions
--==================================================
----------------------------------------------------
-- create type
----------------------------------------------------
DROP TYPE t_tf_tab;
DROP TYPE t_tf_row;


CREATE TYPE T_TF_ROW
AS
OBJECT
(
    ID NUMBER,
    DESCRIPTION VARCHAR2(50)
);
/
----------------------------------------------------
-- create table
----------------------------------------------------

CREATE TYPE T_TF_TAB IS TABLE OF T_TF_ROW;
/

----------------------------------------------------
-- create function
----------------------------------------------------
CREATE OR REPLACE FUNCTION GET_TAB_PTF
(
  P_ROWS IN NUMBER
)
  RETURN T_TF_TAB PIPELINED
AS
BEGIN

    FOR I IN 1 .. P_ROWS
    LOOP
       PIPE ROW (T_TF_ROW(I, 'Description for ' || I));
    END LOOP;

    RETURN;
END;
/
----------------------------------------------------
-- Test it.
----------------------------------------------------

SELECT *
FROM TABLE (GET_TAB_PTF(10))
ORDER BY ID DESC;

----------------------------------------------------
-- drop
----------------------------------------------------
DROP TYPE T_TF_TAB;
DROP TYPE T_TF_ROW;
DROP FUNCTION GET_TAB_PTF; 
