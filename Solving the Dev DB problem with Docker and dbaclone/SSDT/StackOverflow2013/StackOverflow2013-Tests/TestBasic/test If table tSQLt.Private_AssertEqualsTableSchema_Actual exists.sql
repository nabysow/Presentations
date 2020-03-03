/*
Description:
Test if the table tSQLt.Private_AssertEqualsTableSchema_Actual exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If table tSQLt.Private_AssertEqualsTableSchema_Actual exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.Private_AssertEqualsTableSchema_Actual';
END;
