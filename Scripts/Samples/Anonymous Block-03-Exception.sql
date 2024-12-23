SET SERVEROUT ON;

DECLARE
    v_result NUMBER;
BEGIN
    v_result := 1 / 0;
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line(sqlerrm);
END;