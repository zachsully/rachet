	.globl id.2139
id.2139:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-56(%rbp)
	movq	%rsi,	%rcx
	movq	%rdx,	%rbx
	movq	%rcx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$32,	%rsp
	popq	%rbp
	retq

	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$72,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-56(%rbp)
	leaq	id.2139(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2151
	jmp	end2153
then2151:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2153:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	movq	-56(%rbp),	%rdi
	movq	$42,	%rsi
	movq	%rbx,	%rdx
	movq	-48(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$72,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

