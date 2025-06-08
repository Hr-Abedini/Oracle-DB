--============================================================
-- 07 - Producer  (Page 71)
--============================================================
/*
CREATE [OR REPLACE] PROCEDURE procedure_name[(parameter_name [IN | OUT | IN OUT] type [, ...])]
{IS | AS}
BEGIN
    < procedure_body >
END procedure_name;

Type:
    SCHEMA: Standalone
    Package
    Block

*/
---------------------------------------------------------------P73
CREATE OR REPLACE PROCEDURE GREETINGS
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
/
---------------------------------------------------------------P74 - EXECUTE / Drop

EXECUTE GREETINGS;
---------------------------------------------------------------

BEGIN
   GREETINGS;
END;
/

---------------------------------------------------------------
DROP PROCEDURE GREETINGS;

---------------------------------------------------------------p75 - Mode: IN / OUT / IN OUT
DECLARE
   a NUMBER;
   b NUMBER;
   c NUMBER;

   PROCEDURE FINDMIN
   (
     x IN  NUMBER,
     y IN  NUMBER,
     z OUT NUMBER
   )
   IS
   BEGIN

       IF x < y THEN
          z := x;
       ELSE
          z := y;
       END IF;

   END;

BEGIN
   a := 23;
   b := 45;
   FINDMIN(a, b, c);
   DBMS_OUTPUT.PUT_LINE(' Minimum of (23, 45) : ' || c);
END;
/

---------------------------------------------------------------
DECLARE
   a NUMBER;
   PROCEDURE SQUARENUM
   (
     x IN OUT NUMBER
   )
   IS
   BEGIN
       x := x * x;
   END;

BEGIN
   a := 23;
   SQUARENUM(a);
   DBMS_OUTPUT.PUT_LINE(' Square of (23): ' || a);
END;
/

--------------------------------------------------------------- P76 - Send Parameters
/*
1.POSIIONAL NOTATION:       findMin(a, b, c, d);
2.NAMED NOTATION:           findMin(x=>a, y=>b, z=>c, m=>d);
3.POSITIONAL-Name NOTATION: findMin(a, b, c, m=>d);
                            findMin(x=>a, b, c, d); !! Invalid !!
*/
--============================================================
-- 08 - Function  (Page 78)
--============================================================
/*
CREATE [OR REPLACE] FUNCTION function_name [(parameter_name [IN | OUT | IN OUT] type [, ...])]
RETURN return_datatype
{IS | AS}
BEGIN
    < function_body >
END [function_name];
*/
---------------------------------------------------------------P79
CREATE OR REPLACE FUNCTION TOTALCUSTOMERS
  RETURN NUMBER
IS
   total NUMBER(2) := 0;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM customers;
    RETURN total;
END;
/
---------------------------------------------------------------P80 - ANONYMOUS block

DECLARE
   c NUMBER(2);

BEGIN
   c := TOTALCUSTOMERS();
   DBMS_OUTPUT.PUT_LINE('Total no. of Customers: ' || c);
END;
/

---------------------------------------------------------------
DECLARE
   a NUMBER;
   b NUMBER;
   c NUMBER;

   FUNCTION FINDMAX
   (
     x IN NUMBER,
     y IN NUMBER
   )
     RETURN NUMBER
   IS
      z NUMBER;
   BEGIN

       IF x > y THEN
          z := x;
       ELSE
          Z := y;
       END IF;

       RETURN z;
   END;

BEGIN
   a := 23;
   b := 45;
   c := FINDMAX(a, b);
   DBMS_OUTPUT.PUT_LINE(' Maximum of (23,45): ' || c);
END;
/

---------------------------------------------------------------P82 - RECURSIVE
DECLARE
   num       NUMBER;
   factorial NUMBER;

   FUNCTION FACT
   (
     x NUMBER
   )
     RETURN NUMBER
   IS
      f NUMBER;
   BEGIN

       IF x = 0 THEN
          f := 1;
       ELSE
          f := x * FACT(x - 1);
       END IF;

       RETURN f;
   END;

BEGIN
   num := 40;
   factorial := FACT(num);
   DBMS_OUTPUT.PUT_LINE(' Factorial ' || num || ' is ' || factorial);
END;
/

