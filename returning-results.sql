SELECT TOP 20
    S.url, S.title, S.longDesc, S.quality, SUM(S.score) AS Score
FROM #searchResults S
GROUP BY S.url, S.title, S.longDesc, S.quality
ORDER BY SUM(S.score) DESC, S.Quality DESC
