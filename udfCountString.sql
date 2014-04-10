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
