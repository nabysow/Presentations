/*
Description:
Test if the index has the correct columns

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If index PK_Posts_Id has the correct columns]
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
	('Id', 'int', 4, 10, 0);

    ----- ACT ----------------------------------------------------

    INSERT INTO #actual
    (
        ColumnName,
        DataType,
        MaxLength,
        Precision,
        Scale
    )
    SELECT col.name,
       st.name AS DataType,
       col.max_length AS MaxLength,
       col.precision AS [Precision],
       col.scale AS Scale
    FROM sys.indexes AS ind
        INNER JOIN sys.index_columns AS ic
            ON ind.object_id = ic.object_id
            AND ind.index_id = ic.index_id
        INNER JOIN sys.columns AS col
            ON ic.object_id = col.object_id
            AND ic.column_id = col.column_id
        INNER JOIN sys.tables AS t
            ON ind.object_id = t.object_id
        LEFT JOIN sys.types AS st
            ON st.user_type_id = col.user_type_id
    WHERE ind.name = 'PK_Posts_Id';

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';

END;
GO
