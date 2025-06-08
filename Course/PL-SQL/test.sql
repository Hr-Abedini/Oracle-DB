DECLARE
   var_test  PLS_INTEGER;
   ------------------------------------------ Record: Table
   rec_flow  APEX_230200.WWV_FLOWS % ROWTYPE;
   ------------------------------------------
   CURSOR curs_flow (prm_id PLS_INTEGER)
   IS
      SELECT *
      INTO rec_flow
      FROM APEX_230200.WWV_FLOWS F
      WHERE F.ID >= prm_id;
   ------------------------------------------ Record: Cursor
   rec_flow2 curs_flow % ROWTYPE;

BEGIN
   ------------------------------------------
    OPEN curs_flow( prm_id =>100);
    LOOP
        FETCH curs_flow INTO  rec_flow2;
        EXIT WHEN  curs_flow%NOTFOUND;
        dbms_output.put_line(rec_flow2.ID || ': ' ||rec_flow2.OWNER);
    END LOOP;

    close curs_flow;
------------------------------------------
    dbms_output.put_line('------------------------------------------');
------------------------------------------
    FOR rec IN curs_flow(100)
    LOOP
    dbms_output.put_line(rec.ID || ': ' ||rec.OWNER);
    END LOOP;
------------------------------------------
SELECT *
INTO rec_flow
FROM APEX_230200.WWV_FLOWS
--WHERE 1 = 2;
;
    --NULL;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('No data found');

   WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('too many rows');

   WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE(N'unkonwn error');
END;