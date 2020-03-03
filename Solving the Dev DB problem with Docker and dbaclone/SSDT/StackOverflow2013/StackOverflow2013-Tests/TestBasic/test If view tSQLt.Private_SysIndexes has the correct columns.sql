/*
Description:
Test if the view has the correct columns

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If view tSQLt.Private_SysIndexes has the correct columns]
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
	('allow_page_locks', 'bit', 1, 1, 0),
	('allow_row_locks', 'bit', 1, 1, 0),
	('auto_created', 'bit', 1, 1, 0),
	('compression_delay', 'int', 4, 10, 0),
	('data_space_id', 'int', 4, 10, 0),
	('fill_factor', 'tinyint', 1, 3, 0),
	('filter_definition', 'nvarchar', -1, 0, 0),
	('has_filter', 'bit', 1, 1, 0),
	('ignore_dup_key', 'bit', 1, 1, 0),
	('index_id', 'int', 4, 10, 0),
	('is_disabled', 'bit', 1, 1, 0),
	('is_hypothetical', 'bit', 1, 1, 0),
	('is_ignored_in_optimization', 'bit', 1, 1, 0),
	('is_padded', 'bit', 1, 1, 0),
	('is_primary_key', 'bit', 1, 1, 0),
	('is_unique', 'bit', 1, 1, 0),
	('is_unique_constraint', 'bit', 1, 1, 0),
	('name', 'sysname', 256, 0, 0),
	('object_id', 'int', 4, 10, 0),
	('suppress_dup_key_messages', 'bit', 1, 1, 0),
	('type', 'tinyint', 1, 3, 0),
	('type_desc', 'nvarchar', 120, 0, 0);

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
          AND v.name = 'Private_SysIndexes'
    ORDER BY v.name,
             c.name;

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';

END;
GO
