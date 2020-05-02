-- Napisz wyzwalacze, które będą pilnowały, by student zapisując się na zajęcia 
-- pomocnicze został także zapisany na wykład do przedmiotu.

-- 1.Przy zapisie studenta na zajęcia typu innego niż 'w', należy zapisać 
-- go także do grupy z rodzajem zajęć 'w' do tego samego przedmiotu, 
-- w tym samym semestrze (do wszystkich grup, jeśli jest ich więcej). 
-- Zwróć uwagę, by nie zapisać studenta na wykład, jeśli jest już na niego zapisany.

-- 2.Napisz też wyzwalacz dla sytuacji, gdy powstaje nowa grupa wykładowa, 
-- a być może wcześniej zostały otwarte grupy z innymi rodzajami zajęć do 
-- danego przedmiotu w danym semestrze - zapisz wszystkich na wykład.

-- 3.Opisz inne zdarzenia w bazie danych, dla ktorych należałoby napisać wyzwalacz, 
-- by zachować warunek: "student musi być zapisany na wykład do przedmiotu, 
-- jeśli jest zapisany na jakiekolwiek zajęcia innego typu do tego przedmiotu".

DROP TRIGGER nazwa_wyzwalacza ON wybor;

CREATE OR REPLACE FUNCTION zapisz_w() RETURNS TRIGGER AS $X$
DECLARE
    rodzaj_zajec_ character(1);
    kod_przed_ int;
    kod_grupy_ int;
BEGIN
  SELECT kod_przed INTO kod_przed_
    FROM wybor JOIN grupa USING (kod_grupy)
    JOIN przedmiot_semestr USING (kod_przed_sem)
    WHERE NEW.kod_uz = wybor.kod_uz AND NEW.kod_grupy = grupa.kod_grupy;  
  SELECT rodzaj_zajec INTO rodzaj_zajec_
    FROM wybor JOIN grupa USING (kod_grupy)
    JOIN przedmiot_semestr USING (kod_przed_sem)
    WHERE NEW.kod_uz = wybor.kod_uz AND NEW.kod_grupy = grupa.kod_grupy;    
  SELECT grupa.kod_grupy INTO kod_grupy_ 
    FROM grupa JOIN przedmiot_semestr USING (kod_przed_sem)
    JOIN grupa g2 ON (g2.kod_przed_sem = przedmiot_semestr.kod_przed_sem)
    WHERE g2.kod_grupy = NEW.kod_grupy
    AND grupa.rodzaj_zajec = 'w';
  IF (rodzaj_zajec_ != 'c')
     AND NEW.kod_uz NOT IN 
      (SELECT w.kod_uz FROM wybor w
        JOIN grupa g ON (w.kod_grupy = g.kod_grupy) 
        WHERE g.kod_grupy = kod_grupy_))
  THEN
    raise notice 'Value: %', rodzaj_zajec_;
    INSERT INTO wybor VALUES (kod_grupy_,NEW.kod_uz, now());
  END IF;
  RETURN NEW;
END
$X$ LANGUAGE PLpgSQL;

CREATE TRIGGER nazwa_wyzwalacza 
AFTER INSERT ON wybor FOR EACH ROW 
EXECUTE PROCEDURE zapisz_w();

-- 4749 - wyklad
-- 4200 - student
-- 4750 - nie-wyklad
-- kod_grupy_

select wybor.kod_uz from wybor join grupa using (kod_grupy) where kod_grupy = 4749;