--============================================================
-- 09 - Cursor  (Page 84)
--============================================================
/*
attributes:
    SQL%FOUND
    SQL%NOTFOUND
    SQL%ISOPEN
    SQL%ROWCOUNT
*/
---------------------------------------------------------------P86 - IMPLICIT
DECLARE
   total_rows NUMBER(2);

BEGIN
   UPDATE customers
   SET SALARY = SALARY + 500;

   IF SQL % NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('no customers selected');
   ELSIF SQL % FOUND THEN
      total_rows := SQL % ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE(total_rows || ' customers selected ');
   END IF;

END;
/

---------------------------------------------------------------P91 - EXPLICIT
DECLARE
   c_id   customers.id % TYPE;
   c_name customerS.name % TYPE;
   c_addr customers.ADDRESS % TYPE;
   CURSOR c_customers
   IS
      SELECT id,
             name,
             ADDRESS
      FROM customers;

BEGIN
   OPEN c_customers;
   LOOP
      FETCH c_customers INTO c_id, c_name, c_addr;
      EXIT WHEN c_customers % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_name || ' ' || c_addr);
   END LOOP;
   CLOSE c_customers;
END;
/

---------------------------------------------------------------P92 
DECLARE
   r_product products % ROWTYPE;
   CURSOR c_product(low_price NUMBER,
                    high_price NUMBER)
   IS
      SELECT *
      FROM products
      WHERE list_price BETWEEN low_price AND high_price;

BEGIN
   -- show mass products
   DBMS_OUTPUT.PUT_LINE('Mass products: ');
   OPEN c_product (50, 100);
   LOOP
      FETCH c_product INTO r_product;
      EXIT WHEN c_product % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(r_product.product_name || ': ' || r_product.list_price);
   END LOOP;
   CLOSE c_product;
   -- show luxury products
   DBMS_OUTPUT.PUT_LINE('Luxury products: ');
   OPEN c_product (800, 1000);
   LOOP
      FETCH c_product INTO r_product;
      EXIT WHEN c_product % NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(r_product.product_name || ': ' || r_product.list_price);
   END LOOP;
   CLOSE c_product;
END;
/

--============================================================
-- 10 - Record  (Page 93)
--============================================================
/*
Methods:    
    Table-Based
    Cursor-Based
    User-Defined
*/
--------------------------------------------------------------- Table-Based
DECLARE
   customer_rec customers % ROWTYPE;

BEGIN
   SELECT *
   INTO customer_rec
   FROM customers
   WHERE id = 5;

   DBMS_OUTPUT.PUT_LINE('Customer ID: ' || customer_rec.id);
   DBMS_OUTPUT.PUT_LINE('Customer Name: ' || customer_rec.name);
   DBMS_OUTPUT.PUT_LINE('Customer Address: ' || customer_rec.ADDRESS);
   DBMS_OUTPUT.PUT_LINE('Customer Salary: ' || customer_rec.SALARY);
END;
/

--------------------------------------------------------------- Cursor-Based
DECLARE
   CURSOR customer_cur
   IS
      SELECT id,
             name,
             ADDRESS
      FROM customers;

   customer_rec customer_cur % ROWTYPE;

BEGIN
   OPEN customer_cur;
   LOOP
      FETCH customer_cur INTO customer_rec;
      EXIT WHEN customer_cur % NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(customer_rec.id || ' ' || customer_rec.name);
   END LOOP;
END;
/

--------------------------------------------------------------- User-Defined
/*
TYPE type_name IS RECORD
( 
    field_name1 datatype1 [NOT NULL] [:= DEFAULT EXPRESSION],
    field_name2 datatype2 [NOT NULL] [:= DEFAULT EXPRESSION],
    ...
    field_nameN datatypeN [NOT NULL] [:= DEFAULT EXPRESSION]
);

record-name type_name;

*/
DECLARE
   TYPE books IS RECORD
   (
     TITLE   VARCHAR(50),
     AUTHOR  VARCHAR(50),
     SUBJECT VARCHAR(100),
     BOOK_ID NUMBER
   );

   book1 books;
   book2 books;

