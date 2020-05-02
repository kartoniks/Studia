-- Artur Derechowski pwi
-- zadanie 1
SELECT name AS odznaka, COUNT(*) AS liczba FROM badges
  LEFT JOIN users ON (users.id = badges.userid)
  LEFT JOIN posts ON (posts.owneruserid = users.id)
GROUP BY name
ORDER BY liczba DESC;


-- zadanie 2
CREATE OR REPLACE FUNCTION mentions(input text) RETURNS SETOF text AS $X$
BEGIN
  RETURN QUERY
    SELECT match[1] FROM
        (SELECT regexp_matches(input, '(?:\A|\s)[\w]{3,}','g') as match) A
    GROUP BY match
    HAVING COUNT(match) > 1;
RETURN;
END $X$ LANGUAGE plpgsql;

SELECT DISTINCT mentions(text) FROM comments
ORDER BY 1 ASC;