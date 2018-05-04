#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> 

int64_t leadingzeros(int64_t);

int main(int argc, char *argv[]) {
	long ll = atol(argv[1]);
	printf("%ld\n", leadingzeros(ll));
    return 0;
}

