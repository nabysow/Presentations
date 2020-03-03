/*
Description:
Test if the view has the correct columns

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If view tSQLt.TestClasses has the correct columns]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSEMBLE -----------------------------------------------
    -- Create the tables
    CREATE TABLE #actual
    (
        [ColumnName] sysname NOT NULL,
        [DataType] sysname NOT NULL,
        [MaxLength] SMALLINT NOT NULL,
        [Precision] TINYINT NOT NULL,
        [Scale] TINYINT NOT NULL
    );

    CREATE TABLE #expected
    (
        [ColumnName] sysname NOT NULL,
        [DataType] sysname NOT NULL,
        [MaxLength] SMALLINT NOT NULL,
        [Precision] TINYINT NOT NULL,
        [Scale] TINYINT NOT NULL
    );

    INSERT INTO #expected
    (
        ColumnName,
        DataType,
        MaxLength,
        Precision,
        Scale
    )
    VALUES
	('Name', 'sysname', 256, 0, 0),
	('SchemaId', 'int', 4, 10, 0);

    ----- ACT ----------------------------------------------------

    INSERT INTO #actual
    (
        ColumnName,
        DataType,
        MaxLength,
        Precision,
        Scale
    )
    SELECT c.name AS ColumnName,
       st.name AS DataType,
       c.max_length AS MaxLength,
       c.precision AS [Precision],
       c.scale AS Scale
    FROM sys.columns AS c
        INNER JOIN sys.views AS v
            ON v.object_id = c.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = v.schema_id
        LEFT JOIN sys.types AS st
            ON st.user_type_id = c.user_type_id
    WHERE v.type = 'V'
          AND s.name = 'tSQLt'
          AND v.name = 'TestClasses'
    ORDER BY v.name,
             c.name;

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';

END;
GO
