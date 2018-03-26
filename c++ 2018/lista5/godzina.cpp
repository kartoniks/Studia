#include "godzina.hpp"

Godzina::Godzina(int s, int mi, int h, int d, int m, int y)
{
    Data();
    year=y;
    month=m;
    day=d;
    hour= h;
    minute= mi;
    second= s;
}

Godzina::Godzina()
{
    Data();
    auto now = chrono::system_clock::now();
    std::time_t now_c = chrono::system_clock::to_time_t(now);
    struct tm *parts = std::localtime(&now_c);
    hour = parts->tm_hour;
    minute = parts->tm_min;
    second = parts->tm_sec;
}

int Godzina::Gethour()
{
    return hour;
}
int Godzina::Getminute()
{
    return minute;
}
int Godzina::Getsecond()
{
    return second;
}

int operator - (Godzina &h1, Godzina &h2) //to jest minus tak naprawdę
{
    int daydif = h1.Deltadays()-h2.Deltadays();
    daydif *= 24*60*60;
    int hourdif = h1.Gethour()-h2.Gethour();
    hourdif *= 60*60;
    int minutedif = h1.Getminute()-h2.Getminute();
    minutedif*=60;
    int seconddif = h1.Getsecond()-h2.Getsecond();
    return daydif+hourdif+minutedif+seconddif;
}

bool Godzina::operator <(Data& rhs)
{
    return *this-rhs<0;
}
