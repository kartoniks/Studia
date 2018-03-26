#pragma once
#include<iostream>
#include<stdexcept>
#include <cmath>
using namespace std;

class wektor
{
public:
    const double dx;
    const double dy;
    wektor();    //=default; nie może działać bo const
    wektor(double x, double y);
    wektor(wektor &v);
};

void zloz(wektor &v1, wektor &v2);

class punkt
{
public:
    const double x;
    const double y;
    punkt(); //=default;nie może działać bo const
    punkt(double x, double y);
    punkt(wektor &v, punkt &p);
    punkt(punkt &p);
};

class prosta
{
private:
    double a;
    double b;
    double c;
public:
    double get_a()
    {
        return a;
    }

    double get_b()
    {
        return b;
    }
    double get_c()
    {
        return c;
    }

    prosta(punkt &p, punkt &q);
    prosta(wektor &v);
    prosta(double a, double b, double c);
    prosta(prosta &p, wektor &v);
    prosta();    //=default; nie może działać bo const

    bool prostopadly(wektor &v);
    bool rownolegly(wektor &v);
    bool lezy(punkt &p);
    void normuj();
};

bool rownolegle(prosta &a, prosta &b);

bool prostopadle(prosta &a, prosta &b);

void punkt_przeciecia(prosta &a, prosta &b);

