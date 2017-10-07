CREATE TABLE #searchWords
(
    word VARCHAR(100),
    position INT
)
CREATE TABLE #searchResults
(
    url VARCHAR(100),
    title VARCHAR(100),
    longDesc VARCHAR(MAX),
    quality TINYINT,
    score INT
)
