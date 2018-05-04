        .globl	fib
        .type fib,@function
        .text

fib:
	cmpq	$2,	%rdi
	jle	SMALL
	
	push	%rdi
	subq	$2,	%rdi
	call	fib
	pop	%rdi
	push	%rax
	push	%rdi
	subq	$1,	%rdi
	call 	fib
	pop	%rdi
	pop	%r8		#to jest wynik z fib(n-2)
	addq	%r8,	%rax
	ret

SMALL:	movq	$1,	%rax
	ret
	.size	fib, . - fib
