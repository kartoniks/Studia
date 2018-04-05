#pragma once

enum typfig {Trojkat, Kwadrat, Kolo};

typedef struct Fig
{
    int typ;
    float ax, ay, promien, bx, by, cx, cy;
    //w kwadracie punkt b to prawy górny a punkt a to lewy dolny
    //w trojkacie punkty a i b leżą na prostej.
    //kolo jest opisane za pomocą punktu a i promienia.

}Figura;

float pole(Figura* f);

void przesun(Figura* f, float x, float y);

float sumapol(Figura* f, int size);

Figura* nowaFigura();

