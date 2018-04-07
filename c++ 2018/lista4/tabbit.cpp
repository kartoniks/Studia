#include "tabbit.hpp"
//klasa ref nie jest mojego autorstwa, nie wiedziałem jak samemu to napisać
tab_bit::ref::ref(int i, tab_bit& tb): i(i), tb(tb)
{
//    sl = tb.tab + (i/rozmiarSlowa);
//    przesuniecie = ((slowo)1 << (i % rozmiarSlowa));
}

tab_bit::ref::operator bool() const
{
    return tb.czytaj(this->i);
}

tab_bit::ref &tab_bit::ref::operator=(const bool x)
{
/*
    if (x==1)
        *sl = (*sl | przesuniecie);
    else
        *sl = (*sl & ~przesuniecie);
    return *this;
*/
    tb.pisz(this->i, x);
    return *this;
}

tab_bit::ref &tab_bit::ref::operator=(const ref &x)
{
    tb.pisz(i,x);
    return *this;
}

tab_bit::ref::~ref()
{
}

bool tab_bit::operator[](int i) const
{
    return czytaj(i);
    //return tab_bit::ref(i, tab);
}

tab_bit::ref tab_bit::operator[](int i)
{
    return tab_bit::ref(i, *this);
}


tab_bit::tab_bit(int rozm)
{
    dl=rozm;
    ilekom = (rozm+rozmiarSlowa-1)/rozmiarSlowa;
    tab = new slowo[ilekom];
    for(int i=0; i<ilekom; i++)
        tab[i]=0;
}

tab_bit::tab_bit(slowo w)
{
    dl=rozmiarSlowa;
    ilekom = 1;
    tab = new slowo[ilekom];
    tab[0] = w;
}

tab_bit::tab_bit(const tab_bit &tb)
{
    dl = tb.dl;
    ilekom = tb.ilekom;
    tab = new slowo[ilekom];
    for(int i = 0; i < ilekom;i++)
    {
        tab[i] = tb.tab[i];
    }
}

tab_bit:: tab_bit (tab_bit &&tb)
{
    dl = tb.dl;
    ilekom = tb.ilekom;
    tab = tb.tab;
    tb.tab = nullptr;
}

tab_bit& tab_bit :: operator = (const tab_bit &tb)
{
    if(this != &tb)
    {
        delete[] tab;
        dl = tb.dl;
        ilekom = tb.ilekom;
        tab = new slowo[ilekom];
        for(int i = 0; i < ilekom; i++)
            tab[i] = tb.tab[i];
    }
    return *this;
}

tab_bit& tab_bit :: operator = (tab_bit &&tb)
{
    if(this != &tb)
    {
        delete[] tab;
        dl = tb.dl;
        ilekom = tb.ilekom;
        tab = tb.tab;
        tb.tab = nullptr;
    }
    return *this;
}

ostream & operator << (ostream &wy, const tab_bit &tb)
{
    for(int i=0; i<tb.ilekom; i++)
    {
        for(int j=tb.rozmiarSlowa-1; j>=0; j--)
        {
            wy<<((tb.tab[i]>>j)&1);
        }
    }
    return wy;
}

istream & operator >> (istream &we, tab_bit &tb)
{
    string temp;
    we>>temp; //tb.slowo temp; //nie dziala
    for(int i=0; i<tb.rozmiar(); i++)
    {
        tb[i] = (bool)temp[i];
    }
    return we;
}

bool tab_bit::czytaj(int index) const
{
    slowo kom = index/rozmiarSlowa;
    slowo bit = index%rozmiarSlowa;
    return (tab[kom]>>bit)&1;
}

bool tab_bit :: pisz(int index, bool b)
{
    slowo kom = index/rozmiarSlowa;
    slowo bit = index%rozmiarSlowa;
    tab[kom] = (((tab[kom])&(~(1<<bit)))|(b<<bit));
    return b;
}

tab_bit& tab_bit::operator|=(tab_bit const &tb)
{
    if(rozmiar()!=tb.rozmiar())
        throw invalid_argument( "operacja na ciagach roznej dlugosci" );
    for(int i=0; i<ilekom; i++)
        tab[i]|=tb.tab[i];
    return *this;
}

tab_bit tab_bit::operator | (tab_bit const &tb)
{
    if(rozmiar()!=tb.rozmiar())
        throw invalid_argument( "operacja na ciagach roznej dlugosci" );
    tab_bit temp(tb);
    for(int i=0; i<ilekom; i++)
        temp.tab[i]|=tab[i];
    return temp;
}

tab_bit& tab_bit::operator&=(tab_bit const &tb)
{
    if(rozmiar()!=tb.rozmiar())
        throw invalid_argument( "operacja na ciagach roznej dlugosci" );
    for(int i=0; i<ilekom; i++)
        tab[i]&=tb.tab[i];
    return *this;
}

tab_bit tab_bit::operator & (tab_bit const &tb)
{
    if(rozmiar()!=tb.rozmiar())
        throw invalid_argument( "operacja na ciagach roznej dlugosci" );
    tab_bit temp(tb);
    for(int i=0; i<ilekom; i++)
        temp.tab[i]&=tab[i];
    return temp;
}

tab_bit& tab_bit::operator^=(tab_bit const &tb)
{
    if(rozmiar()!=tb.rozmiar())
        throw invalid_argument( "operacja na ciagach roznej dlugosci" );
    for(int i=0; i<ilekom; i++)
        tab[i]^=tb.tab[i];
    return *this;
}

tab_bit tab_bit::operator ^ (tab_bit const &tb)
{
    tab_bit temp(tb);
    temp ^= *this;
    return temp;
}

int tab_bit::rozmiar () const
{
    return dl;
}

tab_bit::~tab_bit ()
{
    delete[] tab;
}
