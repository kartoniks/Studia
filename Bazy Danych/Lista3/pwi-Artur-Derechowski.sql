-- Artur Derechowski, pwi
-- Zadanie 1
CREATE VIEW ranking(displayname, liczba_odpowiedzi)
AS 
SELECT displayname, COUNT(A.id)
  FROM posts B 
  JOIN posts A ON (B.acceptedanswerid = A.id)
  JOIN users ON (A.owneruserid = users.id)
GROUP BY displayname, users.id
ORDER BY 2 DESC, displayname ASC;

-- Zadanie 2
CREATE TEMP TABLE enlightened_users( users_id int, upvotes int); 
INSERT INTO enlightened_users
SELECT DISTINCT users.id, upvotes
FROM users
JOIN badges ON (users.id = badges.userid)
WHERE badges.name = 'Enlightened';

CREATE TEMP TABLE comm_num( users_id int, num int); 
INSERT INTO comm_num
SELECT users.id, COUNT(DISTINCT comments.id)
FROM users
  JOIN comments ON (users.id = comments.userid) 
  JOIN posts ON (posts.id = comments.postid)
WHERE EXTRACT (year FROM posts.creationdate) = 2020
GROUP BY users.id;

SELECT users.id, displayname, reputation
FROM users 
  JOIN comm_num ON (users.id = comm_num.users_id)
WHERE users.id NOT IN (SELECT users_id FROM enlightened_users)
  AND users.upvotes > (SELECT AVG(upvotes) FROM enlightened_users)
  AND comm_num.num > 1
ORDER BY users.creationdate;

-- Zadanie 3
WITH RECURSIVE rec_users(id, displayname) AS (
SELECT u1.id, u1.displayname 
FROM users u1
  JOIN posts ON (u1.id = posts.owneruserid)
WHERE posts.body LIKE '%recurrence%'
UNION
SELECT u2.id, u2.displayname
FROM users u2
  JOIN comments ON (u2.id = comments.userid)
  JOIN posts ON (posts.id = comments.postid)
  JOIN rec_users ON (posts.owneruserid = rec_users.id)
)
SELECT * FROM rec_users;