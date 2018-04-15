#include <iostream>
#include "wyrazenie.hpp"
using namespace std;

int main()
{
try{
    wyrazenie *w = new liczba(1);
    wyrazenie *w2= new stala("pi");
    wyrazenie *z = new zmienna("x", 7);
    wyrazenie *dd= new dodaj(z, w2);
    wyrazenie *s = new sinus(w);
    wyrazenie *od = new odejmij(s, s);
    cout<<od->opis()<<endl;
    wyrazenie *o2 = new odejmij(dd, dd);
    cout<<o2->opis()<<endl;
    wyrazenie *t = new odejmij(
        new stala("pi"),
        new dodaj(
            new liczba(2),
            new mnoz(
                new zmienna("y", 0),
                new liczba(7)
                )
            )
        );
    cout<<t->opis()<<endl;
    cout<<t->oblicz()<<endl;
    zmienna::zmienwartosc("y", 1);
    cout<<t->oblicz()<<endl;
}
catch(string e)
{
    cout<<"Error:"<<e<<endl;
}
    return 0;
}
