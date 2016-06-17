	.globl even.2295
even.2295:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
	movq	%rsi,	-48(%rbp)
	movq	%rdx,	%rbx
	movq	$0,	%rax
	cmpq	-48(%rbp),	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then2350
	leaq	odd.2296(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2353
	jmp	end2355
then2353:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2355:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-56(%rbp)
	movq	$1,	%rcx
	negq	%rcx
	movq	-48(%rbp),	%rdx
	addq	%rcx,	%rdx
	movq	-72(%rbp),	%rdi
	movq	%rdx,	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	jmp	end2352
then2350:
	movq	$1,	%rbx
end2352:
	movq	%rbx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$32,	%rsp
	popq	%rbp
	retq

	.globl odd.2296
odd.2296:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
	movq	%rsi,	-48(%rbp)
	movq	%rdx,	%rbx
	movq	$0,	%rax
	cmpq	-48(%rbp),	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then2356
	leaq	even.2295(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2359
	jmp	end2361
then2359:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2361:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-56(%rbp)
	movq	$1,	%rcx
	negq	%rcx
	movq	-48(%rbp),	%rdx
	addq	%rcx,	%rdx
	movq	-72(%rbp),	%rdi
	movq	%rdx,	%rsi
	movq	%rbx,	%rdx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	jmp	end2358
then2356:
	movq	$0,	%rbx
end2358:
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
	subq	$176,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-72(%rbp)
	leaq	odd.2296(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2362
	jmp	end2364
then2362:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2364:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-48(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-48(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-48(%rbp),	%rax
	movq	%rbx,	8(%rax)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then2365
	jmp	end2367
then2365:
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rbx
	addq	$1,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end2367:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$131,	0(%rbx)
	movq	-48(%rbp),	%rax
	movq	%rax,	8(%rbx)
	movq	%rbx,	-80(%rbp)
	leaq	even.2295(%rip),	%rax
	movq	%rax,	-88(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2368
	jmp	end2370
then2368:
	movq	-72(%rbp),	%rax
	movq	%rbx,	8(%rax)
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	movq	-72(%rbp),	%rax
	movq	8(%rax),	%rbx
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end2370:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	-88(%rbp),	%rax
	movq	%rax,	8(%rbx)
	movq	-80(%rbp),	%rax
	movq	%rbx,	8(%rax)
	pushq	-80(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-56(%rbp),	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-72(%rbp),	%rdi
	movq	$21,	%rsi
	movq	%rbx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	cmpq	$1,	%rbx
	je	then2371
	movq	$42,	%rbx
	jmp	end2373
then2371:
	movq	$999,	%rbx
end2373:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$176,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

