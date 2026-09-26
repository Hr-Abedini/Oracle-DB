DECLARE
   v_test1 VARCHAR2(10);
   v_test2 NVARCHAR2(10) DEFAULT '';
   v_test3 VARCHAR(10)  := '';

   v_test4 CHAR(10)     := '';
   v_test5 nCHAR(10)    := '';
   v_test6 varCHAR(10)  := ' ';
BEGIN

   IF (v_test1 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test-1 is null - null' || ' - len: ' || Length(v_test2));
   END IF;

   IF (v_test2 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test-2 is null - empty' || ' - len: ' || Length(v_test2));
   END IF;

   IF (v_test3 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test-3 is null - empty' || ' - len: ' || Length(v_test3));
   END IF;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------');

   IF (v_test4 IS NOT NULL) THEN        
      DBMS_OUTPUT.PUT_LINE('test-4 is not null - empty' || ' - len: ' || Length(v_test4));
   END IF;

   IF (v_test5 IS NOT NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test-5 is not null - empty' || ' - len: ' || Length(v_test5));
   END IF;

   IF (v_test6 IS NOT NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test-6 is not null - blank' || ' - len: ' || Length(v_test6));
   END IF;
END;