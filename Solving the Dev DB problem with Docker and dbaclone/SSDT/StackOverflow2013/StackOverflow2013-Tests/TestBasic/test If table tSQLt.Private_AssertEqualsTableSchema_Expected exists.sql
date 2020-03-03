/*
Description:
Test if the table tSQLt.Private_AssertEqualsTableSchema_Expected exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If table tSQLt.Private_AssertEqualsTableSchema_Expected exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.Private_AssertEqualsTableSchema_Expected';
END;