BEGIN
   -- Book 1 specification
   book1.TITLE := 'C Programming';
   book1.AUTHOR := 'Nuha Ali ';
   book1.SUBJECT := 'C Programming Tutorial';
   book1.BOOK_ID := 6495407;
   -- Book 2 specification
   book2.TITLE := 'Telecom Billing';
   book2.AUTHOR := 'Zara Ali';
   book2.SUBJECT := 'Telecom Billing Tutorial';
   book2.BOOK_ID := 6495700;
   -- Print book 1 record
   DBMS_OUTPUT.PUT_LINE('Book 1 title : ' || book1.TITLE);
   DBMS_OUTPUT.PUT_LINE('Book 1 author : ' || book1.AUTHOR);
   DBMS_OUTPUT.PUT_LINE('Book 1 subject : ' || book1.SUBJECT);
   DBMS_OUTPUT.PUT_LINE('Book 1 book_id : ' || book1.BOOK_ID);
   -- Print book 2 record
   DBMS_OUTPUT.PUT_LINE('Book 2 title : ' || book2.TITLE);
   DBMS_OUTPUT.PUT_LINE('Book 2 author : ' || book2.AUTHOR);
   DBMS_OUTPUT.PUT_LINE('Book 2 subject : ' || book2.SUBJECT);
   DBMS_OUTPUT.PUT_LINE('Book 2 book_id : ' || book2.BOOK_ID);
END;
/

---------------------------------------------------------------  Parameter
DECLARE
   TYPE books IS RECORD
   (
     TITLE   VARCHAR(50),
     AUTHOR  VARCHAR(50),
     SUBJECT VARCHAR(100),
     BOOK_ID NUMBER
   );

   book1 books;
   book2 books;

   PROCEDURE PRINTBOOK
   (
     book books
   )
   IS
   BEGIN
       DBMS_OUTPUT.PUT_LINE('Book title : ' || book.TITLE);
       DBMS_OUTPUT.PUT_LINE('Book author : ' || book.AUTHOR);
       DBMS_OUTPUT.PUT_LINE('Book subject : ' || book.SUBJECT);
       DBMS_OUTPUT.PUT_LINE('Book book_id : ' || book.BOOK_ID);
   END;

BEGIN
   -- Book 1 specification
   book1.TITLE := 'C Programming';
   book1.AUTHOR := 'Nuha Ali ';
   book1.SUBJECT := 'C Programming Tutorial';
   book1.BOOK_ID := 6495407;
   -- Book 2 specification
   book2.TITLE := 'Telecom Billing';
   book2.AUTHOR := 'Zara Ali';
   book2.SUBJECT := 'Telecom Billing Tutorial';
   book2.BOOK_ID := 6495700;
   -- Use procedure to print book info 
   PRINTBOOK(book1);
   PRINTBOOK(book2);
END;
/

--============================================================
-- 11 - EXCEPTION / EXCEPTION HANDLER  (Page 100)
--============================================================
/*
DECLARE
    <declarations section>
BEGIN
    <executable command(s)>
EXCEPTION
    <exception handling goes here >
    WHEN exception1 THEN
        exception1-handling-statements
    WHEN exception2 THEN
        exception2-handling-statements
    WHEN exception3 THEN
        exception3-handling-statements
    ........
    WHEN others THEN
        exception3-handling-statements
END;


EXCEPTION Categories:
    SYSTEM-DEFINED EXCEPTIONS
    USER-DEFINED EXCEPTONS
*/
---------------------------------------------------------------P101
DECLARE
   c_id   customers.id % TYPE := 8;
   c_name customerS.name % TYPE;
   c_addr customers.ADDRESS % TYPE;

BEGIN
   SELECT name,
          ADDRESS
   INTO c_name,
        c_addr
   FROM customers
   WHERE id = c_id;

   DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
   DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('No such customer!');
   WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

---------------------------------------------------------------USER-DEFINED
-- DBMS_STANDARD.RAISE_APPLICATION_ERROR
DECLARE
   c_id          customers.id % TYPE := &cc_id;
   c_name        customerS.name % TYPE;
   c_addr        customers.ADDRESS % TYPE;
   -- user defined exception
   EX_INVALID_ID EXCEPTION;

BEGIN

   IF c_id <= 0 THEN
      RAISE EX_INVALID_ID;
   ELSE
      SELECT name,
             ADDRESS
      INTO c_name,
           c_addr
      FROM customers
      WHERE id = c_id;
      DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
      DBMS_OUTPUT.PUT_LINE('Address: ' || c_addr);
   END IF;

