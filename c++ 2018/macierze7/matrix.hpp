#pragma once
#include<iostream>
using namespace std;
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
