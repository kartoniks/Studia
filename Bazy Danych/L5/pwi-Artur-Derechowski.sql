-- Artur Derechowski, pwi
-- Zadanie 1
ALTER TABLE comments ADD COLUMN lasteditdate timestamp NOT NULL DEFAULT now();
UPDATE comments SET lasteditdate = creationdate;

CREATE TABLE commenthistory(
  id SERIAL PRIMARY KEY, 
  commentid integer, 
  creationdate timestamp,
  text text
);

-- Zadanie 2
CREATE OR REPLACE FUNCTION date_function() RETURNS TRIGGER AS $$
DECLARE
  new_date timestamp without time zone := OLD.lasteditdate;
BEGIN
  IF (OLD.id != NEW.id OR OLD.postid != NEW.postid OR OLD.lasteditdate != NEW.lasteditdate)
    THEN RAISE EXCEPTION 'Trying to change immutable data';
  END IF;
  IF (OLD.text != NEW.text)
    THEN 
    new_date := now();
    INSERT INTO commenthistory(commentid,creationdate,text) VALUES (OLD.id, OLD.lasteditdate, OLD.text);
  END IF;
  RETURN (OLD.id, NEW.postid, NEW.score, NEW.text, OLD.creationdate, NEW.userid, NEW.userdisplayname, new_date);
END
$$ LANGUAGE plpgsql;

DROP TRIGGER date_trigger ON comments;
CREATE TRIGGER date_trigger BEFORE UPDATE ON comments
FOR EACH ROW EXECUTE PROCEDURE date_function();

-- Zadanie 3
CREATE OR REPLACE FUNCTION client_function() RETURNS TRIGGER AS $$
BEGIN
    RETURN (NEW.id, NEW.postid, NEW.score, NEW.text, NEW.creationdate, NEW.userid, NEW.userdisplayname, NEW.creationdate);
END
$$ LANGUAGE plpgsql;

DROP TRIGGER client_trigger ON comments;
CREATE TRIGGER client_trigger BEFORE INSERT ON comments
FOR EACH ROW EXECUTE PROCEDURE client_function();