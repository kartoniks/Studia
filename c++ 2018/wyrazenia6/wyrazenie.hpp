#pragma once
#include<iostream>
#include<map>
using namespace std;

class wyrazenie
{
    public:
    virtual double oblicz() = 0;
    virtual string opis() = 0;
    int priorytet=0;
};

class liczba : public wyrazenie
{
    public:
    liczba(double v);
    double oblicz();
    string opis();
    protected:
    double wartosc;
};

class stala : public wyrazenie
{
    public:
    stala(string s);
    double oblicz();
    string opis();
    protected:
    double wartosc;
    string symbol;
};

class zmienna : public wyrazenie
{
    public:
    static map<string, double> zbior;
    static void zmienwartosc(string s, double val);
    zmienna (string symbol, double val);
    zmienna (string symbol);
    double oblicz();
    string opis();
    protected:
    string symbol;
};

class operator1arg : public wyrazenie
{
    protected:
    wyrazenie* argument1;
    //explicit operator1arg(wyrazenie* arg);
};

class sinus : public operator1arg
{
    public:
    sinus(wyrazenie* w);
    double oblicz();
    string opis();
};
class cosinus : public operator1arg
{
    public:
    cosinus(wyrazenie* w);
    double oblicz();
    string opis();
};
class bezwzgl : public operator1arg
{
    public:
    bezwzgl(wyrazenie* w);
    double oblicz();
    string opis();
};

class operator2arg : public operator1arg
{
    protected:
    wyrazenie* argument2;
};

class dodaj : public operator2arg
{
    public:
    dodaj(wyrazenie* a1, wyrazenie* a2);
    double oblicz();
    string opis();
};
class odejmij : public operator2arg
{
    public:
    odejmij(wyrazenie* a1, wyrazenie* a2);
    double oblicz();
    string opis();
};
class mnoz : public operator2arg
{
    public:
    mnoz(wyrazenie* a1, wyrazenie* a2);
    double oblicz();
    string opis();
};
class dziel : public operator2arg
{
    public:
    dziel(wyrazenie* a1, wyrazenie* a2);
    double oblicz();
    string opis();
};
class potega : public operator2arg
{
    public:
    potega(wyrazenie* a1, wyrazenie* a2);
    double oblicz();
    string opis();
};
