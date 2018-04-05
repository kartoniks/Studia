#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include"figury.h"

float pole(Figura* f)
{
    if(f->typ==Kolo)
    {
        return M_PI*f->promien*f->promien;
    }
    if(f->typ==Kwadrat)
    {
        return (f->bx-f->ax)*(f->by-f->ay);
    }
    if(f->typ==Trojkat)
    {
        return abs(f->bx-f->ax)*abs(f->cy-f->ay)/2;
    }
}

void przesun(Figura* f, float x, float y)
{
    if(f->typ==Kolo)
    {
        f->ax+=x;
        f->ay+=y;
    }
    if(f->typ==Kwadrat)
    {
        f->ax+=x;
        f->ay+=y;
        f->bx+=x;
        f->by+=y;
    }
    if(f->typ==Trojkat)
    {
        f->ax+=x;
        f->ay+=y;
        f->bx+=x;
        f->by+=y;
        f->cx+=x;
        f->cy+=y;
    }
}

float sumapol(Figura* f, int size)
{
    Figura* temp = f;
    float wynik=0;
    for(int i=0; i<size; i++)
    {
        wynik+=pole(temp);
        temp++;
    }
    return wynik;
}

Figura* nowaFigura()
{
    Figura* retFig = (Figura*)malloc(sizeof(struct Fig));
    printf(("Podaj typ: Trojkat (0), Kwadrat (1), Kolo(2)\n"));
    scanf("%d", &retFig->typ);
    if(retFig->typ>2 || retFig->typ<0)
    {
        printf("Zla wartosc");
        return NULL;
    }
    if(retFig->typ == Trojkat)
    {
        printf("Podaj 6 liczb: wspolrzedne x i y podstawy i trzeciego wierzcholka\n");
        scanf("%f%f%f%f%f%f", &retFig->ax, &retFig->ay, &retFig->bx, &retFig->by, &retFig->cx, &retFig->cy);
    }
    if(retFig->typ == Kolo)
    {
        printf("Podaj 3 liczby: wspolrzedne x i y srodka kola i promien\n");
        scanf("%f%f%f", &retFig->ax, &retFig->ay, &retFig->promien);
    }
    if(retFig->typ == Kwadrat)
    {
        printf("Podaj 4 liczby: wspolrzedna x i y lewego dolnego wierzcholka i wspolrzedne x i y prawego gornego wierzcholka\n");
        scanf("%f%f%f%f", &retFig->ax, &retFig->ay, &retFig->bx, &retFig->by);
    }
    return retFig;
}


