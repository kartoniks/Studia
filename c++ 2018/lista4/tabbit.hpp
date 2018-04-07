#pragma once
#include<iostream>
#include<stdexcept>
#include <cmath>
#include<bitset>
using namespace std;

class tab_bit
{
    typedef uint64_t slowo; // komorka w tablicy
    static const int rozmiarSlowa = 8*sizeof(slowo); // rozmiar slowa w bitach
    friend istream & operator >> (istream &we, tab_bit &tb);
    friend ostream & operator << (ostream &wy, const tab_bit &tb);
    slowo *tab;
    friend class ref;
    int ilekom;
    bool czytaj (int i) const; // metoda pomocnicza do odczytu bitu
    bool pisz (int i, bool b); // metoda pomocnicza do zapisu bitu
protected:
    int dl; // liczba bitów
public:
    class ref{
        private:
            int i;
            tab_bit& tb;
        public:
            ref(int, tab_bit&);
            ~ref();
            operator bool () const;
            ref& operator= (const bool x);
            ref& operator= (const ref& x);

    };
     // tablica bitów
    explicit tab_bit (int rozm); // wyzerowana tablica bitow [0...rozm]
    explicit tab_bit (slowo tb); // tablica bitów [0...rozmiarSlowa]
    tab_bit(initializer_list<bool>);// zainicjalizowana wzorcem
    tab_bit (const tab_bit &tb); // konstruktor kopiujący
    tab_bit (tab_bit &&tb); // konstruktor przenoszący
    tab_bit & operator = (const tab_bit &tb); // przypisanie kopiujące
    tab_bit & operator = (tab_bit &&tb); // przypisanie przenoszące
    ~tab_bit (); // destruktor
    ref operator[] (int i);
    bool operator[] (int i) const; // indeksowanie dla stałych tablic bitowych
    int rozmiar () const; // rozmiar tablicy w bitach
public:
    tab_bit& operator|=(tab_bit const &tb);
    tab_bit operator | (tab_bit const &tb);
    tab_bit& operator&=(tab_bit const &tb);
    tab_bit operator & (tab_bit const &tb);
    tab_bit& operator^=(tab_bit const &tb);
    tab_bit operator ^ (tab_bit const &tb);
// operatory bitowe: | i |=, & i &=, ^ i ^= oraz
};
