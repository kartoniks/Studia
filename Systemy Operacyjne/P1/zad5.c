/* Imię nazwisko: Maksymilian Debeściak
 * Numer indeksu: 999999
 *
 * Oświadczam, że:
 *  - rozwiązanie zadania jest mojego autorstwa,
 *  - jego kodu źródłowego dnie będę udostępniać innym studentom,
 *  - a w szczególności nie będę go publikować w sieci Internet.
 *
 * Q: Czemu procedura printf nie jest wielobieżna, a snprintf jest?
 * A: ... 
 */

#define _GNU_SOURCE
#include <execinfo.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ucontext.h>
#include <unistd.h>

void myhandler(int sig, siginfo_t *info, void *ucontext) {
  static char buffer[100]; 
  int size; 
  //Composes a string with the same text that would be printed if format was used on printf, 
  //but instead of being printed, the content is stored as a C string in the buffer pointed by s
  size = snprintf(buffer, 100, "Adres bledu: 0x%lx\n", info->si_addr);
  write(1, buffer, size); //bo printf nie jest wielobieżny
  
  if(info->si_code == 1) 
    size = snprintf(buffer, 100, "Kod bledu: %s\n", "MAPERR"); 
  else if (info->si_code == 2)
    size = snprintf(buffer, 100, "Kod bledu: %s\n", "ACCERR");
  else
    size = snprintf(buffer, 100, "Kod bledu: %d\n", info->si_code); 
  write(1, buffer, size);

  ucontext_t *context = (ucontext_t*)ucontext; // ze strony: https://www.oracle.com/technetwork/articles/servers-storage-dev/signal-handlers-studio-2282526.html
  unsigned long rsp = context->uc_mcontext.gregs[REG_RSP];
  unsigned long rip = context->uc_mcontext.gregs[REG_RIP];
  size = snprintf(buffer, 100, "Adres instrukcji: 0x%lx\n", rsp); 
  write(1, buffer, size);
  size = snprintf(buffer, 100, "Adres stosu: 0x%lx\n", rip); 
  write(1, buffer, size);
  
  void *array[100];
  int s = backtrace(array, 100); /*backtrace_symbols_fd() takes the same buffer and size arguments as backtrace_symbols(),
   but instead of returning an array of strings to the caller, it writes the strings, one per line, to the file descriptor fd.*/
  size = snprintf(buffer, 100, "Wywołanie backtrace:\n"); 
  write(STDOUT_FILENO, buffer, size);
  backtrace_symbols_fd(array, s, STDERR_FILENO);
  // printf("handler dziala\n");
  // printf("Adres: %d\n", info->si_addr);
  // printf("SI Code: %d\n", info->si_code);
  exit(-1);
}

int main(int argc, const char * argv[]) {

  struct sigaction sa;
  sa.sa_sigaction = myhandler;
  sa.sa_flags = SA_SIGINFO; // If SA_SIGINFO is specified in sa_flags, then sa_sigaction 
  //(instead of sa_handler) specifies the signal-handling function for signum. 

  sigaction(SIGSEGV, &sa, NULL);

  if( argc == 2 ) {
    if( strcmp(argv[1], "--maperr") == 0 ) {
      char *p = (char *) 42;
      printf("%d", *p);
    }
    if( strcmp(argv[1], "--accerr") == 0) {
      //printf("powinien byc accerr\n");
      char *u = "hello";
      *u = "world";
    }
  }
  // int a = 15;
  // int *p = &a;
  // *p = a;
  //printf("%d", *p);

  return EXIT_SUCCESS;
}
