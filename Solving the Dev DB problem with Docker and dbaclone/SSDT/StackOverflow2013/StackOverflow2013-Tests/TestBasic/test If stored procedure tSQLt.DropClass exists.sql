/*
Description:
Test if the stored procedure tSQLt.DropClass exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If stored procedure tSQLt.DropClass exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.DropClass';
END;
