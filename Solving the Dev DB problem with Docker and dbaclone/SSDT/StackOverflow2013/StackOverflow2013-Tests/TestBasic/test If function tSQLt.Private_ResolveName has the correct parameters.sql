/*
Description:

Test if the function has the correct parameters

Changes:
Date		Who						Notes
----------	---						--------------------------------------------------------------
3/3/2020	sstad				Initial procedure
*/
CREATE PROCEDURE [TestBasic].[test If function tSQLt.Private_ResolveName has the correct parameters]
AS
BEGIN
    SET NOCOUNT ON;

    ----- ASSEMBLE -----------------------------------------------
    -- Create the tables
    CREATE TABLE #actual
    (
        [ParameterName] NVARCHAR(128) NOT NULL,
        [DataType] sysname NOT NULL,
        [MaxLength] SMALLINT NOT NULL,
        [Precision] TINYINT NOT NULL,
        [Scale] TINYINT NOT NULL
    );

    CREATE TABLE #expected
    (
        [ParameterName] NVARCHAR(128) NOT NULL,
        [DataType] sysname NOT NULL,
        [MaxLength] SMALLINT NOT NULL,
        [Precision] TINYINT NOT NULL,
        [Scale] TINYINT NOT NULL
    );

    INSERT INTO #expected
    (
        ParameterName,
        DataType,
        MaxLength,
        Precision,
        Scale
    )
    VALUES
	('@Name', 'nvarchar', -1, 0, 0);

    ----- ACT ----------------------------------------------------

    INSERT INTO #actual
    (
        ParameterName,
        DataType,
        MaxLength,
        Precision,
        Scale
    )
    SELECT pm.name AS ParameterName,
        t.name AS DataType,
        pm.max_length AS MaxLength,
        pm.precision AS [Precision],
		pm.scale AS Scale
    FROM sys.parameters AS pm
        INNER JOIN sys.sql_modules AS sm
            ON sm.object_id = pm.object_id
        INNER JOIN sys.objects AS o
            ON sm.object_id = o.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = o.schema_id
        INNER JOIN sys.types AS t
            ON pm.system_type_id = t.system_type_id
            AND pm.user_type_id = t.user_type_id
    WHERE s.name = 'tSQLt'
          AND o.name = 'Private_ResolveName'
          AND pm.name <> '';

    ----- ASSERT -------------------------------------------------

    -- Assert to have the same values
    EXEC tSQLt.AssertEqualsTable @Expected = '#expected', @Actual = '#actual';


END;
