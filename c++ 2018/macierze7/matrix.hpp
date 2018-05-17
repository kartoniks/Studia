#pragma once
#include<iostream>
using namespace std;

class errors : exception{};
class sizeerror : errors
{
    public:
    const char* what();
};
class inverseerror : errors
{
    public:
    const char* what();
};
class deterror : errors
{
    public:
    const char* what();
};
class matrix
{
    public:
    matrix(int m, int n);
    matrix(int x);//identity matrix
    matrix(const matrix &M2);
    matrix(matrix&& M2);
    ~matrix();

    matrix& operator=(const matrix& M2);
    matrix& operator+=(const matrix& M2);
    matrix& operator*=(const int& a);
    matrix& operator*=(const matrix& M2);
    friend ostream& operator<<(ostream& os, const matrix& M);
    friend istream& operator>>(istream& is, matrix& M);
    void display();
    void transpose();
    void rowchange(int i, int j);
    void rowmult(int index, int alpha);
    void rowadd(int from, int to, int alpha);
    matrix reduce(int r, int c);
    int determinant();
    matrix adjoint();
    matrix inverse();
    protected:
    double** p;
    int m;
    int n;
};
