#include "wymierna.hpp"
#include <map>
namespace obliczenia{
wymierna::wymierna(int a, int b)
{
    if(b<0)
    {
        a=-a;
        b=-b;
    }
    int div=gcd(a,b);
    licz=a/div;
    mian=b/div;
    if(mian==0)
        throw dzielenie();
}
wymierna::wymierna(int a) : wymierna::wymierna(a,1){};
int wymierna::licznik()
{
    return licz;
}
int wymierna::mianownik()
{
    return mian;
}
int wymierna::gcd(int a, int b)
{
    if(b==0)
        return a;
    return gcd(b, a%b);
}
wymierna wymierna::operator+(const wymierna &w2)
{
    long long t = licz*w2.mian+w2.licz*mian;
    if(t>numeric_limits<int>::max())
        throw przekroczenie();
    int l = t;
    int m = mian*w2.mian;
    return wymierna(l,m);
}
wymierna wymierna::operator-(const wymierna &w2)
{
    long long t = licz*w2.mian-w2.licz*mian;
    if(t<numeric_limits<int>::min())
        throw przekroczenie();
    int l = t;
    int m = mian*w2.mian;
    return wymierna(l,m);
}
wymierna wymierna::operator*(const wymierna &w2)
{
    long long t_l = licz*w2.licz;
    long long t_m = mian*w2.mian;
    if(t_l>numeric_limits<int>::max() || t_m>numeric_limits<int>::max())
        throw przekroczenie();
    int l = t_l;
    int m = t_m;
    return wymierna(l,m);
}
wymierna wymierna::operator/(const wymierna &w2)
{
    long long t_l = licz*w2.licz;
    long long t_m = mian*w2.mian;
    if(t_l>numeric_limits<int>::max() || t_m>numeric_limits<int>::max())
        throw przekroczenie();
    int l = licz*w2.mian;
    int m = mian*w2.licz;
    if(m==0)
        throw dzielenie();
    return wymierna(l,m);
}
wymierna& wymierna::operator-()
{
    licz=-licz;
    return *this;
}
wymierna& wymierna::operator!()
{
    if(licz<0)
    {
        int temp=-licz;
        licz=-mian;
        mian=temp;
    }
    else
    {
        swap(licz,mian);
    }
    if(mian==0)
        throw dzielenie();
    return *this;
}
wymierna::operator int()
{
    return licz/mian;
}
wymierna::operator double()
{
    double val = double(licz)/double(mian);

    return val;
}

ostream& operator<< (ostream &wyj, const wymierna &w)
{
    wyj<<w.licz<<"/"<<w.mian<<endl;
}
}

const char* przekroczenie::what()
{
    return "Przekroczenie zakresu";
}
const char* dzielenie::what()
{
    return "Dzielenie przez 0";
}
