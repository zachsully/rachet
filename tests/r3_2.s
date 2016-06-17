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
	movq	rootstack_begin(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1300
	jmp	end1302
then1300:
	movq	%rbx,	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$24,	%rsi
	callq	collect
end1302:
	movq	free_ptr(%rip),	%rbx
	addq	$24,	free_ptr(%rip)
	movq	$5,	0(%rbx)
	movq	$20,	8(%rbx)
	movq	$22,	16(%rbx)
	movq	%rbx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	movq	16(%rbx),	%rax
	movq	%rax,	-56(%rbp)
	movq	-56(%rbp),	%rbx
	addq	-48(%rbp),	%rbx
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

