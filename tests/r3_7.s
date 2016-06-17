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
	movq	%rax,	-80(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then1357
	jmp	end1359
then1357:
	movq	-80(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1359:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$0,	8(%rbx)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1360
	jmp	end1362
then1360:
	movq	-80(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-80(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	movq	-80(%rbp),	%rax
	movq	0(%rax),	%rbx
end1362:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-48(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-48(%rbp),	%rax
	movq	$131,	0(%rax)
	movq	-48(%rbp),	%rax
	movq	%rbx,	8(%rax)
	movq	-48(%rbp),	%rax
	movq	%rax,	-56(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1363
	jmp	end1365
then1363:
	pushq	-48(%rbp)
	movq	-80(%rbp),	%rax
	popq	8(%rax)
	movq	-80(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-80(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-80(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-48(%rbp)
	movq	-80(%rbp),	%rax
	movq	0(%rax),	%rbx
end1365:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$42,	8(%rbx)
	movq	%rbx,	%rbx
	movq	-56(%rbp),	%rax
	movq	%rbx,	8(%rax)
	pushq	-56(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-64(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-72(%rbp)
	movq	-72(%rbp),	%rax
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

