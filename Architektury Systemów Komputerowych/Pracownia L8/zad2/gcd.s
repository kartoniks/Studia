        .globl	gcd
        .type gcd,@function
        .text

gcd:
	movq	%rdi, %r8
	movq	%rsi, %r9	#zapisuje sobie wartosci poczatkowe
.ST:	test 	%rsi, %rsi
	jz	.END
	movq	%rsi, %rcx	#temp=b
	movq	$0,   %rdx	#dzielenie, dzieli rdx:rax przez operand
	movq	%rdi, %rax	#wynik zapisuje w rax, a reszte w rdx
	divq	%rsi
	movq	%rdx, %rsi
	movq	%rcx, %rdi	#a=temp
	jmp	.ST
.END:	movq	%r8,  %rax	#w rax zwracam gcd
	movq	$0,   %rdx
	divq	%rdi
	movq	%r9,  %rdx
	imulq	%rax, %rdx	#lcm=a*b/gcd(a,b)
	movq	%rdi, %rax		
	ret	 
	.size	gcd, . - gcd                       
