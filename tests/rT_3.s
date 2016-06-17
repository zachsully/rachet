	.globl swap.1106
swap.1106:
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
	movq	8(%rcx),	%rax
	movq	%rax,	-48(%rbp)
	movq	16(%rcx),	%rax
	movq	%rax,	-56(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$24,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then1133
	jmp	end1135
then1133:
	movq	-72(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$24,	%rsi
	callq	collect
end1135:
	movq	free_ptr(%rip),	%rbx
	addq	$24,	free_ptr(%rip)
	movq	$5,	0(%rbx)
	movq	-56(%rbp),	%rax
	movq	%rax,	8(%rbx)
	movq	-48(%rbp),	%rax
	movq	%rax,	16(%rbx)
	movq	%rbx,	%rax
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
	subq	$112,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-72(%rbp)
	leaq	swap.1106(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1136
	jmp	end1138
then1136:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1138:
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
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1139
	jmp	end1141
then1139:
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end1141:
	movq	free_ptr(%rip),	%rcx
	addq	$24,	free_ptr(%rip)
	movq	$5,	0(%rcx)
	movq	$1,	8(%rcx)
	movq	$42,	16(%rcx)
	movq	-72(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-64(%rbp),	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$112,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

