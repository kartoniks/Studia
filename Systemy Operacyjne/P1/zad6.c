/* Imię nazwisko: Maksymilian Debeściak
 * Numer indeksu: 999999
 *
 * Oświadczam, że:
 *  - rozwiązanie zadania jest mojego autorstwa,
 *  - jego kodu źródłowego dnie będę udostępniać innym studentom,
 *  - a w szczególności nie będę go publikować w sieci Internet.
 *
 * Q: Dlaczego w pliku Makefile przekazujemy opcję '-Wl,-rpath,ścieżka'
 *    do sterownika kompilatora?
 * A: ... 
 */

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  void *handle = dlopen("./libmystr.so", RTLD_LAZY);
  char *str;
  char *set;
  double (*drop)(char*, char*);
  *(void **) (&drop) = dlsym(handle, "strdrop");
  drop(str,set);
  return EXIT_SUCCESS;
}
