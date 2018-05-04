        .globl  leadingzeros
        .type leadingzeros,@function
	
        .text
leadingzeros:
	movq	$0xffffffff00000000,	%r9	#maska
	movq	%rdi,	%r10		#liczba(argument)
	movq	$32,	%r11		#ile jest zer
	movq	$16,	%rcx		#nastepne przesuniecie maski
	movq	$0xffffffffffffffff,	%r13
	movq	$0,	%r14		#pamieta ostatni and z maska
	movq	$0xfffffffffffffffe,	%r15	#po tej wartosci normalnie sie nie przesuwa

Start:	movq	%r9,	%r12
	andq	%r10,	%r12
	cmpq	$0,	%r12
	jz	Zero
	cmpq	$0,	%r9		 #czy same zera
	jz	End
	movq	$1,	%r14
	salq	%cl,	%r9
	subq	%rcx,	%r11
	cmpq	$1,	%rcx		#co najmniej przesuwaj o 1
	jz	Skips
	shrq	$1,	%rcx	
Skips:	jmp	Start

Zero:	cmpq	%r13,	%r9		#czy same jedynki
	jz	End
	cmpq	$1,	%r14		#sprawdza czy wczesniej bylo ok
	jz	End
	movq	$0,	%r14
	sarq	%cl,	%r9		#przesuwanie maski w prawo
	addq	%rcx,	%r11		#pamietanie wyniku
	cmpq	$1,	%rcx		#nie chce przesuniecia o 0
	jz	Skipz
	shrq	$1,	%rcx
Skipz:	jmp	Start

End:	movq	%r11,	%rax		
	ret      
	.size	leadingzeros, . - leadingzeros                       
