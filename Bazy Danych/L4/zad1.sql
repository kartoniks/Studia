CREATE OR REPLACE FUNCTION pierwszy_zapis(int,int) RETURNS timestamp with time zone AS 
$X$
    SELECT data FROM wybor
        JOIN grupa USING (kod_grupy)
        JOIN przedmiot_semestr USING (kod_przed_sem)
    WHERE wybor.kod_uz = $1
        AND semestr_id = $2
    ORDER BY data ASC
    LIMIT 1;
$X$ LANGUAGE sql STABLE;

SELECT DISTINCT nazwisko, pierwszy_zapis(uzytkownik.kod_uz,przedmiot_semestr.semestr_id)
FROM uzytkownik
    JOIN wybor USING (kod_uz)
    JOIN grupa USING (kod_grupy)
    JOIN przedmiot_semestr USING (kod_przed_sem)
    JOIN semestr USING (semestr_id)
WHERE nazwisko LIKE 'A%'
    AND semestr.nazwa = 'Semestr zimowy 2016/2017'
ORDER BY 2 ASC;