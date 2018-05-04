        .globl	mult

bit = 0x80000000
exp = 0x7f800000
mant = 0x007fffff
extr = 0x00800000
maks = 0x01000000

        .type mult,@function
        .text

mult:
	movl	%edi,	%r8d
	movl	%esi,	%r9d
	andl	$bit,	%r8d
	andl	$bit,	%r9d
	xorl	%r9d,	%r8d	#w r8 trzymam nowy bit znaku
	
	movl	%edi,	%r9d
	movl	%esi,	%r10d
	andl	$exp,	%r9d
	andl	$exp,	%r10d
	addl	%r10d,	%r9d
	movl	$127,	%r10d
	sall	$23,	%r10d
	subl	%r10d,	%r9d	#nowy exponent, równy e1+e2-127

	movl	%edi,	%r10d
	movl	%esi,	%r11d
	andl	$mant,	%r10d
	addl	$extr,	%r10d	
	andl	$mant,	%r11d
	addl	$extr,	%r11d
	imulq	%r11,	%r10
	sarq	$23,	%r10	#nowa mantysa, równa M1*M2

	
	cmpl	$maks,	%r10d	
	jle	END
	sarl	$1,	%r10d
	movl	$1,	%r11d
	sall	$23,	%r11d	#jesli mantysa byla za duża normalizuje
	addl	%r11d,	%r9d	#mantyse i exponent M>>=1 E+=1

END:
	movq	$0,	%rax
	orl	%r8d,	%eax
	orl	%r9d,	%eax
	subl	$extr,	%r10d
	orl	%r10d,	%eax
	ret
	.size	mult, . - mult
