DECLARE ContentCursor CURSOR FAST_FORWARD FOR
SELECT url, title, longDesc, quality, page
FROM Articles 

DECLARE SearchWordCursor CURSOR DYNAMIC FOR
SELECT word, position FROM #searchWords
OPEN SearchWordCursor 

OPEN ContentCursor
FETCH NEXT FROM ContentCursor INTO @url, @title, @longDesc, @quality, @page

WHILE @@FETCH_STATUS = 0
BEGIN
    FETCH FIRST FROM SearchWordCursor INTO @word, @position
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- place more weight on the first search term
        SELECT @score = CASE @position
            WHEN 1 THEN 3
            WHEN 2 THEN 2
            ELSE 1
        END
        -- search the TITLE 
        SET @count = dbo.udfCountString(@title, @word)
        IF @count > 0
        BEGIN
            INSERT INTO #searchResults VALUES (@url, @title, @longDesc, @quality, @score * 10)
        END
        -- search the PAGE
        SET @count = dbo.udfCountString(@page, @word)
        IF @count > 0
        BEGIN
            INSERT INTO #searchResults VALUES (@url, @title, @longDesc, @quality, @score)
        END                    

        FETCH NEXT FROM SearchWordCursor INTO @word, @position
    END
    FETCH NEXT FROM ContentCursor INTO @url, @title, @longDesc, @quality, @page
END

CLOSE ContentCursor
DEALLOCATE ContentCursor

CLOSE SearchWordCursor
DEALLOCATE SearchWordCursor
