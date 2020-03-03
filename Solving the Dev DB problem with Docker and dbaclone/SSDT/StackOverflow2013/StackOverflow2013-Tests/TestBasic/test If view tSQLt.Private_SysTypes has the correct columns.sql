/*
Description:
Test if the view has the correct columns

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If view tSQLt.Private_SysTypes has the correct columns]
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
	('collation_name', 'sysname', 256, 0, 0),
	('default_object_id', 'int', 4, 10, 0),
	('is_assembly_type', 'bit', 1, 1, 0),
	('is_nullable', 'bit', 1, 1, 0),
	('is_table_type', 'bit', 1, 1, 0),
	('is_user_defined', 'bit', 1, 1, 0),
	('max_length', 'smallint', 2, 5, 0),
	('name', 'sysname', 256, 0, 0),
	('precision', 'tinyint', 1, 3, 0),
	('principal_id', 'int', 4, 10, 0),
	('rule_object_id', 'int', 4, 10, 0),
	('scale', 'tinyint', 1, 3, 0),
	('schema_id', 'int', 4, 10, 0),
	('system_type_id', 'tinyint', 1, 3, 0),
	('user_type_id', 'int', 4, 10, 0);

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
          AND v.name = 'Private_SysTypes'
    ORDER BY v.name,
             c.name;

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';

END;
GO