EXCEPTION
   WHEN EX_INVALID_ID THEN
       DBMS_OUTPUT.PUT_LINE('ID must be greater than zero!');
   WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('No such customer!');
   WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Error!');
END;
/

---------------------------------------------------------------
DECLARE
   name   EMPLOYEES.LAST_NAME % TYPE;
   v_code NUMBER;
   v_errm VARCHAR2(64);

BEGIN
   SELECT LAST_NAME
   INTO name
   FROM EMPLOYEES
   WHERE EMPLOYEE_ID = 1000;

EXCEPTION
   WHEN OTHERS THEN
       v_code := SQLCODE;
       v_errm := SUBSTR(SQLERRM, 1, 64);
       DBMS_OUTPUT.PUT_LINE('The error code is ' || v_code || '- ' || v_errm);
       DBMS_OUTPUT.PUT_LINE('The error code is ' || SQLCODE || '- ' || SQLERRM);
END;
/

--============================================================
-- 12 - TRIGGER  (Page 107)
--============================================================
/*
CREATE [OR REPLACE ] TRIGGER trigger_name
    {BEFORE | AFTER | INSTEAD OF }
    {INSERT [OR] | UPDATE [OR] | DELETE}
    [OF col_name]
ON table_name
    [REFERENCING OLD AS o NEW AS n]
    [FOR EACH ROW]
    WHEN (condition)
DECLARE
    Declaration-statements
BEGIN
    Executable-statements
EXCEPTION
    Exception-handling-statements
END;

Trigger In:
    Table
    View
    Schema
    Database
*/
---------------------------------------------------------------P109 - Table
CREATE OR REPLACE TRIGGER DISPLAY_SALARY_CHANGES
BEFORE DELETE OR INSERT OR UPDATE ON customers
FOR EACH ROW
    WHEN (NEW.ID > 0)
DECLARE
   sal_diff NUMBER;
BEGIN
    sal_diff := :NEW.SALARY - :OLD.SALARY;
    DBMS_OUTPUT.PUT_LINE('Old salary: ' || :OLD.SALARY);
    DBMS_OUTPUT.PUT_LINE('New salary: ' || :NEW.SALARY);
    DBMS_OUTPUT.PUT_LINE('Salary difference: ' || sal_diff);
END;
/
---------------------------------------------------------------P110 - Table

CREATE OR REPLACE TRIGGER ORDERS_BEFORE_INSERT
BEFORE INSERT ON orders
FOR EACH ROW
DECLARE
   v_username VARCHAR2(10);
BEGIN
    -- Find username of person performing INSERT into table
    SELECT USER
    INTO v_username
    FROM DUAL;
    -- Update create_date field to current system date 
    :new.create_date := SYSDATE;
    -- Update created_by field to the username of the person performing the INSERT 
    :new.created_by := v_username;
END;
/
----------------------------------------------------------- DDL Trigger
/*
CREATE [OR REPLACE] TRIGGER trigger name 
{BEFORE | AFTER } { DDL event} ON {DATABASE | SCHEMA} 
[WHEN (...)] 
DECLARE 
    Variable declarations 
BEGIN 
    ...
    some code
    ... 
END;
*/
---------------------------------------------------------------P112 - Schema
-- در سطح SCHEMA اطلاعات هر دستور CREATE را ثبت کنید

CREATE OR REPLACE TRIGGER BCS_TRIGGER
BEFORE CREATE ON SCHEMA
DECLARE
   oper ddl_log.operation % TYPE;
BEGIN
    INSERT INTO ddl_log
       SELECT ORA_SYSEVENT,
              ORA_DICT_OBJ_OWNER,
              ORA_DICT_OBJ_NAME,
              NULL,
              USER,
              SYSDATE
       FROM DUAL;
END BCS_TRIGGER;
/

---------------------------------------------------------------P113 - database_event
/*
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER} {database_event} ON {DATABASE | SCHEMA}
BEGIN
    PL/SQL Code
END;
/
*/
---------------------------------------------------------------
CREATE OR REPLACE TRIGGER ALL_LGON_AUDIT
AFTER LOGON ON DATABASE
BEGIN
    INSERT INTO tbl_evnt_audit
    VALUES
    (
      ORA_SYSEVENT,
      SYSDATE,
      TO_CHAR(SYSDATE, 'hh24:mi:ss'),
      USER,
      NULL
    );
    COMMIT;
