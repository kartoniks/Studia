#pragma once
#include<iostream>
#include<stdexcept>
#include <cmath>
#include <iostream>
#include <chrono>
#include <ctime>
using namespace std;

class Data
{
public:
    Data(int d, int m, int y);
    Data();
    Data(Data& d);
    int Getday();
    int Getmonth();
    int Getyear();
    void Setday(int x);
    void Setmonth(int x);
    void Setyear(int x);//gettery i settery
    static bool Leapyear(int y);
    static int dniwmiesiacach[2][13];
    static int dniodpoczroku[2][13];
    int Deltadays();
    virtual int operator - (Data &d2);

protected:
    int day;
    int month;
    int year;
    bool Iscorrect();

};
