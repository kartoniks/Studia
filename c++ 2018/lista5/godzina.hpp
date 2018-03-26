#pragma once
#include "data.hpp"
class Godzina : public Data
{
public:
    Godzina(int s, int mi, int h, int d, int m, int y);
    Godzina();
    int Gethour();
    int Getminute();
    int Getsecond();
    friend int operator - (Godzina &h1, Godzina &h2);
    bool operator <(Data& rhs);


protected:
    int hour;
    int minute;
    int second;

};
