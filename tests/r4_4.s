	.globl id.2154
id.2154:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
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

	.globl id2.2155
id2.2155:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
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
	subq	$136,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-72(%rbp)
	leaq	id2.2155(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2177
	jmp	end2179
then2177:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2179:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-48(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-48(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-48(%rbp),	%rax
	movq	%rbx,	8(%rax)
	movq	-48(%rbp),	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-56(%rbp)
	leaq	id.2154(%rip),	%rax
	movq	%rax,	-80(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2180
	jmp	end2182
then2180:
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end2182:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-80(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	%rcx,	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-72(%rbp),	%rdi
	movq	$42,	%rsi
	movq	%rcx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	movq	-72(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$136,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

