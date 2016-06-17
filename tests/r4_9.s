	.globl mapint.2374
mapint.2374:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$40,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-104(%rbp)
	movq	%rsi,	-56(%rbp)
	movq	%rdx,	-48(%rbp)
	movq	%rcx,	%rbx
	movq	-48(%rbp),	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-56(%rbp),	%rax
	movq	24(%rax),	%rcx
	movq	-104(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	-48(%rbp),	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-56(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-80(%rbp)
	movq	-104(%rbp),	%rdi
	movq	-80(%rbp),	%rsi
	movq	%rcx,	%rdx
	movq	-72(%rbp),	%rax
	callq	*%rax
	movq	%rax,	-64(%rbp)
	movq	-48(%rbp),	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-56(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-96(%rbp)
	movq	-104(%rbp),	%rdi
	movq	-96(%rbp),	%rsi
	movq	%rcx,	%rdx
	movq	-88(%rbp),	%rax
	callq	*%rax
	movq	%rax,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$32,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2430
	jmp	end2432
then2430:
	movq	-104(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$32,	%rsi
	callq	collect
end2432:
	movq	free_ptr(%rip),	%rcx
	addq	$32,	free_ptr(%rip)
	movq	$7,	0(%rcx)
	movq	-48(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	-64(%rbp),	%rax
	movq	%rax,	16(%rcx)
	movq	%rbx,	24(%rcx)
	movq	%rcx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$40,	%rsp
	popq	%rbp
	retq

	.globl add1.2375
add1.2375:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-104(%rbp)
	movq	%rsi,	%rcx
	movq	%rdx,	%rbx
	movq	$1,	%rbx
	addq	%rcx,	%rbx
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
	subq	$208,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-104(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$32,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then2433
	jmp	end2435
then2433:
	movq	-104(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$32,	%rsi
	callq	collect
end2435:
	movq	free_ptr(%rip),	%rbx
	addq	$32,	free_ptr(%rip)
	movq	$7,	0(%rbx)
	movq	$1,	8(%rbx)
	movq	$2,	16(%rbx)
	movq	$3,	24(%rbx)
	movq	%rbx,	-48(%rbp)
	leaq	mapint.2374(%rip),	%rax
	movq	%rax,	-56(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2436
	jmp	end2438
then2436:
	movq	-104(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-104(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	movq	-104(%rbp),	%rax
	movq	0(%rax),	%rbx
end2438:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-64(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-64(%rbp),	%rax
	movq	$3,	0(%rax)
	pushq	-56(%rbp)
	movq	-64(%rbp),	%rax
	popq	8(%rax)
	movq	-64(%rbp),	%rax
	movq	%rax,	-56(%rbp)
	pushq	-56(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-72(%rbp)
	leaq	add1.2375(%rip),	%rax
	movq	%rax,	-112(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2439
	jmp	end2441
then2439:
	pushq	-64(%rbp)
	movq	-104(%rbp),	%rax
	popq	8(%rax)
	movq	-104(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-104(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-104(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-64(%rbp)
	movq	-104(%rbp),	%rax
	movq	0(%rax),	%rbx
end2441:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	-112(%rbp),	%rax
	movq	%rax,	8(%rbx)
	movq	-104(%rbp),	%rdi
	movq	-48(%rbp),	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rcx
	movq	-72(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-80(%rbp)
	movq	16(%rbx),	%rax
	movq	%rax,	-88(%rbp)
	movq	24(%rbx),	%rax
	movq	%rax,	-96(%rbp)
	movq	$33,	%rbx
	addq	-96(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-88(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-80(%rbp),	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$208,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

