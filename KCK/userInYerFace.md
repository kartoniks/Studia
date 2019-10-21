# Userinyerface - doskonale okropne
## Wstęp
Userinyerface to strona, której celem jest pokazanie jak *nie* należy projektować interfejsów graficznych. 
Na każdym kroku użytkownik napotyka wyzwania w wypełnieniu prostego formularza rejestracji, 
co prowadzi do niemałej ilości frustracji, lecz jednocześnie ukazuje, że interfejs użytkownika ma niemałe znaczenie.
Ciekawym wyzwanie może być samodzielne uzupełnienie formularza przed przeczytaniem, zmierzenie czasu i porównanie ze znajomymi.

## Przebieg
### Wejście
Już na wstępnej stronie trafiamy na pierwszą przeszkodę, gdzie musimy nacisnąć *TUTAJ*, jednak wyżej mamy dostępny wielki zielony guzik,
który aż zachęca do naciśnięcia myszą. Jest interaktywny, a kursor zmienia się na rączkę po najechaniu na obszar guzika.
Napis *TUTAJ* jest natomiast niewielki, a po najechaniu nie widać zmiany kursora, co zmusza do przeczytania całego tekstu, 
zanim dowiemy się co należy zrobić. Dodatkowo inne wyrazy są __pokreślone__ lub ***zmieniają barwę***. co dodatkowo utrudnia czytanie,
w wyniku czego najpierw przeklikamy cały tekst zanim wywołamy właściwą interakcję.

### Pola wpisywania
Następnie uruchamia się stoper, a my musimy wpisać swoje dane użytkownika, np. email. Okazuje się to jednak nie być proste,
nie można tylko wpisać wartości, ale na każdy element maila jest osobne pole innego typu 
(np. idiotyczny wybór domeny zamiast wpisania). Dodatkowo trzeba ręcznie kasować bazowe wartości (np. "Imię").
Dodatkowo dochodzi dręcząca walidacja hasła (np. musi zawierać jeden znak z maila), a po chwili braku aktywności
włącza się o tym powiadomienie, z którego równie ciężko jest wyjść. Dodajmy jeszcze zaznaczenie **nie** 
zgadzam się na przejście dalej, i kilka długich chwil później możemy przejść do następnego ekranu.

### Zdjęcie
Po chwili pojawia się obraz, który trzeba dodać (ale na przycisku napisane jest pobierz), oraz lista rzeczy do zaznaczenia, 
których trzeba wybrać dokładnie trzy. Nie brzmi to źle aż do chwili, gdy zobaczymy, że elementów jest ponad 20 i są do tego zaznaczone.
Czarę goryczy przelewa fakt, że jedno pole zaznacza ponownie wszystkie, czyli de fact odznaczeń zrobimy prawie 40.

### Dane personalne
Potem wypełniamy dane personalne. Warto tu zwrócić uwagę na przykład na flagi państw pokolorowane na czarno-biało, 
miesiące posortowane alfabetycznie zamiast chronologicznie czy wiek wybierany suwakiem do zakresu 200. 
Wisienką na torcie jest wybór płci, gdzie kolor selektora zlewający się z tłem wyraźnie sugeruje przeciwną
wartość do rzeczywiście wybranej.

### Captcha
Chociaż Captche zazwyczaj są zmorą użytkowników, to ta również dostarcza pewnych wrażeń.
Angielska gra słów "glasses" każe zaznaczać wszystkie pary okularów, lecz również szyby i kawałki szkła, 
w końcu to wszystko prawidłowe tłumaczenia. Ostatnią przeszkodą jest nieintuicyjne umieszczenie kwadratów do zaznaczania 
nad zamiast pod obrazami. Po naciśnięciu zatwierdź zostajemy nareszcie przekierowani na końcowy ekran z naszym czasem ukończenia.

## Podsumowanie 
Firma Baggard zrobiła świetną robotę ukazując nieintuicyjność wielu interfejsów aż do przesady,
dostarczając przy tym całkiem dobrą rozrywkę. Pokazuje to, że często interface a inyerface rzeczywiście niewiele się różnią.
Warto zatem się zastanowić czy to co piszemy jest dostępne i intuicyjne dla każdego. Koniec, czas: 15:43.
