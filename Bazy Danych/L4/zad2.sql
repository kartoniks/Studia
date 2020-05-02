CREATE TYPE zajecia AS (
  nazwa text,
  rodzaj_zajec character(1),
  termin character(13),
  sala character varying(3), 
  liczba_zapisanych bigint
);

CREATE OR REPLACE FUNCTION plan_zajec_prac(int,int) RETURNS SETOF zajecia AS $X$
  SELECT  przedmiot.nazwa, grupa.rodzaj_zajec, grupa.termin, grupa.sala, COUNT(
      DISTINCT student.kod_uz)
  FROM uzytkownik 
    JOIN grupa USING (kod_uz)
    JOIN wybor USING (kod_grupy)
    JOIN uzytkownik student ON (student.kod_uz = wybor.kod_uz)
    JOIN przedmiot_semestr USING (kod_przed_sem)
    JOIN przedmiot USING (kod_przed)
  WHERE uzytkownik.kod_uz = $1
    AND przedmiot_semestr.semestr_id = $2
  GROUP BY przedmiot.nazwa, grupa.rodzaj_zajec, grupa.termin, grupa.sala;
$X$ LANGUAGE sql STABLE;

SELECT * FROM plan_zajec_prac(187,39);