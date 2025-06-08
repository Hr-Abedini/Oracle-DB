DECLARE
   -- tbl LEARN.TYP_TBL_MONTH_INFO;
   TYPE rec IS RECORD
   (
     ID   INT,
     CODE CHAR(2),
     NAME NVARCHAR2(30)
   );

   TYPE tbl IS TABLE
      OF rec;

   var_tbl tbl := tbl();

BEGIN
   --var_tbl.extend();
   SELECT *
   BULK COLLECT
   INTO var_tbl
   FROM
   (
     SELECT
            1,
            '01',
            N'فروردین'
     FROM DUAL
       UNION
     SELECT
            2,
            '02',
            N'اردیبهشت'
     FROM DUAL
       UNION
     SELECT
            3,
            '03',
            N'خرداد'
     FROM DUAL
       UNION
     SELECT
            4,
            '04',
            N'تیر'
     FROM DUAL
       UNION
     SELECT
            5,
            '05',
            N'مرداد'
     FROM DUAL
       UNION
     SELECT
            6,
            '06',
            N'شهریور'
     FROM DUAL
       UNION
     SELECT
            7,
            '07',
            N'مهر'
     FROM DUAL
       UNION
     SELECT
            8,
            '08',
            N'آبان'
     FROM DUAL
       UNION
     SELECT
            9,
            '09',
            N'آذر'
     FROM DUAL
       UNION
     SELECT
            10,
            '10',
            N'دی'
     FROM DUAL
       UNION
     SELECT
            11,
            '11',
            N'بهمن'
     FROM DUAL
       UNION
     SELECT
            12,
            '12',
            N'اسفند'
     FROM DUAL
   );
          
END;