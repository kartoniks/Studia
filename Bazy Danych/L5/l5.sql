
-- zadanie 1
ALTER TABLE comments ADD COLUMN lasteditdate timestamp NOT NULL DEFAULT now();
UPDATE comments SET lasteditdate = creationdate;

CREATE TABLE commenthistory(
  id SERIAL PRIMARY KEY, 
  commentid integer, 
  creationdate timestamp,
  text text
);

-- zadanie 2
CREATE OR REPLACE FUNCTION foo() RETURNS TRIGGER AS
$$
DECLARE
  ad_lasteditdate timestamp without time zone := OLD.lasteditdate;
BEGIN
  IF (OLD.id != NEW.id 
      OR OLD.postid != NEW.postid
      OR OLD.lasteditdate != NEW.lasteditdate)
    THEN RAISE EXCEPTION 'Trying to change immutable data';
  END IF;
  IF (OLD.text != NEW.text)
    THEN 
    ad_lasteditdate := now();
    INSERT INTO commenthistory(commentid,creationdate,text) VALUES (OLD.id, OLD.lasteditdate, OLD.text);
  END IF;
  RETURN (OLD.id, NEW.postid, NEW.score, NEW.text, OLD.creationdate, NEW.userid, NEW.userdisplayname, ad_lasteditdate);
END
$$ LANGUAGE plpgsql;

DROP TRIGGER bar ON comments;
CREATE TRIGGER bar BEFORE UPDATE ON comments
FOR EACH ROW EXECUTE PROCEDURE foo();

-- zadanie 3
CREATE OR REPLACE FUNCTION baz() RETURNS TRIGGER AS $$
BEGIN
    RETURN (NEW.id, NEW.postid, NEW.score, NEW.text, NEW.creationdate, NEW.userid, NEW.userdisplayname, NEW.creationdate);
END
$$ LANGUAGE plpgsql;

DROP TRIGGER qux ON comments;
CREATE TRIGGER qux BEFORE INSERT ON comments
FOR EACH ROW EXECUTE PROCEDURE baz();