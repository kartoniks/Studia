#include "stos.hpp"
#include <stdexcept>
#include <utility>
Stos::Stos()
{
    stos = new std::string[1];
    pojemnosc =1;
    rozmiar = 0;
}

Stos::Stos(int k){
    stos = new std::string[k];
    pojemnosc = k;
    rozmiar = 0;

}

Stos::Stos(std::initializer_list<std::string> l){
    stos = new std::string[l.size()];
    pojemnosc = l.size();
    rozmiar=0;
    for(auto x : l)
    {
        wloz(x);
    }

}

Stos::Stos(Stos&& x) : rozmiar(x.rozmiar), pojemnosc(x.pojemnosc), stos(std::move(x.stos)){
    x.rozmiar = 0;
}

Stos::Stos(const Stos& x) : pojemnosc(x.pojemnosc), rozmiar(x.rozmiar){
    std::copy(x.stos, x.stos + x.rozmiar, stos);
}

Stos & Stos::operator=(const Stos& x){
    pojemnosc = x.pojemnosc;
    rozmiar = x.rozmiar;
    std::copy(x.stos, x.stos + x.rozmiar, stos);

}

Stos & Stos::operator=(Stos&& x){
    pojemnosc = x.pojemnosc;
    rozmiar = x.rozmiar;
    stos = std::move(x.stos);
    
}


void Stos::wloz(std::string x){
    if(rozmiar == pojemnosc) throw std::range_error("STOS PEŁNY!");
    stos[rozmiar] = x;
    rozmiar++;

}

std::string Stos::sciagnij(){
    if(rozmiar == 0) throw std::range_error("STOS PUSTY!");
    rozmiar--;
    return stos[rozmiar];
}

