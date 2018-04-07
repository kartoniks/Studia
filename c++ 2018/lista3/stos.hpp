#ifndef STOS_HPP
#define STOS_HPP

#include <string>

class Stos{
    private:
        int pojemnosc;
        int rozmiar;
        std::string* stos;
    public:
        Stos();
        Stos(int);
        Stos(std::initializer_list<std::string>);
        Stos(Stos&&);
        Stos(const Stos&);

        Stos & operator=(const Stos&);
        Stos & operator=(Stos&&);

        void wloz(std::string);
        std::string sciagnij();

        ~Stos(){delete [] stos;}
    protected:  




};




#endif