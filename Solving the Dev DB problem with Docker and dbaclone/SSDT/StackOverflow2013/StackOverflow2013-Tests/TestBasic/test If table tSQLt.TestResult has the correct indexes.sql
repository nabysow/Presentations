/*
Description:
Test if the table has the correct indexes

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If table tSQLt.TestResult has the correct indexes]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSEMBLE -----------------------------------------------
    -- Create the tables
    CREATE TABLE #actual
    (
        [IndexName] sysname NOT NULL
    );

    CREATE TABLE #expected
    (
        [IndexName] sysname NOT NULL
    );

    INSERT INTO #expected
    (
        IndexName
    )
    VALUES
	('PK__TestResu__3214EC071058DDF5');

    ----- ACT ----------------------------------------------------

    INSERT INTO #actual
    (
        IndexName
    )
    SELECT ind.name
    FROM sys.indexes ind
        INNER JOIN sys.tables t
            ON ind.object_id = t.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = t.schema_id
    WHERE s.name = 'tSQLt'
        AND t.name = 'TestResult'
        AND ind.Name IS NOT NULL;

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';

END;
GO
