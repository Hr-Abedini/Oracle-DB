------------------------------------------------ Create Table
create table tbl_log (
  id           number       not null,
  description  varchar2(50) not null
);

------------------------------------------------ Insert Data
insert into tbl_log (id, description) values (1, 'Description for 1');
insert into tbl_log (id, description) values (2, 'Description for 2');

------------------------------------------------ Retrieve Data
SELECT *
FROM tbl_log;

------------------------------------------------ autonomous_transaction
declare
  pragma autonomous_transaction;
begin
  for i in 3 .. 10 loop
    insert into tbl_log (id, description)
    values (i * 10, 'Description for ' || i);
  end loop;
  --***********
  commit;
  --***********
end;
/
------------------------------------------------ Retrieve Data
SELECT *
FROM tbl_log;

------------------------------------------------
rollback;

------------------------------------------------ Retrieve Data
SELECT *
FROM tbl_log;

------------------------------------------------ Drop Table
DROP TABLE tbl_log CASCADE CONSTRAINTS;