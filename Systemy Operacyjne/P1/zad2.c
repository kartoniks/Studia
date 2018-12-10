/* Imię nazwisko: Maksymilian Debeściak
 * Numer indeksu: 999999
 *
 * Oświadczam, że:
 *  - rozwiązanie zadania jest mojego autorstwa,
 *  - jego kodu źródłowego dnie będę udostępniać innym studentom,
 *  - a w szczególności nie będę go publikować w sieci Internet.
 *
 * Q: Zdefiniuj proces "sierotę".
 * A: Proces, którego rodzic przestał istnieć, ale on nadal się wykonuje
 *
 * Q: Co się stanie, jeśli główny proces nie podejmie się roli żniwiarza?
 * A: Przygarnia go proces init
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/prctl.h>

int main(void)
{
  char *args[] = {"/bin/ps", "-aux", NULL};
  char *const execve_args[] = {"myproc", "-F", NULL};

  // Fork returns process id
  pid_t child = fork();
  // Parent process
  if (child > 0)
  {
    printf("In parent code %d\n", getpid());
    prctl(PR_SET_CHILD_SUBREAPER, 1);
    execve("/bin/ps", execve_args, __environ);
    sleep(1);
  }
  // Children process
  else
  {
    pid_t grandchild = fork();
    // Child process
    if (grandchild > 0)
    {
      printf("In child code %d\n", getpid());
      exit(0);
    }
    else
    {
      printf("In grandchild code %d\n", getpid());
      sleep(1);
    }
  }
  exit(0);

  return EXIT_SUCCESS;
}