END;
/

----------------------------------------------------------- Drop
DROP TRIGGER trigger_name;
----------------------------------------------------------- DISABLE
ALTER TRIGGER ORDERS_BEFORE_INSERT DISABLE;
ALTER TABLE TABLE_NAME DISABLE ALL TRIGGERS;
----------------------------------------------------------- ENABLE
ALTER TRIGGER ORDERS_BEFORE_INSERT ENABLE;
ALTER TABLE TABLE_NAME ENABLE ALL TRIGGERS;


--============================================================
-- 13 - Package  (Page 115)
--============================================================
/*
PACKAGE:
    - SPECIFICATION (SPEC)(INTERFACE)
        PUBLIC Object
            Varibales,
            Constants,
            Cursors,
            Producers,
            Functions ...
    - BODY(DEFINITION)
        PRIVATE Object
*/
---------------------------------------------------------------
CREATE PACKAGE CUST_SAL
AS
   PROCEDURE FIND_SAL
   (
     c_id customers.id % TYPE
   );
END CUST_SAL;
/
--********************

CREATE OR REPLACE PACKAGE BODY CUST_SAL
AS
   PROCEDURE FIND_SAL
   (
     c_id customers.id % TYPE
   )
   IS
      c_sal customers.SALARY % TYPE;
   BEGIN
       SELECT SALARY
       INTO c_sal
       FROM customers
       WHERE id = c_id;
       DBMS_OUTPUT.PUT_LINE('Salary: ' || c_sal);
   END FIND_SAL;
END CUST_SAL;
/
--********************

DECLARE
   code customers.id % TYPE := &cc_id;

BEGIN
   CUST_SAL.FIND_SAL(code);
END;
/

---------------------------------------------------------------
CREATE OR REPLACE PACKAGE C_PACKAGE
AS
   -- Adds a customer
   PROCEDURE ADDCUSTOMER
   (
     c_id   customers.id % TYPE,
     c_name customerS.name % TYPE,
     c_age  customers.age % TYPE,
     c_addr customers.ADDRESS % TYPE,
     c_sal  customers.SALARY % TYPE
   );
   -- Removes a customer
   PROCEDURE DELCUSTOMER
   (
     c_id customers.id % TYPE
   );
   --Lists all customers
   PROCEDURE LISTCUSTOMER;
END C_PACKAGE;
/
--********************

CREATE OR REPLACE PACKAGE BODY C_PACKAGE
AS
   PROCEDURE ADDCUSTOMER
   (
     c_id   customers.id % TYPE,
     c_name customerS.name % TYPE,
     c_age  customers.age % TYPE,
     c_addr customers.ADDRESS % TYPE,
     c_sal  customers.SALARY % TYPE
   )
   IS
   BEGIN
       INSERT INTO customers
       (
         id,
         name,
         age,
         ADDRESS,
         SALARY
       )
       VALUES
       (
         c_id,
         c_name,
         c_age,
         c_addr,
         c_sal
       );
   END ADDCUSTOMER;


   PROCEDURE DELCUSTOMER
   (
     c_id customers.id % TYPE
   )
   IS
   BEGIN
       DELETE FROM customers
       WHERE id = c_id;
   END DELCUSTOMER;


   PROCEDURE LISTCUSTOMER
   IS
      CURSOR c_customers
      IS
         SELECT name
         FROM customers;
      TYPE c_list IS TABLE
         OF customerS.name % TYPE;
      name_list c_list  := c_list();
      counter   INTEGER := 0;
   BEGIN

       FOR N IN c_customers
       LOOP
          counter := counter + 1;
          name_list.extend;
          name_list(counter) := N.name;
          DBMS_OUTPUT.PUT_LINE('Customer(' || counter || ')' || name_list(counter));
       END LOOP;

   END LISTCUSTOMER;
END C_PACKAGE;
/
--********************

DECLARE
   code customers.id % TYPE := 8;

BEGIN
   C_PACKAGE.ADDCUSTOMER(7, 'Rajnish', 25, 'Chennai', 3500);
   C_PACKAGE.ADDCUSTOMER(8, 'Subham', 32, 'Delhi', 7500);
   C_PACKAGE.LISTCUSTOMER;
   C_PACKAGE.DELCUSTOMER(code);
   C_PACKAGE.LISTCUSTOMER;
END;
/

