#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> 

unsigned mult(unsigned a, unsigned b);

int main(int argc, char *argv[])
{	
	//przyklad wywolania: 1073741824 1077936128
	//czyli 2*3
	unsigned x = atoi(argv[1]);
	unsigned y = atoi(argv[2]);
	unsigned a = mult(x,y);
	printf("%u: %.8x\n", a, a);
	return 0;
}

