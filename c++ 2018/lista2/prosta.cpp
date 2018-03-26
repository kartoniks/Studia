#include "prosta.h"


wektor::wektor() : dx(0), dy(0) {};

wektor::wektor(double x, double y) : dx(x), dy(y) {};

wektor::wektor(wektor &v) : dx(v.dx), dy(v.dy) {};

void zloz(wektor &v1, wektor &v2) //czy to ma zwracać wektor? jak tak to nie wiem jak bo const
{
    cout<<"Zlozenie wektorow: ("<<v1.dx<<","<<v1.dy<<") ("<<v2.dx<<","<<v2.dy<<")";
    cout<<" to:("<<v1.dx+v2.dx<<","<<v1.dy+v2.dy<<")"<<endl;
}

punkt::punkt() : x(0), y(0) {};

punkt::punkt(double a, double b) : x(a), y(b) {};

punkt::punkt(wektor &v, punkt &p) : x(v.dx+p.x), y(v.dy+p.y) {};

punkt::punkt(punkt &p) : x(p.x), y(p.y) {};

prosta::prosta(punkt &p, punkt &q)
{
    a=p.y-q.y;
    b=q.x-p.x;
    c=p.x*q.y-q.x*p.y;
    normuj();
}

prosta::prosta(wektor &v)
{
    a=v.dx;
    b=v.dy;
    c=-a*a-b*b;
    normuj();
}

prosta::prosta(double x, double y, double z)
{
    if (x==0 && y==0)
        throw invalid_argument("nie można jednoznacznie utworzyć prostej");
    a=x;
    b=y;
    c=z;
    normuj();
}

prosta::prosta(prosta &p, wektor &v)
{
    a=p.get_a();
    b=p.get_b();
    c=p.get_c()-v.dx*a-v.dy*b;
    normuj();
}

prosta::prosta()
{
    a=0;
    b=1;
    c=0;
}

bool prosta::prostopadly(wektor &v)
{
    return v.dx/get_a()==v.dy/get_b();
}

bool prosta::rownolegly(wektor &v)
{
    return v.dx/get_b()==-v.dy/get_a();
}

bool prosta::lezy(punkt &p)
{
    return get_a()*p.x+get_b()*p.y+get_c()==0;
}

void prosta::normuj()
{
    double skala=sqrt(get_a()*get_a()+get_b()*get_b())/sqrt(2);
    a/=skala;
    b/=skala;

    c/=skala;
}

bool rownolegle(prosta &a, prosta &b)
{
    return a.get_a()*b.get_b()==a.get_b()*b.get_a();
}

bool prostopadle(prosta &a, prosta &b)
{
    return a.get_a()*b.get_a()==a.get_b()*b.get_b();
}

void punkt_przeciecia(prosta &a, prosta &b)
{
    if(rownolegle(a,b))
        throw invalid_argument("proste rownoległe nie maja punktu przeciecia");
    double x =(-a.get_c()+b.get_c()*a.get_b()/b.get_b())/(a.get_a()-b.get_a()*a.get_b()/b.get_b());
    double y =(-a.get_a()*x-a.get_c())/a.get_b();
    cout<<"Punkt przeciecia:("<<x<<","<<y<<endl;
}

