--======================================================================
-- STANDARD Package, ...
SELECT *
FROM DBA_SOURCE;

SELECT *
FROM USER_SOURCE;

--======================================================================
SELECT *
FROM USER_SOURCE Us
ORDER BY Us.name,
         Us.TYPE,
         Us.LINE
;
/
--====================

BEGIN

   FOR REC IN
   (
    SELECT
           *
    FROM USER_SOURCE Us
    ORDER BY Us.name,
             Us.TYPE,
             Us.LINE
   )
   LOOP
      DBMS_OUTPUT.PUT_LINE(REC.TEXT);
   END LOOP;

END;
/
--======================================================================      