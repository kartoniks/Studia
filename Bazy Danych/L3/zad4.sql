CREATE SEQUENCE posts_id;
SELECT setval('posts_id',max(id)) FROM posts;
ALTER TABLE posts ALTER COLUMN id
   SET DEFAULT nextval('posts_id');
ALTER SEQUENCE posts_id OWNED BY posts.id;
-- 11510 
INSERT INTO posts(posttypeid,parentid,owneruserid,body,score,creationdate)
SELECT 3, postid, userid, text, score, creationdate FROM comments;