/* Imię nazwisko: Artur Derechowski
 * Numer indeksu: 299574
 *
 * Oświadczam, że:
 *  - rozwiązanie zadania jest mojego autorstwa,
 *  - jego kodu źródłowego dnie będę udostępniać innym studentom,
 *  - a w szczególności nie będę go publikować w sieci Internet.
 *
 * Q: Zdefiniuj proces "zombie".
 * A: Proces, który już zakończył działanie, ale jego wpis jeszcze widnieje do odczytania przez rodzica.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, const char * argv[]) {
  
  if( argc == 2 ) {
    if( strcmp(argv[1], "--bury") == 0 ) {
      struct sigaction sa;
      sa.sa_handler = SIG_IGN;
      sigaction(SIGCHLD, &sa, NULL); // to powinno byc sigaction jakos
    }
  }

  char *args[] = {"/bin/ps", "-aux", NULL};
  char *const execve_args[] = {"myproc", "-F", NULL};
  // Fork returns process id 
  pid_t child_pid = fork(); 
  // Parent process  
  if (child_pid > 0) {
    sleep(1);
    execve("/bin/ps", execve_args, __environ);
  }
  // Child process 
  else {
    exit(0);
  }       
  
  return EXIT_SUCCESS;
}
