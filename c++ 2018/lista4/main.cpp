#include <iostream>
#include "tabbit.hpp"
using namespace std;

int main()
{
    //pomoc od Mateusz Kacała i Dominik Hawryluk
    try{
        tab_bit t(60);
        cout << t << endl;
        t[11]=1;
        t[10]=1;
        tab_bit t2(t);
        t2^=t;
        t[40] = 1;
        cout << t << endl;
        cout << t2<<endl;
    }
    catch(exception &exc) {
        cerr<<"niewłaściwe dane"<<endl;
        return 2;
    }
    return 0;
}
