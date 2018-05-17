#include <iostream>
#include "wymierna.hpp"

using namespace std;
using namespace obliczenia;
int main()
{
try{
        wymierna a(20);
        wymierna b=a;
        wymierna c(2,3);
        a=-a;
        double d = static_cast<double>(c);
        cout<<c<<d<<endl;
        wymierna x(5,13);
        wymierna y(2,5);
        cout<<x*y;
    }catch(przekroczenie e){
        cout<<e.what();
    }catch(dzielenie e){
        cout<<e.what();
    }
        return 0;
}
