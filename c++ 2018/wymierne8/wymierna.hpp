#include<iostream>
#include <limits>
using namespace std;

class errors : exception{};
class przekroczenie : errors
{
    public:
    const char* what();
};
class dzielenie : errors
{
    public:
    const char* what();
};
namespace obliczenia{
class wymierna
{
    public:
    wymierna(int, int);
    wymierna(int);
    int gcd(int, int);
    int licznik();
    int mianownik();
    friend ostream& operator<< (ostream &wyj, const wymierna &w);
    wymierna operator+(const wymierna &w2);
    wymierna operator-(const wymierna &w2);
    wymierna operator*(const wymierna &w2);
    wymierna operator/(const wymierna &w2);
    explicit operator int();
    explicit operator double();
    wymierna& operator-();
    wymierna& operator!();
    private:
    int licz, mian;
};
}
