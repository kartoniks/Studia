#include "matrix.hpp"

matrix::matrix(int m, int n)
{
    if(m<1 || n<1)
        throw sizeerror();
    this->m=m;
    this->n=n;
    p = new double*[m];
    for(int i=0; i<m; i++)
        p[i] = new double[n];
}
matrix::matrix(int x) : matrix::matrix(x,x)
{
    for(int i=0; i<x; i++)
        p[i][i]=1;
}
matrix::matrix(const matrix &M2) : matrix::matrix(M2.m, M2.n)
{
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            p[i][j]=M2.p[i][j];
}
matrix::matrix(matrix&& M2)
{
    this->~matrix();
    p=M2.p;
    m=M2.m;
    n=M2.n;
}
matrix& matrix::operator=(const matrix& M2)
{
    this->~matrix();
    matrix* newm = new matrix(M2);
    p=newm->p;
    m=newm->m;
    n=newm->n;
    newm->p = NULL;
    delete newm;
    return *this;
}
matrix& matrix::operator+=(const matrix& M2)
{
    if(m!=M2.m || n!=M2.n)
        throw sizeerror();
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            p[i][j]+=M2.p[i][j];
    return *this;
}
matrix& matrix::operator*=(const int& a)
{
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            p[i][j]*=a;
    return *this;
}
matrix& matrix::operator*=(const matrix& M2)
{
    if(m!=M2.n || n!=M2.m)
        throw "wrong matrix sizes";
    matrix* res = new matrix(m, M2.n);
    for(int i=0; i<m; i++)
        for(int j=0; j<M2.n; j++)
            for(int k=0; k<n; k++)
                res->p[i][j]+=(p[i][k]*M2.p[k][j]);
    p=res->p;
    m=res->m;
    n=res->n;
    return *this;//nie wiem dlaczego nie można zwrócić *res, wtedy nie działa??
}
void matrix::transpose()
{
    matrix* res = new matrix(n,m);
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            res->p[j][i]=p[i][j];
    p=res->p;
    m=res->m;
    n=res->n;
}
void matrix::rowchange(int i, int j)
{
    double* temp = p[i];
    p[i]=p[j];
    p[j]=temp;
}
void matrix::rowmult(int index, int a)
{
    for(int i=0; i<n; i++)
        p[index][i]*=a;
}
void matrix::rowadd(int from, int to, int a)
{
    for(int i=0; i<n; i++)
        p[to][i]+=a*p[from][i];
}

matrix matrix::reduce(int r, int c)
{
    matrix* res = new matrix(m-1, n-1);
    for(int i=0; i<r; i++)
        for(int j=0; j<c; j++)
            res->p[i][j]=p[i][j];
    for(int i=r+1; i<m; i++)
        for(int j=0; j<c; j++)
            res->p[i-1][j]=p[i][j];
    for(int i=0; i<r; i++)
        for(int j=c+1; j<n; j++)
            res->p[i][j-1]=p[i][j];
    for(int i=r+1; i<m; i++)
        for(int j=c+1; j<n; j++)
            res->p[i-1][j-1]=p[i][j];
    return *res;
}

int matrix::determinant()
{
    if(m!=n)
        throw deterror();
    if(m==2)
        return p[0][0]*p[1][1]-p[0][1]*p[1][0];
    int recres=0;
    for(int i=0; i<m; i++)
        if(i%2==0)
            recres+=p[0][i]*this->reduce(0,i).determinant();
        else
            recres+=p[0][i]*this->reduce(0,i).determinant();
    return recres;
}

matrix matrix::inverse()
{
    int det = this->determinant();
    if(det==0)
        throw inverseerror();
    matrix adj = this->adjoint();
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            adj.p[i][j]/=det;
    return adj;
}

matrix matrix::adjoint()
{
    matrix* res = new matrix(m,n);
    for(int i=0; i<m; i++)
        for(int j=0; j<n; j++)
            res->p[i][j]=this->reduce(i,j).determinant();
    return *res;
}

ostream& operator<<(ostream& os, const matrix& M)
{
    for(int i=0; i<M.m; i++)
    {
        for(int j=0; j<M.n; j++)
            os<<M.p[i][j]<<" ";
        os<<endl;
    }
    os<<endl;
    return os;
}
istream& operator>>(istream& is, matrix& M)
{
    for(int i=0; i<M.m; i++)
    {
        for(int j=0; j<M.n; j++)
            is>>M.p[i][j];
    }
    return is;
}

matrix::~matrix()
{
    if(p!=NULL)
    {
    for(int i=0; i<m; i++)
        delete[] p[i];
    delete[] p;
    }
}

void matrix::display()
{
    for(int i=0; i<m; i++)
    {
        for(int j=0; j<n; j++)
            cout<<p[i][j]<<" ";
        cout<<endl;
    }
    cout<<endl;
}

const char* sizeerror::what()
{
    return "Invalid matrix sizes";
}

const char* inverseerror::what()
{
    return "Matrix doesn't have inverse";
}

const char* deterror::what()
{
    return "Cannot compute determinant of nonsquare matrix";
}
