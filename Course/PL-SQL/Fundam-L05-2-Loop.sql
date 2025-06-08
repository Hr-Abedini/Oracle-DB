--============================================================
--          Writing Control Structures
--============================================================
/*
IF statements, CASE expressions, LOOP structures in a PL/SQL block.
*/
--------------------------------------------------
--Iterative Control: LOOP Statements
-------------------------------------------------- P5-21 Basic Loops

/*
    three loop types:
        1.Basic loop
        2.FOR loop       lesson titled “Using Explicit Cursors.”
        3.WHILE loop

    LOOP                      
       statement1;
           . . .
       EXIT [WHEN condition];
    END LOOP;

*/
-------------------------------------------------- Basic Loop
SELECT COUNT(*)
FROM LOCATIONS;

DECLARE
   v_countryid LOCATIONS.COUNTRY_ID % TYPE := 'CA';
   v_loc_id    LOCATIONS.LOCATION_ID % TYPE;
   v_counter   NUMBER(2)                   := 1;
   v_new_city  LOCATIONS.CITY % TYPE       := 'Montreal';

BEGIN
   SELECT MAX(LOCATION_ID)
   INTO v_loc_id
   FROM LOCATIONS
   WHERE COUNTRY_ID = v_countryid;

   LOOP
      INSERT INTO LOCATIONS
      (
        LOCATION_ID,
        CITY,
        COUNTRY_ID
      )
      VALUES
      (
        (v_loc_id + v_counter),
        v_new_city,
        v_countryid
      );

      v_counter := v_counter + 1;
      EXIT WHEN v_counter > 3;
   END LOOP;

END;
/

ROLLBACK;

--------------------------------------------------P5-23 WHILE Loops
/*
repeat statements while a condition is TRUE.

WHILE condition 
LOOP
  statement1;
  statement2;
  . . .
END LOOP;
*/
SELECT COUNT(*)
FROM LOCATIONS;

DECLARE
   v_countryid LOCATIONS.COUNTRY_ID % TYPE := 'CA';
   v_loc_id    LOCATIONS.LOCATION_ID % TYPE;
   v_new_city  LOCATIONS.CITY % TYPE       := 'Montreal';
   v_counter   NUMBER                      := 1;

BEGIN
   SELECT MAX(LOCATION_ID)
   INTO v_loc_id
   FROM LOCATIONS
   WHERE COUNTRY_ID = v_countryid;

   WHILE v_counter <= 3
   LOOP
      INSERT INTO LOCATIONS
      (
        LOCATION_ID,
        CITY,
        COUNTRY_ID
      )
      VALUES
      (
        (v_loc_id + v_counter),
        v_new_city,
        v_countryid
      );

      v_counter := v_counter + 1;
   END LOOP;

END;
/

ROLLBACK;

-------------------------------------------------- P5-25  FOR Loops
/*
FOR counter IN [REVERSE] lower_bound..upper_bound 
LOOP  
  statement1;
  statement2;
  . . .
END LOOP;
*/

SELECT COUNT(*)
FROM LOCATIONS;


DECLARE
   v_countryid LOCATIONS.COUNTRY_ID % TYPE := 'CA';
   v_loc_id    LOCATIONS.LOCATION_ID % TYPE;
   v_new_city  LOCATIONS.CITY % TYPE       := 'Montreal';

BEGIN
   SELECT MAX(LOCATION_ID)
   INTO v_loc_id
   FROM LOCATIONS
   WHERE COUNTRY_ID = v_countryid;

   FOR I IN 1 .. 3
   LOOP
      INSERT INTO LOCATIONS
      (
        LOCATION_ID,
        CITY,
        COUNTRY_ID
      )
      VALUES
      (
        (v_loc_id + I),
        v_new_city,
        v_countryid
      );

   --PLS-00363: expression 'I' cannot be used as an assignment target
   --i:=i-1;    
   END LOOP;

END;
/

ROLLBACK;
---------------------- REVERSE

BEGIN

   FOR COUNTER IN REVERSE 1 .. 10
   LOOP
      DBMS_OUTPUT.PUT_LINE(COUNTER);
   END LOOP;

END;

----------------------
DECLARE
   v_lower NUMBER := 1;
   --ORA-06502: PL/SQL: numeric or value error
   --v_lower NUMBER := null;
   
   v_upper NUMBER := 100;
   --ORA-06502: PL/SQL: numeric or value error
   --v_upper NUMBER := null;

BEGIN

   FOR I IN v_lower .. v_upper
   LOOP
      v_upper := v_upper - 1;
      v_lower := v_lower + 1;
      DBMS_OUTPUT.PUT_LINE(I);
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('-----------------------');
   DBMS_OUTPUT.PUT_LINE('v_lower:' || v_lower);
   DBMS_OUTPUT.PUT_LINE('v_upper:' || v_upper);
END;

--------------------------------------------------P5-30 Nested Loops and Labels
/*
...
BEGIN
  <<Outer_loop>> 
  LOOP
    v_counter := v_counter+1;
  EXIT WHEN v_counter>10;
    <<Inner_loop>> 
    LOOP
      ...
      EXIT Outer_loop WHEN total_done = 'YES';
      -- Leave both loops
      EXIT WHEN inner_done = 'YES';
      -- Leave inner loop only
      ...
    END LOOP Inner_loop;
    ...
  END LOOP Outer_loop;
END;  
/ 
   
*/

--------------------------------------------------P5-32  PL/SQL CONTINUE Statement
DECLARE
  v_total SIMPLE_INTEGER := 0;

BEGIN

   FOR I IN 1 .. 10
   LOOP
      DBMS_OUTPUT.PUT_LINE('I = ' || I || ' | v_total = ' || v_total);
      v_total := v_total + I;
      DBMS_OUTPUT.PUT_LINE('Total is: ' || v_total);
      CONTINUE WHEN I > 5;
      v_total := v_total + I;
      DBMS_OUTPUT.PUT_LINE('Out of Loop Total is: ' || v_total);
      DBMS_OUTPUT.PUT_LINE('-----------------------------------');
   END LOOP;

END;
/

---------------------- to jump to the next iteration of an outer loop
DECLARE
   v_total NUMBER := 0;

BEGIN
<< Outer_loop >>

   FOR I IN 1 .. 10
   LOOP
      v_total := v_total + 1;
      DBMS_OUTPUT.PUT_LINE('Total is: ' || v_total);

   << Inner_loop >>

      FOR J IN 1 .. 10
      LOOP
         DBMS_OUTPUT.PUT_LINE('I+J: ' || to_char(I + J));
         CONTINUE Outer_loop WHEN I + J > 5;
         v_total := v_total + 1;
      END LOOP Inner_loop;

   END LOOP Outer_loop;

END;

/*
A language can be called a programming language 
only if it provides 
control structures for the implementation of business logic.
*/