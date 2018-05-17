#include <iostream>
#include "matrix.hpp"
using namespace std;

int main()
{
try{
    matrix* M1 = new matrix(5);
    matrix* M2 = new matrix(*M1);
    matrix* M3 = new matrix(2);
    //cin>>*M3;
    //cout<<*M3;
    (*M1)*=2;
    (*M2)*=3;
    (*M1)*=(*M2);
    *M2=M1->reduce(0,0);
    cout<<*M1;
    cout<<M1->determinant()<<endl;
    cout<<*M2;
    cout<<M1->inverse();
}catch(sizeerror e){
    cout<<e.what();
}catch(inverseerror e){
    cout<<e.what();
}

    return 0;
}
