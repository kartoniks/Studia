#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h> 

void insert_sort(long *first, long *last);

int main(int argc, char *argv[])
{	
	long vals[argc-1];
	for(int i=1; i<argc; i++)
		vals[i-1]=atol(argv[i]);
	long *first = &vals[0];
	long *last = &vals[argc-2];
	insert_sort(first, last); 
	for(int i=0; i<argc-1; i++)
		printf("%ld ", vals[i]);
	return 0;
}

