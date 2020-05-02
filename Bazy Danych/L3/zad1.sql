SELECT users.id, displayname, reputation, COUNT(*)
FROM users JOIN posts ON (users.id = posts.owneruserid)
    JOIN postlinks ON (postlinks.postid = posts.id)
    JOIN posts rel ON (postlinks.relatedpostid = rel.id)
    WHERE linktypeid = 3 
GROUP BY users.id, displayname, reputation
ORDER BY 4 DESC, displayname ASC
LIMIT 20;