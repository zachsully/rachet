	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$144,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then2130
	jmp	end2132
then2130:
	movq	-64(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2132:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$0,	8(%rbx)
	movq	%rbx,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2133
	jmp	end2135
then2133:
	movq	-64(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-64(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	movq	-64(%rbp),	%rax
	movq	0(%rax),	%rbx
end2135:
	movq	free_ptr(%rip),	%rbx
	addq	$48,	free_ptr(%rip)
	movq	$11,	0(%rbx)
	movq	$1,	8(%rbx)
	movq	$2,	16(%rbx)
	movq	$3,	24(%rbx)
	movq	$4,	32(%rbx)
	movq	$5,	40(%rbx)
	movq	%rbx,	%rbx
	callq	read_int
	movq	%rax,	%rcx
	movq	$0,	%rax
	cmpq	%rcx,	%rax
	sete	%al
	movzbq	%al,	%rcx
	cmpq	$1,	%rcx
	je	then2136
	movq	$42,	8(%rbx)
	movq	-56(%rbp),	%rbx
	jmp	end2138
then2136:
	movq	-48(%rbp),	%rax
	movq	$42,	8(%rax)
	movq	-56(%rbp),	%rbx
end2138:
	movq	%rbx,	%rbx
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-56(%rbp),	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$144,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

