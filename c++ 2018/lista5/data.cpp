#include "data.hpp"

Data::Data(int d, int m, int y) : day(d), month(m), year(y)
{
    if(!Iscorrect())
        throw "Wrong user input date\n";
};

Data::Data()
{
    auto now = chrono::system_clock::now();
    std::time_t now_c = chrono::system_clock::to_time_t(now);
    struct tm *parts = std::localtime(&now_c);

    year= 1900 + parts->tm_year;
    month= 1 + parts->tm_mon;
    day= parts->tm_mday;
};

Data::Data(Data& d)
{
    day=d.Getday();
    month=d.Getmonth();
    year=d.Getyear();
}

int Data::Getday()
{
    return day;
}
int Data::Getmonth()
{
    return month;
}
int Data::Getyear()
{
    return year;
}
void Data::Setday(int n)
{
    day=n;
}
void Data::Setmonth(int n)
{
    month=n;
}
void Data::Setyear(int n)
{
    year=n;
}

bool Data::Leapyear(int y)
{
    return ((y%4==0 && !(y%100==0)) || y%400==0);
}

bool Data::Iscorrect()
{
    if(month>12 || month<1)
        return false;
    if(day>dniwmiesiacach[Leapyear(year)][month] || day<1)
        return false;
    return true;
}

int Data::Deltadays()
{
    int res=Getday();
    res+=dniodpoczroku[Leapyear(year)][Getmonth()-1];
    for(int i=0; i<year; i++)//a jak inaczej policzyć lata?
        if(Leapyear(i))
            res+=366;
        else
            res+=365;
    return res;
}

int Data::operator - (Data &d2)
{
    return Deltadays() - d2.Deltadays();
}

int Data::dniwmiesiacach[2][13] = {
    {0,31,28,31,30,31,30,31,31,30,31,30,31}, // lata zwykłe
    {0,31,29,31,30,31,30,31,31,30,31,30,31} // lata przestępne
    };

int Data::dniodpoczroku[2][13] = {
    {0,31,59,90,120,151,181,212,243,273,304,334,365}, // lata zwykłe
    {0,31,60,91,121,152,182,213,244,274,305,335,366} // lata przestępne
    };
