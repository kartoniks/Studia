SELECT users.id, displayname, reputation, COUNT(comments.id), AVG(comments.score)
FROM users JOIN badges ON (badges.userid = users.id)
    JOIN posts ON (posts.owneruserid = users.id)
    JOIN comments ON (comments.postid = posts.id)
WHERE badges.name = 'Fanatic'
GROUP BY users.id, displayname, reputation
HAVING COUNT(comments.id) <= 100
ORDER BY 4 DESC, displayname ASC
LIMIT 20;