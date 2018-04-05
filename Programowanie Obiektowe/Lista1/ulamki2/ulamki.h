#pragma once

typedef struct Ulamki
{
    int licznik;
    int mianownik;
}Ulamek;

void skroc(Ulamek* u);

Ulamek* dodaj(Ulamek* a, Ulamek* b);

Ulamek* odejmij(Ulamek* a, Ulamek* b);

Ulamek* pomnoz(Ulamek* a, Ulamek* b);

Ulamek* podziel(Ulamek* a, Ulamek* b);

void dodaj2(Ulamek* a, Ulamek* b);

void odejmij2(Ulamek* a, Ulamek* b);

void pomnoz2(Ulamek* a, Ulamek* b);

void podziel2(Ulamek* a, Ulamek* b);

