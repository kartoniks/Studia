#include "prosta.h"

int main()
{
    try{
        wektor v (10, 10);
        wektor u (v);
        wektor w;
        zloz(u, v);
        cout<<w.dx<<endl;

        punkt p (2, 4);
        punkt q (v, p);
        cout<<q.y<<endl;

        prosta a (2,2,2);
        prosta b (1,3,5);
        cout<<a.get_a()<<endl;
        cout<<rownolegle(a,b)<<endl;
    }
    catch(exception &exc) {
        cerr<<"niewłaściwe dane"<<endl;
        return 2;
    }
    return( 0 );
}
