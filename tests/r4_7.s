	.globl even.2235
even.2235:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-56(%rbp)
	movq	%rsi,	-48(%rbp)
	movq	%rdx,	%rbx
	movq	$0,	%rax
	cmpq	-48(%rbp),	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then2277
	leaq	odd.2236(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2280
	jmp	end2282
then2280:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2282:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	$1,	%rcx
	negq	%rcx
	movq	-48(%rbp),	%rdx
	addq	%rcx,	%rdx
	movq	-56(%rbp),	%rdi
	movq	%rdx,	%rsi
	movq	%rbx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	jmp	end2279
then2277:
	movq	$1,	%rbx
end2279:
	movq	%rbx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$32,	%rsp
	popq	%rbp
	retq

	.globl odd.2236
odd.2236:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-56(%rbp)
	movq	%rsi,	-48(%rbp)
	movq	%rdx,	%rbx
	movq	$0,	%rax
	cmpq	-48(%rbp),	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then2283
	leaq	even.2235(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2286
	jmp	end2288
then2286:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2288:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	$1,	%rcx
	negq	%rcx
	movq	-48(%rbp),	%rdx
	addq	%rcx,	%rdx
	movq	-56(%rbp),	%rdi
	movq	%rdx,	%rsi
	movq	%rbx,	%rdx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rbx
	jmp	end2285
then2283:
	movq	$0,	%rbx
end2285:
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
	subq	$88,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-56(%rbp)
	leaq	even.2235(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2289
	jmp	end2291
then2289:
	movq	-56(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2291:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	callq	read_int
	movq	%rax,	%rcx
	movq	-56(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-48(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	cmpq	$1,	%rbx
	je	then2292
	movq	$42,	%rbx
	jmp	end2294
then2292:
	movq	$999,	%rbx
end2294:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$88,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

