	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$248,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-120(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then1894
	jmp	end1896
then1894:
	movq	-120(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1896:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$3,	8(%rbx)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1897
	jmp	end1899
then1897:
	movq	-120(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-120(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	movq	-120(%rbp),	%rax
	movq	0(%rax),	%rbx
end1899:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-48(%rbp)
	addq	$24,	free_ptr(%rip)
	movq	-48(%rbp),	%rax
	movq	$5,	0(%rax)
	movq	-48(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-48(%rbp),	%rax
	movq	$42,	16(%rax)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1900
	jmp	end1902
then1900:
	pushq	-48(%rbp)
	movq	-120(%rbp),	%rax
	popq	8(%rax)
	movq	-120(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-120(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	pushq	-120(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-48(%rbp)
	movq	-120(%rbp),	%rax
	movq	0(%rax),	%rbx
end1902:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-56(%rbp)
	addq	$24,	free_ptr(%rip)
	movq	-56(%rbp),	%rax
	movq	$389,	0(%rax)
	pushq	-48(%rbp)
	movq	-56(%rbp),	%rax
	popq	8(%rax)
	movq	-56(%rbp),	%rax
	movq	%rbx,	16(%rax)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1903
	jmp	end1905
then1903:
	pushq	-56(%rbp)
	movq	-120(%rbp),	%rax
	popq	16(%rax)
	pushq	-48(%rbp)
	movq	-120(%rbp),	%rax
	popq	8(%rax)
	movq	-120(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-120(%rbp),	%rcx
	addq	$3,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	pushq	-120(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-56(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-48(%rbp)
	movq	-120(%rbp),	%rax
	movq	0(%rax),	%rbx
end1905:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-64(%rbp)
	addq	$24,	free_ptr(%rip)
	movq	-64(%rbp),	%rax
	movq	$133,	0(%rax)
	movq	-64(%rbp),	%rax
	movq	$6,	8(%rax)
	pushq	-56(%rbp)
	movq	-64(%rbp),	%rax
	popq	16(%rax)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1906
	jmp	end1908
then1906:
	pushq	-64(%rbp)
	movq	-120(%rbp),	%rax
	popq	24(%rax)
	pushq	-56(%rbp)
	movq	-120(%rbp),	%rax
	popq	16(%rax)
	pushq	-48(%rbp)
	movq	-120(%rbp),	%rax
	popq	8(%rax)
	movq	-120(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-120(%rbp),	%rcx
	addq	$4,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	pushq	-120(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-56(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-48(%rbp)
	movq	-120(%rbp),	%rax
	movq	0(%rax),	%rbx
end1908:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-72(%rbp)
	addq	$24,	free_ptr(%rip)
	movq	-72(%rbp),	%rax
	movq	$133,	0(%rax)
	movq	-72(%rbp),	%rax
	movq	$2,	8(%rax)
	pushq	-64(%rbp)
	movq	-72(%rbp),	%rax
	popq	16(%rax)
	movq	free_ptr(%rip),	%rcx
	addq	$24,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1909
	jmp	end1911
then1909:
	pushq	-72(%rbp)
	movq	-120(%rbp),	%rax
	popq	32(%rax)
	pushq	-64(%rbp)
	movq	-120(%rbp),	%rax
	popq	24(%rax)
	pushq	-56(%rbp)
	movq	-120(%rbp),	%rax
	popq	16(%rax)
	pushq	-48(%rbp)
	movq	-120(%rbp),	%rax
	popq	8(%rax)
	movq	-120(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-120(%rbp),	%rcx
	addq	$5,	%rcx
	movq	%rcx,	%rdi
	movq	$24,	%rsi
	callq	collect
	pushq	-120(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-56(%rbp)
	pushq	-120(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-48(%rbp)
	movq	-120(%rbp),	%rax
	movq	0(%rax),	%rbx
end1911:
	movq	free_ptr(%rip),	%rbx
	addq	$24,	free_ptr(%rip)
	movq	$133,	0(%rbx)
	movq	$4,	8(%rbx)
	movq	-72(%rbp),	%rax
	movq	%rax,	16(%rbx)
	movq	%rbx,	%rbx
	movq	16(%rbx),	%rax
	movq	%rax,	-80(%rbp)
	pushq	-80(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-96(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-104(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-112(%rbp)
	movq	-112(%rbp),	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$248,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

