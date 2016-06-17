	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$96,	%rsp
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
	je	then1318
	jmp	end1320
then1318:
	movq	-64(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1320:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$42,	8(%rbx)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1321
	jmp	end1323
then1321:
	movq	-64(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-64(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	movq	-64(%rbp),	%rax
	movq	0(%rax),	%rbx
end1323:
	movq	free_ptr(%rip),	%rcx
	addq	$24,	free_ptr(%rip)
	movq	$261,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	$21,	16(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-56(%rbp),	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$96,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

