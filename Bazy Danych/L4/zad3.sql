-- CREATE TABLE firma
-- (kod_firmy SERIAL PRIMARY KEY,
-- nazwa text NOT NULL,
-- adres text NOT NULL,
-- kontakt text NOT NULL);

-- INSERT INTO firma(nazwa,adres,kontakt) VALUES
-- ('SNS','Wrocław','H.Kloss'),
-- ('BIT','Kraków','R.Bruner'),
-- ('MIT','Berlin','J.Kos');

-- CREATE TABLE oferta_praktyki
-- ( kod_oferty SERIAL PRIMARY KEY,
--  kod_firmy int NOT NULL REFERENCES firma(kod_firmy),
--  semestr_id int REFERENCES semestr(semestr_id),
--  liczba_miejsc int);

--  INSERT INTO oferta_praktyki(kod_firmy,semestr_id,liczba_miejsc)
--   SELECT kod_firmy,semestr_id,3

--    FROM firma,semestr

--    WHERE firma.nazwa='SNS' AND rok='2018/2019'

--          AND semestr='letni';

-- INSERT INTO oferta_praktyki(kod_firmy,semestr_id,liczba_miejsc)
--   SELECT kod_firmy,semestr_id,2

--    FROM firma,semestr

--    WHERE firma.nazwa='MIT' AND rok='2018/2019'

--          AND semestr='letni';

-- CREATE TABLE praktyki
-- (student int NOT NULL REFERENCES student,
-- opiekun int REFERENCES pracownik,
-- oferta int NOT NULL REFERENCES oferta_praktyki);

CREATE OR REPLACE FUNCTION pp() RETURNS VOID AS $X$
DECLARE
    s student;
    wolna_oferta int;
BEGIN
    FOR s IN (SELECT * FROM student 
    WHERE semestr BETWEEN 6 AND 10 
      AND kod_uz NOT IN (SELECT student FROM praktyki))
    LOOP
        SELECT max(kod_oferty) INTO wolna_oferta FROM oferta_praktyki WHERE liczba_miejsc > 0;
        IF (wolna_oferta is NULL) THEN EXIT; END IF;
        INSERT INTO praktyki VALUES (s.kod_uz,NULL,wolna_oferta);
        UPDATE oferta_praktyki SET liczba_miejsc = liczba_miejsc - 1 WHERE kod_oferty = wolna_oferta;
    END LOOP;
END
$X$ LANGUAGE plpgsql;

SELECT pp();