--============================================================
-- 14 - COLLECTION (Page 122)
--============================================================
/*
Types:
    1.Associative array (or index-by table)
    2.Nested table
    3.Variablesize array (Varray)

COLLECTION Methods:
        FIRST
        Next
        LAST
        PRIOR(n)
        NEXT(n)
        -----------
        EXTEND
        EXTEND(n)
        EXTEND(n,i)
        ----------- 
        EXISTS(n)
        COUNT
        LIMIT
        -----------
        TRIM
        TRIM(n)
        DELETE
        DELETE(n)
        DELETE(m,n)

EXCEPTIONs:
    COLLECTION_IS_NULL
    NO_DATA_FOUND
    SUBSCRIPT_BEYOND_COUNT
    SUBSCRIPT_OUTSIDE_LIMIT
    VALUE_ERROR       
*/
--------------------------------------------------------------- Associative array (or index-by table)
/*
TYPE type_name IS TABLE 
    OF element_type [NOT NULL] 
    INDEX BY subscript_type;

table_name type_name;

%ROWTYPE
%TYPE
*/
---------------------------------------------------------------P124
DECLARE
   TYPE salary IS TABLE
      OF NUMBER
      INDEX BY VARCHAR2 (20);

   salary_list salary;
   name        VARCHAR2(20);

BEGIN
   -- adding elements to the table
   salary_list('Rajnish') := 62000;
   salary_list('Minakshi') := 75000;
   salary_list('Martin') := 100000;
   salary_list('James') := 78000;
   -- printing the table
   name := salary_list.first;

   WHILE name IS NOT NULL
   LOOP
      DBMS_OUTPUT.PUT_LINE('Salary of ' || name || ' is ' || TO_CHAR(salary_list(name)));
      name := salary_list.next(name);
   END LOOP;

END;
/

---------------------------------------------------------------
DECLARE
   CURSOR c_customers
   IS
      SELECT name
      FROM customers;

   TYPE c_list IS TABLE
      OF customerS.name % TYPE
      INDEX BY BINARY_INTEGER;

   name_list c_list;
   counter   INTEGER := 0;

BEGIN

   FOR N IN c_customers
   LOOP
      counter := counter + 1;
      name_list(counter) := N.name;
      DBMS_OUTPUT.PUT_LINE('Customer(' || counter || '):' || name_list(counter));
   END LOOP;

END;
/

--------------------------------------------------------------- NESTED TABLE
/*
TYPE type_name IS TABLE 
    OF element_type [NOT NULL];

table_name type_name;

%ROWTYPE
%TYPE
*/
---------------------------------------------------------------P127
DECLARE
   TYPE names_table IS TABLE
      OF VARCHAR2(10);

   TYPE grades IS TABLE
      OF INTEGER;

   names names_table;
   marks grades;
   total INTEGER;

