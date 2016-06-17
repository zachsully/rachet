	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$344,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$1,	%rbx
	movq	$1,	%rcx
	movq	$1,	%rdx
	movq	$1,	%rsi
	movq	$1,	-8(%rbp)
	movq	$1,	-16(%rbp)
	movq	$1,	-24(%rbp)
	movq	$1,	-32(%rbp)
	movq	$1,	-40(%rbp)
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
	movq	$21,	-144(%rbp)
	movq	-136(%rbp),	%rax
	addq	%rax,	-144(%rbp)
	movq	-144(%rbp),	%rax
	movq	%rax,	-136(%rbp)
	movq	-128(%rbp),	%rax
	addq	%rax,	-136(%rbp)
	movq	-136(%rbp),	%rax
	movq	%rax,	-128(%rbp)
	movq	-120(%rbp),	%rax
	addq	%rax,	-128(%rbp)
	movq	-128(%rbp),	%rax
	movq	%rax,	-120(%rbp)
	movq	-112(%rbp),	%rax
	addq	%rax,	-120(%rbp)
	movq	-120(%rbp),	%rax
	movq	%rax,	-112(%rbp)
	movq	-104(%rbp),	%rax
	addq	%rax,	-112(%rbp)
	movq	-112(%rbp),	%rax
	movq	%rax,	-104(%rbp)
	movq	-96(%rbp),	%rax
	addq	%rax,	-104(%rbp)
	movq	-104(%rbp),	%rax
	movq	%rax,	-96(%rbp)
	movq	-88(%rbp),	%rax
	addq	%rax,	-96(%rbp)
	movq	-96(%rbp),	%rax
	movq	%rax,	-88(%rbp)
	movq	-80(%rbp),	%rax
	addq	%rax,	-88(%rbp)
	movq	-88(%rbp),	%rax
	movq	%rax,	-80(%rbp)
	movq	-72(%rbp),	%rax
	addq	%rax,	-80(%rbp)
	movq	-80(%rbp),	%rax
	movq	%rax,	-72(%rbp)
	movq	-64(%rbp),	%rax
	addq	%rax,	-72(%rbp)
	movq	-72(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	-56(%rbp),	%rax
	addq	%rax,	-64(%rbp)
	movq	-64(%rbp),	%rax
	movq	%rax,	-56(%rbp)
	movq	-48(%rbp),	%rax
	addq	%rax,	-56(%rbp)
	movq	-56(%rbp),	%rax
	movq	%rax,	-48(%rbp)
	movq	-40(%rbp),	%rax
	addq	%rax,	-48(%rbp)
	movq	-48(%rbp),	%rax
	movq	%rax,	-40(%rbp)
	movq	-32(%rbp),	%rax
	addq	%rax,	-40(%rbp)
	movq	-40(%rbp),	%rax
	movq	%rax,	-32(%rbp)
	movq	-24(%rbp),	%rax
	addq	%rax,	-32(%rbp)
	movq	-32(%rbp),	%rax
	movq	%rax,	-24(%rbp)
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
	addq	%rbx,	%rcx
	movq	%rcx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$344,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

