	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$352,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$1,	%rbx
	movq	$1,	-48(%rbp)
	movq	$1,	-56(%rbp)
	movq	$1,	-64(%rbp)
	movq	$1,	-72(%rbp)
	movq	$1,	-80(%rbp)
	movq	$1,	-88(%rbp)
	movq	$1,	-96(%rbp)
	movq	$1,	-104(%rbp)
	movq	$1,	-112(%rbp)
	movq	$1,	-120(%rbp)
	movq	$1,	-128(%rbp)
	movq	$1,	-136(%rbp)
	movq	$1,	-144(%rbp)
	movq	$1,	-152(%rbp)
	movq	$1,	-160(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	%rcx,	%rcx
	movq	$1,	%rdx
	movq	$1,	%rsi
	movq	$1,	-8(%rbp)
	movq	$1,	-16(%rbp)
	movq	$21,	-24(%rbp)
	movq	-16(%rbp),	%rax
	addq	%rax,	-24(%rbp)
	movq	-24(%rbp),	%rax
	movq	%rax,	-16(%rbp)
	movq	-8(%rbp),	%rax
	addq	%rax,	-16(%rbp)
	movq	-16(%rbp),	%rax
	movq	%rax,	-8(%rbp)
	addq	%rsi,	-8(%rbp)
	movq	-8(%rbp),	%rsi
	addq	%rdx,	%rsi
	movq	%rsi,	%rdx
	addq	%rcx,	%rdx
	movq	%rdx,	%rcx
	addq	-160(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-152(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-144(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-136(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-128(%rbp),	%rcx
	movq	%rcx,	%rcx
	addq	-120(%rbp),	%rcx
	movq	%rcx,	%rcx
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
	addq	$352,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

