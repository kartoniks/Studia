#include <iostream>
#include "data.hpp"
#include "godzina.hpp"

using namespace std;

int main()
{
    try
    {
        Data dzis;
        Data wakacje(30, 6, 2018);
        cout<<wakacje-dzis<<endl;
        Godzina h1;
        Godzina h2;
        h2.Setday(23);
        cout<<(h1<h2)<<endl;

    }
    catch(char const* ex) {
        cout<<ex;
        return 2;
    }

    return 0;
}
