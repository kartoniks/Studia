#include <iostream>
#include "matrix.hpp"
using namespace std;

int main()
{
    matrix* M1 = new matrix(5);
    matrix* M2 = new matrix(*M1);
    matrix* M3 = new matrix(4);
    (*M1)*=2;
    (*M2)*=3;
    (*M1)*=(*M2);
    *M2=M1->reduce(0,0);
    cout<<*M1;
    cout<<M1->determinant()<<endl;
    cout<<*M2;
    cout<<M1->inverse();
    return 0;
}
