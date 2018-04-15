#include "wyrazenie.hpp"
#include <cmath>


liczba::liczba(double v)
{
    wartosc=v;
    priorytet=100000;
}
double liczba::oblicz()
{
    return wartosc;
}
string liczba::opis()
{
    return to_string(wartosc);
}

stala::stala(string s)
{
    priorytet=100000;
    symbol = s;
    if(s=="pi")
        wartosc=M_PI;
    else if(s=="e")
        wartosc=M_E;
    else if(s=="fi")
        wartosc=1.618033988749;
    else throw invalid_argument( "nieznana stała" );
}
double stala::oblicz()
{
    return wartosc;
}
string stala::opis()
{
    return symbol;
}

map<string, double> zmienna::zbior;
void zmienna::zmienwartosc(string s, double val)
{
    zbior[s]=val;
}
zmienna::zmienna(string s, double val)
{
    priorytet=100000;
    zbior[s]=val;
    symbol=s;
}
double zmienna::oblicz()
{
    return zbior[symbol];
}
string zmienna::opis()
{
    return symbol;
}

/*operator1arg::operator1arg(wyrazenie* w)
{
    argument1=w;
}*/

sinus::sinus(wyrazenie* w)
{
    priorytet=90000000;
    argument1 = w;
}
double sinus::oblicz()
{
    return sin(argument1->oblicz());
}
string sinus::opis()
{
    return "sin("+argument1->opis()+")";
}

cosinus::cosinus(wyrazenie* w)
{
    argument1 = w;
}
double cosinus::oblicz()
{
    return cos(argument1->oblicz());
}
string cosinus::opis()
{
    return "cos("+argument1->opis()+")";
}

bezwzgl::bezwzgl(wyrazenie* w)
{
    argument1 = w;
}
double bezwzgl::oblicz()
{
    return abs(argument1->oblicz());
}
string bezwzgl::opis()
{
    return "|"+argument1->opis()+"|";
}

/*operator2arg::operator2arg(wyrazenie* w1, wyrazenie* w2)
{
    argument1=w1;
    argument2=w2;
}*/

dodaj::dodaj(wyrazenie *w1, wyrazenie *w2)
{
    argument1=w1;
    argument2=w2;
}
double dodaj::oblicz()
{
    return argument1->oblicz() + argument2->oblicz();
}
string dodaj::opis()
{
    if(argument1->priorytet<=priorytet && argument2->priorytet<=priorytet)
        return "("+argument1->opis()+")+("+argument2->opis()+")";
    if(argument1->priorytet<=priorytet)
        return "("+argument1->opis()+")+"+argument2->opis();
    if(argument2->priorytet<=priorytet)
        return argument1->opis()+"+("+argument2->opis()+")";
    return argument1->opis()+"+"+argument2->opis();
}

odejmij::odejmij(wyrazenie *w1, wyrazenie *w2)
{
    argument1=w1;
    argument2=w2;
}
double odejmij::oblicz()
{
    return argument1->oblicz() - argument2->oblicz();
}
string odejmij::opis()
{
    if(argument1->priorytet<=priorytet && argument2->priorytet<=priorytet)
        return "("+argument1->opis()+")-("+argument2->opis()+")";
    if(argument1->priorytet<=priorytet)
        return "("+argument1->opis()+")-"+argument2->opis();
    if(argument2->priorytet<=priorytet)
        return argument1->opis()+"-("+argument2->opis()+")";
    return argument1->opis()+"-"+argument2->opis();
}

mnoz::mnoz(wyrazenie *w1, wyrazenie *w2)
{
    priorytet=20;
    argument1=w1;
    argument2=w2;
}
double mnoz::oblicz()
{
    return argument1->oblicz() * argument2->oblicz();
}
string mnoz::opis()
{
    if(argument1->priorytet<=priorytet && argument2->priorytet<=priorytet)
        return "("+argument1->opis()+")*("+argument2->opis()+")";
    if(argument1->priorytet<=priorytet)
        return "("+argument1->opis()+")*"+argument2->opis();
    if(argument2->priorytet<=priorytet)
        return argument1->opis()+"*("+argument2->opis()+")";
    return argument1->opis()+"*"+argument2->opis();
}

dziel::dziel(wyrazenie *w1, wyrazenie *w2)
{
    priorytet=20;
    argument1=w1;
    argument2=w2;
}
double dziel::oblicz()
{
    return argument1->oblicz() / argument2->oblicz();
}
string dziel::opis()
{
    if(argument1->priorytet<=priorytet && argument2->priorytet<=priorytet)
        return "("+argument1->opis()+")/("+argument2->opis()+")";
    if(argument1->priorytet<=priorytet)
        return "("+argument1->opis()+")/"+argument2->opis();
    if(argument2->priorytet<=priorytet)
        return argument1->opis()+"/("+argument2->opis()+")";
    return argument1->opis()+"/"+argument2->opis();
}

potega::potega(wyrazenie *w1, wyrazenie *w2)
{
    priorytet=50;
    argument1=w1;
    argument2=w2;
}
double potega::oblicz()
{
    return pow(argument1->oblicz(), argument2->oblicz());
}
string potega::opis()
{
    if(argument1->priorytet<=priorytet && argument2->priorytet<=priorytet)
        return "("+argument1->opis()+")^("+argument2->opis()+")";
    if(argument1->priorytet<=priorytet)
        return "("+argument1->opis()+")^"+argument2->opis();
    if(argument2->priorytet<=priorytet)
        return argument1->opis()+"^("+argument2->opis()+")";
    return argument1->opis()+"^"+argument2->opis();
}
