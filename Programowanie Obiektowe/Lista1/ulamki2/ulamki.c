#include<stdio.h>
#include<stdlib.h>
#include"ulamki.h"
void skroc(Ulamek* u)
{
    int mniejszy = u->licznik;
    if(mniejszy>u->mianownik)
        mniejszy = u->mianownik;

    for(int i=2; i<=mniejszy; i++)
    {
        while(u->licznik%i==0 && u->mianownik%i==0)
        {
            u->licznik/=i;
            u->mianownik/=i;
        }
    }
}

Ulamek* dodaj(Ulamek* a, Ulamek* b)
{
    Ulamek* wynik = (Ulamek*)malloc(sizeof(Ulamek));
    wynik->licznik = a->licznik*b->mianownik+a->mianownik*b->licznik;
    wynik->mianownik = a->mianownik*b->mianownik;
    skroc(wynik);
    return wynik;
}

Ulamek* odejmij(Ulamek* a, Ulamek* b)
{
    Ulamek* wynik = (Ulamek*)malloc(sizeof(Ulamek));
    wynik->licznik = a->licznik*b->mianownik-a->mianownik*b->licznik;
    wynik->mianownik = a->mianownik*b->mianownik;
    skroc(wynik);
    return wynik;
}

Ulamek* pomnoz(Ulamek* a, Ulamek* b)
{
    Ulamek* wynik = (Ulamek*)malloc(sizeof(Ulamek));
    wynik->licznik = a->licznik*b->licznik;
    wynik->mianownik = a->mianownik*b->mianownik;
    skroc(wynik);
    return wynik;
}

Ulamek* podziel(Ulamek* a, Ulamek* b)
{
    Ulamek* wynik = (Ulamek*)malloc(sizeof(Ulamek));
    wynik->licznik = a->licznik*b->mianownik;
    wynik->mianownik = a->mianownik*b->licznik;
    skroc(wynik);
    return wynik;
}

void dodaj2(Ulamek* a, Ulamek* b)
{
    Ulamek* temp = b;
    b->licznik = a->licznik*temp->mianownik+a->mianownik*temp->licznik;
    b->mianownik = a->mianownik*temp->mianownik;
    skroc(b);
}

void odejmij2(Ulamek* a, Ulamek* b)
{
    Ulamek* temp = b;
    b->licznik = a->licznik*temp->mianownik-a->mianownik*temp->licznik;
    b->mianownik = a->mianownik*temp->mianownik;
    skroc(b);
}

void pomnoz2(Ulamek* a, Ulamek* b)
{
    Ulamek* temp = b;
    b->licznik = a->licznik*temp->licznik;
    b->mianownik = a->mianownik*temp->mianownik;
    skroc(b);
}

void podziel2(Ulamek* a, Ulamek* b)
{
    Ulamek* temp = b;
    b->licznik = a->licznik*temp->mianownik;
    b->mianownik = a->mianownik*temp->licznik;
    skroc(b);
}
