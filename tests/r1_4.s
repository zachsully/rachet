	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$40,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$11,	%rbx
	addq	$10,	%rbx
	movq	$4,	%rcx
	negq	%rcx
	movq	%rcx,	%rcx
	addq	$25,	%rcx
	movq	%rcx,	%rcx
	addq	%rbx,	%rcx
	movq	%rcx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$40,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

