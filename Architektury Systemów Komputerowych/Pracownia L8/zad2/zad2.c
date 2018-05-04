#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> 

typedef struct {
unsigned long gc, lcm;
} result_t;

result_t gcd(unsigned long, unsigned long);

int comdiv(int a, int b)
{
	int temp;
	while(b!=0){
		temp=b;
		b=a%b;
		a=temp;
	}
	return a;
}
int main(int argc, char *argv[]) {
	unsigned long l1 = atol(argv[1]);
	unsigned long l2 = atol(argv[2]);
	result_t res = gcd(l1, l2); 
	printf("gcd: %ld  lcm: %ld\n", res.gc, res.lcm);
    return 0;
}