BEGIN
   names := names_table('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
   marks := grades(98, 97, 78, 87, 92);
   total := names.count;

   DBMS_OUTPUT.PUT_LINE('Total ' || total || ' Students');

   FOR I IN 1 .. total
   LOOP
      DBMS_OUTPUT.PUT_LINE('Student:' || names(I) || ', Marks:' || marks(I));
   END LOOP;

END;
/

--============================================================
-- 15 - DBMS Packages (Page 131)
--============================================================
/*
catproc.sql


dbms_xmlgen
dbms_xplan
dbms_sql
dbms_shared_pool
dbms_lob
dbms_scheduler
DBMS_OUTPUT
*/
--------------------------------------------------------------- DBMS_OUTPUT
BEGIN
   DBMS_OUTPUT.PUT_LINE(USER || ' Tables in the database:');

   FOR T IN
   (
    SELECT
           TABLE_NAME
    FROM USER_TABLES
   )
   LOOP
      DBMS_OUTPUT.PUT_LINE(T.TABLE_NAME);
   END LOOP;

END;
/

---------------------------------------------------------------
DECLARE
   lines     DBMS_OUTPUT.CHARARR;
   num_lines NUMBER;

BEGIN
   -- enable the buffer with default size 20000
   DBMS_OUTPUT.ENABLE;
   DBMS_OUTPUT.PUT_LINE('Hello Reader!');
   DBMS_OUTPUT.PUT_LINE('Hope you have enjoyed the tutorials!');
   DBMS_OUTPUT.PUT_LINE('Have a great time exploring pl/sql!');
   num_lines := 3;
   DBMS_OUTPUT.GET_LINES(lines, num_lines);

   FOR I IN 1 .. num_lines
   LOOP
      DBMS_OUTPUT.PUT_LINE(lines(I));
   END LOOP;

END;
/

--============================================================
-- 16 - OOP (Page 122)
--============================================================
/*
Object
    Spec (public interface)
        attribute declarations
        method spec
    Body (private implementation)
        method bodies
*/
---------------------------------------------------------------
CREATE OR REPLACE TYPE COMPLEX
AS
OBJECT
(
    -- attribute
    RPART REAL,
    IPART REAL,
    -- method 
    MEMBER FUNCTION PLUS
    (
      x COMPLEX
    )
      RETURN COMPLEX,

    MEMBER FUNCTION LESS
    (
      x COMPLEX
    )
      RETURN COMPLEX,

    MEMBER FUNCTION TIMES
    (
      x COMPLEX
    )
      RETURN COMPLEX,

    MEMBER FUNCTION DIVBY
    (
      x COMPLEX
    )
      RETURN COMPLEX
);

CREATE TYPE BODY COMPLEX
AS

MEMBER FUNCTION PLUS
(
  x COMPLEX
)
  RETURN COMPLEX
IS
BEGIN
    RETURN COMPLEX(RPART + x.RPART, IPART + x.IPART);
END PLUS;

MEMBER FUNCTION LESS
(
  x COMPLEX
)
  RETURN COMPLEX
IS
BEGIN
    RETURN COMPLEX(RPART - x.RPART, IPART - x.IPART);
END LESS;

MEMBER FUNCTION TIMES
(
  x COMPLEX
)
  RETURN COMPLEX
IS
BEGIN
    RETURN COMPLEX(RPART * x.RPART - IPART * x.IPART, RPART * x.IPART + IPART * x.RPART);
END TIMES;

MEMBER FUNCTION DIVBY
(
  x COMPLEX
)
  RETURN COMPLEX
IS
   z REAL := x.RPART ** 2 + x.IPART ** 2;
BEGIN
    RETURN COMPLEX((RPART * x.RPART + IPART * x.IPART) / z, (IPART * x.RPART - RPART * x.IPART) / z);
END DIVBY;

END;
---------------------------------------------------------------

CREATE OR REPLACE TYPE ADDRESS
AS
OBJECT
(
    HOUSE_NO VARCHAR2(10),
    STREET VARCHAR2(30),
    CITY VARCHAR2(20),
    STATE VARCHAR2(10),
    PINCODE VARCHAR2(10)
);
/

DECLARE
   residence ADDRESS;

BEGIN
   residence := ADDRESS('103A', 'M.G.Road', 'Jaipur', 'Rajasthan', '201301');
   DBMS_OUTPUT.PUT_LINE('House No: ' || residence.HOUSE_NO);
   DBMS_OUTPUT.PUT_LINE('Street: ' || residence.STREET);
   DBMS_OUTPUT.PUT_LINE('City: ' || residence.CITY);
   DBMS_OUTPUT.PUT_LINE('State: ' || residence.STATE);
   DBMS_OUTPUT.PUT_LINE('Pincode: ' || residence.PINCODE);
END;
/

---------------------------------------------------------------
CREATE OR REPLACE TYPE RECTANGLE
AS
OBJECT
(
    LENGTH NUMBER,
    WIDTH NUMBER,
    MEMBER FUNCTION ENLARGE
    (
      inc NUMBER
    )
      RETURN RECTANGLE,
    MEMBER PROCEDURE DISPLAY,
    MAP MEMBER FUNCTION MEASURE
      RETURN NUMBER
);
/
--********************

CREATE OR REPLACE TYPE BODY RECTANGLE
AS

MEMBER FUNCTION ENLARGE
(
  inc NUMBER
)
  RETURN RECTANGLE
IS
BEGIN
    RETURN RECTANGLE(SELF.LENGTH + inc, SELF.WIDTH + inc);
END ENLARGE;

MEMBER PROCEDURE DISPLAY
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE('Length: ' || LENGTH);
    DBMS_OUTPUT.PUT_LINE('Width: ' || WIDTH);
END DISPLAY;

MAP MEMBER FUNCTION MEASURE
  RETURN NUMBER
IS
BEGIN
    RETURN (SQRT(LENGTH * LENGTH + WIDTH * WIDTH));
END MEASURE;

END;
/
--********************

DECLARE
   r1         RECTANGLE;
   r2         RECTANGLE;
   r3         RECTANGLE;
   inc_factor NUMBER := 5;

BEGIN
   r1 := RECTANGLE(3, 4);
   r2 := RECTANGLE(5, 7);
   r3 := r1.ENLARGE(inc_factor);
   r3.DISPLAY;

   IF (r1 > r2) THEN -- calling measure function
      r1.DISPLAY;
   ELSE
      r2.DISPLAY;
   END IF;

END;
/

---------------------------------------------------------------
CREATE OR REPLACE TYPE RECTANGLE
AS
OBJECT
(
    LENGTH NUMBER,
    WIDTH NUMBER,
    MEMBER PROCEDURE DISPLAY,
    ORDER MEMBER FUNCTION MEASURE
    (
      r RECTANGLE
    )
      RETURN NUMBER
);
/
--********************

CREATE OR REPLACE TYPE BODY RECTANGLE
AS

MEMBER PROCEDURE DISPLAY
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Length: ' || LENGTH);
    DBMS_OUTPUT.PUT_LINE('Width: ' || WIDTH);
END DISPLAY;

ORDER MEMBER FUNCTION MEASURE
(
  r RECTANGLE
)
  RETURN NUMBER
IS
BEGIN

    IF (SQRT(SELF.LENGTH * SELF.LENGTH + SELF.WIDTH * SELF.WIDTH) >
       SQRT(r.LENGTH * r.LENGTH + r.WIDTH * r.WIDTH)) THEN
       RETURN (1);
    ELSE
       RETURN (-1);
    END IF;

END MEASURE;

END;
/
--********************

DECLARE
   r1 RECTANGLE;
   r2 RECTANGLE;

BEGIN
   r1 := RECTANGLE(23, 44);
   r2 := RECTANGLE(15, 17);
   r1.DISPLAY;
   r2.DISPLAY;

   IF (r1 > r2) THEN -- calling measure function
      r1.DISPLAY;
   ELSE
      r2.DISPLAY;
   END IF;

END;
/

---------------------------------------------------------------P142 - Inheritance 
CREATE OR REPLACE TYPE RECTANGLE
AS
OBJECT
(
    LENGTH NUMBER,
    WIDTH NUMBER,
    MEMBER FUNCTION ENLARGE
    (
      inc NUMBER
    )
      RETURN RECTANGLE,
    NOT FINAL MEMBER PROCEDURE DISPLAY
) NOT FINAL
/

--********************
CREATE OR REPLACE TYPE BODY RECTANGLE
AS

MEMBER FUNCTION ENLARGE
(
  inc NUMBER
)
  RETURN RECTANGLE
IS
BEGIN
    RETURN RECTANGLE(SELF.LENGTH + inc, SELF.WIDTH + inc);
END ENLARGE;

MEMBER PROCEDURE DISPLAY
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Length: ' || LENGTH);
    DBMS_OUTPUT.PUT_LINE('Width: ' || WIDTH);
END DISPLAY;

END;
/
--********************

CREATE OR REPLACE TYPE TABLETOP UNDER RECTANGLE
(
    MATERIAL VARCHAR2(20),
    OVERRIDING MEMBER PROCEDURE DISPLAY
)
/
--********************
CREATE OR REPLACE TYPE BODY tabletop AS
OVERRIDING MEMBER PROCEDURE display IS
BEGIN
dbms_output.put_line('Length: '|| length);
dbms_output.put_line('Width: '|| width);
dbms_output.put_line('Material: '|| material);
END display;
/

--********************
DECLARE
   t1 TABLETOP;
   t2 TABLETOP;

BEGIN
   t1 := TABLETOP(20, 10, 'Wood');
   t2 := TABLETOP(50, 30, 'Steel');
   t1.DISPLAY;
   t2.DISPLAY;
END;
/
---------------------------------------------------------------
CREATE OR REPLACE TYPE rectangle AS OBJECT
(length number,
width number, 
NOT INSTANTIABLE NOT FINAL MEMBER PROCEDURE display) 
NOT INSTANTIABLE NOT FINAL
/
--********************
