	.globl mult.2199
mult.2199:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$40,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-56(%rbp)
	movq	%rsi,	-64(%rbp)
	movq	%rdx,	-48(%rbp)
	movq	%rcx,	%rbx
	cmpq	$0,	-48(%rbp)
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then2226
	leaq	mult.2199(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2229
	jmp	end2231
then2229:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2231:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-72(%rbp)
	movq	$1,	%rcx
	negq	%rcx
	movq	-48(%rbp),	%rdx
	addq	%rcx,	%rdx
	movq	-56(%rbp),	%rdi
	movq	-64(%rbp),	%rsi
	movq	%rdx,	%rdx
	movq	%rbx,	%rcx
	movq	-72(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	addq	-64(%rbp),	%rbx
	movq	%rbx,	%rbx
	jmp	end2228
then2226:
	movq	$0,	%rbx
end2228:
	movq	%rbx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$40,	%rsp
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
	leaq	mult.2199(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2232
	jmp	end2234
then2232:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2234:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	movq	-56(%rbp),	%rdi
	movq	$7,	%rsi
	movq	$6,	%rdx
	movq	%rbx,	%rcx
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

