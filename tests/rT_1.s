	.globl id.1052
id.1052:
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
	subq	$144,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-72(%rbp)
	leaq	id.1052(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1074
	jmp	end1076
then1074:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1076:
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
	leaq	id.1052(%rip),	%rax
	movq	%rax,	-80(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1077
	jmp	end1079
then1077:
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
end1079:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-80(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	%rcx,	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-72(%rbp),	%rdi
	movq	$0,	%rsi
	movq	%rcx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	cmpq	$1,	%rcx
	je	then1080
	movq	$42,	%rcx
	jmp	end1082
then1080:
	movq	$0,	%rcx
end1082:
	movq	-72(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rax
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

