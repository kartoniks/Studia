        .globl	insert_sort
        .type insert_sort,@function
        .text

insert_sort:
	leaq	8(%rdi),	%r11	#wskaznik na ostatni element
	
START:	movq	%r11, 	%r8
INS:	cmpq	%r8,	%rdi
	jz	LOOP
	movq	(%r8),	%r9	#obecna wartosc
	subq	$8,	%r8
	cmpq	(%r8),	%r9
	jg	LOOP	
	movq	(%r8),	%r10	#robie swapa
	movq	%r9,	(%r8)
	movq	%r10,	8(%r8)
	jmp	INS

LOOP:	cmpq	%r11,	%rsi	#czy to juz koniec tablicy
	jz	END	
	addq	$8,	%r11
	jmp	START	

END:	ret	 
	.size	insert_sort, . - insert_sort
