/*
Description:
Test if the stored procedure tSQLt.Private_ValidateThatAllDataTypesInTableAreSupported exists

Changes:
Date		Who					Notes
----------	---					--------------------------------------------------------------
3/3/2020	sstad				Initial test
*/
CREATE PROCEDURE [TestBasic].[test If stored procedure tSQLt.Private_ValidateThatAllDataTypesInTableAreSupported exists]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSERT -------------------------------------------------
    EXEC tSQLt.AssertObjectExists @ObjectName = N'tSQLt.Private_ValidateThatAllDataTypesInTableAreSupported';
END;
