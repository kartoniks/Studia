#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> 

unsigned long fib(unsigned long n);

int main(int argc, char *argv[])
{	
	unsigned long i = atol(argv[1]);
	printf("%ld\n", fib(i));
	return 0;
}

