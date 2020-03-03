/*
Description:
Test if the user defined function tSQLt.F_Num exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If user defined function tSQLt.F_Num exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.F_Num';
END;
