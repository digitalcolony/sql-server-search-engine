/* CREDIT: http://www.sql-server-helper.com/functions/count-string.aspx */
CREATE FUNCTION [dbo].[udfCountString](
    @InputString    VARCHAR(MAX),
    @SearchString    VARCHAR(100)
)
RETURNS INT
BEGIN
    RETURN (LEN(@InputString) -
            LEN(REPLACE(@InputString, @SearchString, ''))) /
            LEN(@SearchString)
END
