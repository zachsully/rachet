	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$272,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	callq	read_int
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-48(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-56(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-64(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-72(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-80(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-88(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-96(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-104(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	-112(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	%rcx
	movq	$31,	%rdx
	addq	%rcx,	%rdx
	movq	%rdx,	%rcx
	addq	-112(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-104(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-96(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-88(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-80(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-72(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-64(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-56(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-48(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	%rbx,	%rcx
	movq	%rcx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$272,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

