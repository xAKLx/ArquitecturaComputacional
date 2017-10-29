	.file	"main.c"
	.section	.rodata
.LC0:
	.string	"hi"
.LC1:
	.string	" + ((bytes[%d] & 0b"
.LC2:
	.string	")>>%d)"
.LC3:
	.string	"o:b:"
.LC4:
	.string	"print"
.LC5:
	.string	"%s%s%s%s"
.LC6:
	.string	"%x"
.LC7:
	.string	"%u %d\n"
.LC8:
	.string	"switch"
.LC9:
	.string	"%u"
.LC10:
	.string	"%u\n"
.LC11:
	.string	"count"
.LC12:
	.string	"%d\n"
.LC13:
	.string	"turnoff"
.LC14:
	.string	"turnon"
.LC15:
	.string	"div16"
.LC16:
	.string	"\n%ld"
.LC17:
	.string	"2.59"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$136, %rsp
	.cfi_offset 3, -24
	movl	%edi, -132(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movq	$0, -80(%rbp)
	movl	$0, -112(%rbp)
	movl	$0, -100(%rbp)
	jmp	.L2
.L9:
	movl	$0, -108(%rbp)
	jmp	.L3
.L8:
	movl	-100(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -104(%rbp)
	jmp	.L4
.L5:
	movl	$48, %edi
	call	putchar
	addl	$1, -104(%rbp)
.L4:
	movl	-104(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jl	.L5
	movl	$49, %edi
	call	putchar
	movl	-108(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -104(%rbp)
	jmp	.L6
.L7:
	movl	$48, %edi
	call	putchar
	addl	$1, -104(%rbp)
.L6:
	cmpl	$7, -104(%rbp)
	jle	.L7
	movl	$7, %eax
	subl	-108(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -108(%rbp)
.L3:
	cmpl	$7, -108(%rbp)
	jle	.L8
	addl	$1, -100(%rbp)
.L2:
	cmpl	$0, -100(%rbp)
	js	.L9
	jmp	.L10
.L13:
	movl	-96(%rbp), %eax
	cmpl	$98, %eax
	je	.L11
	cmpl	$111, %eax
	jne	.L10
	movq	optarg(%rip), %rax
	movq	%rax, -80(%rbp)
	jmp	.L10
.L11:
	movq	optarg(%rip), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -112(%rbp)
	nop
.L10:
	movq	-144(%rbp), %rcx
	movl	-132(%rbp), %eax
	movl	$.LC3, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	getopt
	movl	%eax, -96(%rbp)
	cmpl	$-1, -96(%rbp)
	jne	.L13
	movq	-80(%rbp), %rax
	movl	$.LC4, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L14
	movl	optind(%rip), %eax
	cltq
	addq	$3, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	2(%rax), %rdi
	movl	optind(%rip), %eax
	cltq
	addq	$2, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	2(%rax), %rsi
	movl	optind(%rip), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	2(%rax), %rcx
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdi, %r9
	movq	%rsi, %r8
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf
	leaq	-116(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	-116(%rbp), %edx
	movl	-116(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L14:
	movq	-80(%rbp), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L16
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -92(%rbp)
	movl	optind(%rip), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, -88(%rbp)
	movl	optind(%rip), %eax
	cltq
	addq	$2, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-116(%rbp), %rdx
	movl	$.LC9, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	leaq	-116(%rbp), %rax
	movq	%rax, -72(%rbp)
	movl	-92(%rbp), %eax
	movslq	%eax, %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -121(%rbp)
	movl	-92(%rbp), %eax
	movslq	%eax, %rdx
	movq	-72(%rbp), %rax
	addq	%rax, %rdx
	movl	-88(%rbp), %eax
	movslq	%eax, %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movl	-88(%rbp), %eax
	movslq	%eax, %rdx
	movq	-72(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-121(%rbp), %eax
	movb	%al, (%rdx)
	movl	-116(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC10, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L16:
	movq	-80(%rbp), %rax
	movl	$.LC11, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L17
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-116(%rbp), %rdx
	movl	$.LC9, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	leaq	-116(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$128, %eax
	sarl	$7, %eax
	movl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$64, %eax
	sarl	$6, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$32, %eax
	sarl	$5, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$16, %eax
	sarl	$4, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$8, %eax
	sarl	$3, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$4, %eax
	sarl	$2, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$2, %eax
	sarl	%eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$1, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$128, %eax
	sarl	$7, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$64, %eax
	sarl	$6, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$32, %eax
	sarl	$5, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$16, %eax
	sarl	$4, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$8, %eax
	sarl	$3, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$4, %eax
	sarl	$2, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$2, %eax
	sarl	%eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$1, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$128, %eax
	sarl	$7, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$64, %eax
	sarl	$6, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$32, %eax
	sarl	$5, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$16, %eax
	sarl	$4, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$8, %eax
	sarl	$3, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$4, %eax
	sarl	$2, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$2, %eax
	sarl	%eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$1, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$128, %eax
	sarl	$7, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$64, %eax
	sarl	$6, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$32, %eax
	sarl	$5, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$16, %eax
	sarl	$4, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$8, %eax
	sarl	$3, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$4, %eax
	sarl	$2, %eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$2, %eax
	sarl	%eax
	addl	%eax, %edx
	movq	-64(%rbp), %rax
	addq	$3, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	$1, %eax
	addl	%edx, %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L17:
	movq	-80(%rbp), %rax
	movl	$.LC13, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L18
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-116(%rbp), %rdx
	movl	$.LC9, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	-112(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	notl	%eax
	movl	%eax, %edx
	movl	-116(%rbp), %eax
	andl	%edx, %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L18:
	movq	-80(%rbp), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L19
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-116(%rbp), %rdx
	movl	$.LC9, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	-112(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-116(%rbp), %eax
	orl	%edx, %eax
	movl	%eax, %esi
	movl	$.LC12, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L19:
	movq	-80(%rbp), %rax
	movl	$.LC15, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L20
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atol
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	div16
	movq	%rax, %rsi
	movl	$.LC16, %edi
	movl	$0, %eax
	call	printf
	jmp	.L22
.L20:
	movq	-80(%rbp), %rax
	movl	$.LC17, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L22
	movl	optind(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-120(%rbp), %rdx
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	optind(%rip), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	leaq	-116(%rbp), %rdx
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf
	movl	-120(%rbp), %eax
	movzbl	%al, %eax
	movl	-116(%rbp), %edx
	movb	$0, %dl
	addl	%edx, %eax
	movl	%eax, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
.L22:
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L21
	call	__stack_chk_fail
.L21:
	addq	$136, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.globl	div16
	.type	div16, @function
div16:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	leaq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -2(%rbp)
	movsbl	-2(%rbp), %eax
	andl	$128, %eax
	sarl	$7, %eax
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %edx
	movl	%edx, %eax
	sall	$4, %eax
	subl	%edx, %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	sarq	$4, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	div16, .-div16
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
