#include<stdio.h>
#include"ulamki.h"

int main()
{
    Ulamek* pierwszy = (Ulamek*)malloc(sizeof(Ulamek));
    Ulamek* drugi = (Ulamek*)malloc(sizeof(Ulamek));
    pierwszy->licznik = 69;
    pierwszy->mianownik = 420;
    drugi->licznik = 10;
    drugi->mianownik = 1;
    Ulamek* w = pomnoz(pierwszy, drugi);
    printf("%d/%d", w->licznik, w->mianownik);

    return 0;
}
