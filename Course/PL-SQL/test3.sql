CREATE OR REPLACE FUNCTION LEARN.PERSIAN_MONTH_INFO2
  RETURN LEARN.TYP_TBL_MONTH_INFO
AS
   var_tbl2 TYP_TBL_MONTH_INFO := TYP_TBL_MONTH_INFO();  
BEGIN

    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(1, '01', N'فروردین');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(2, '02', N'اردیبهشت');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(3, '03', N'خرداد');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(4, '04', N'تیر');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(5, '05', N'مرداد');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(6, '06', N'شهریور');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(7, '07', N'مهر');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(8, '08', N'آبان');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(9, '09', N'آذر');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(10, '10', N'دی');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(11, '11', N'بهمن');
    -------------------------------------------
    var_tbl2.extend();
    var_tbl2(var_tbl2.last) := TYP_OBJ_PERSIAN_MONTH_INFO(12, '12', N'اسفند');


    RETURN var_tbl2;
END;