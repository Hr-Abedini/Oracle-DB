SET SERVEROUT ON;

DECLARE
    l_message VARCHAR2(255) := 'Hello World!';
BEGIN
    dbms_output.put_line(l_message);
END;