/*
Description:
Test if the user defined function tSQLt.Private_GetCleanSchemaName exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If user defined function tSQLt.Private_GetCleanSchemaName exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.Private_GetCleanSchemaName';
END;
