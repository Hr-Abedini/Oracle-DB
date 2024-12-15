DECLARE
   var_test1 VARCHAR2(10);
   var_test2 VARCHAR2(10) DEFAULT '';
   var_test3 VARCHAR(10)  := '';
   var_test4 CHAR(10)     := '';
   var_test5 varCHAR(10)     := ' ';
BEGIN

   IF (var_test1 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test1 is null' || ' - len: ' || Length(var_test2));
   END IF;

   IF (var_test2 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test2 is null' || ' - len: ' || Length(var_test2));
   END IF;

   IF (var_test3 IS NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test3 is null' || ' - len: ' || Length(var_test3));
   END IF;

   IF (var_test4 IS NOT NULL) THEN        
      DBMS_OUTPUT.PUT_LINE('test4 is not null - CHAR(10)' || ' - len: ' || Length(var_test4));
   END IF;

   IF (var_test5 IS NOT NULL) THEN
      DBMS_OUTPUT.PUT_LINE('test5 is not null - Space' || ' - len: ' || Length(var_test5));
   END IF;
END;