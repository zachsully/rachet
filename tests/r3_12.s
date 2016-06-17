	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$1184,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-528(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then1789
	jmp	end1791
then1789:
	movq	-528(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1791:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$1,	8(%rbx)
	movq	%rbx,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1792
	jmp	end1794
then1792:
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1794:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-56(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-56(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-56(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-56(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1795
	jmp	end1797
then1795:
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1797:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-72(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-72(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-72(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-72(%rbp),	%rax
	movq	%rax,	-80(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1798
	jmp	end1800
then1798:
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$3,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1800:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-88(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-88(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-88(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rax,	-96(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1801
	jmp	end1803
then1801:
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$4,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1803:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-104(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-104(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-104(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-104(%rbp),	%rax
	movq	%rax,	-112(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1804
	jmp	end1806
then1804:
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$5,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1806:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-120(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-120(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-120(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-120(%rbp),	%rax
	movq	%rax,	-128(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1807
	jmp	end1809
then1807:
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$6,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1809:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-136(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-136(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-136(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-136(%rbp),	%rax
	movq	%rax,	-144(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1810
	jmp	end1812
then1810:
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$7,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1812:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-152(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-152(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-152(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-152(%rbp),	%rax
	movq	%rax,	-160(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1813
	jmp	end1815
then1813:
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$8,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1815:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-168(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-168(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-168(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-168(%rbp),	%rax
	movq	%rax,	-176(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1816
	jmp	end1818
then1816:
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$9,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1818:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-184(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-184(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-184(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-184(%rbp),	%rax
	movq	%rax,	-192(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1819
	jmp	end1821
then1819:
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$10,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1821:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-200(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-200(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-200(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-200(%rbp),	%rax
	movq	%rax,	-208(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1822
	jmp	end1824
then1822:
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$11,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1824:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-216(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-216(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-216(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-216(%rbp),	%rax
	movq	%rax,	-224(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1825
	jmp	end1827
then1825:
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$12,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1827:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-232(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-232(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-232(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-232(%rbp),	%rax
	movq	%rax,	-240(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1828
	jmp	end1830
then1828:
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$13,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1830:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-248(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-248(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-248(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-248(%rbp),	%rax
	movq	%rax,	-256(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1831
	jmp	end1833
then1831:
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$14,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1833:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-264(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-264(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-264(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-264(%rbp),	%rax
	movq	%rax,	-272(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1834
	jmp	end1836
then1834:
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$15,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1836:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-280(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-280(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-280(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-280(%rbp),	%rax
	movq	%rax,	-288(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1837
	jmp	end1839
then1837:
	pushq	-280(%rbp)
	movq	-528(%rbp),	%rax
	popq	120(%rax)
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$16,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	120(%rax),	%rax
	movq	%rax,	-280(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1839:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-296(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-296(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-296(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-296(%rbp),	%rax
	movq	%rax,	-304(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1840
	jmp	end1842
then1840:
	pushq	-296(%rbp)
	movq	-528(%rbp),	%rax
	popq	128(%rax)
	pushq	-280(%rbp)
	movq	-528(%rbp),	%rax
	popq	120(%rax)
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$17,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	128(%rax),	%rax
	movq	%rax,	-296(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	120(%rax),	%rax
	movq	%rax,	-280(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1842:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-312(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-312(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-312(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-312(%rbp),	%rax
	movq	%rax,	-320(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1843
	jmp	end1845
then1843:
	pushq	-312(%rbp)
	movq	-528(%rbp),	%rax
	popq	136(%rax)
	pushq	-296(%rbp)
	movq	-528(%rbp),	%rax
	popq	128(%rax)
	pushq	-280(%rbp)
	movq	-528(%rbp),	%rax
	popq	120(%rax)
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$18,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	136(%rax),	%rax
	movq	%rax,	-312(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	128(%rax),	%rax
	movq	%rax,	-296(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	120(%rax),	%rax
	movq	%rax,	-280(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1845:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-328(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-328(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-328(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-328(%rbp),	%rax
	movq	%rax,	-336(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1846
	jmp	end1848
then1846:
	pushq	-328(%rbp)
	movq	-528(%rbp),	%rax
	popq	144(%rax)
	pushq	-312(%rbp)
	movq	-528(%rbp),	%rax
	popq	136(%rax)
	pushq	-296(%rbp)
	movq	-528(%rbp),	%rax
	popq	128(%rax)
	pushq	-280(%rbp)
	movq	-528(%rbp),	%rax
	popq	120(%rax)
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$19,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	144(%rax),	%rax
	movq	%rax,	-328(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	136(%rax),	%rax
	movq	%rax,	-312(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	128(%rax),	%rax
	movq	%rax,	-296(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	120(%rax),	%rax
	movq	%rax,	-280(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1848:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-344(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-344(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-344(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-344(%rbp),	%rax
	movq	%rax,	-352(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1849
	jmp	end1851
then1849:
	pushq	-344(%rbp)
	movq	-528(%rbp),	%rax
	popq	152(%rax)
	pushq	-328(%rbp)
	movq	-528(%rbp),	%rax
	popq	144(%rax)
	pushq	-312(%rbp)
	movq	-528(%rbp),	%rax
	popq	136(%rax)
	pushq	-296(%rbp)
	movq	-528(%rbp),	%rax
	popq	128(%rax)
	pushq	-280(%rbp)
	movq	-528(%rbp),	%rax
	popq	120(%rax)
	pushq	-264(%rbp)
	movq	-528(%rbp),	%rax
	popq	112(%rax)
	pushq	-248(%rbp)
	movq	-528(%rbp),	%rax
	popq	104(%rax)
	pushq	-232(%rbp)
	movq	-528(%rbp),	%rax
	popq	96(%rax)
	pushq	-216(%rbp)
	movq	-528(%rbp),	%rax
	popq	88(%rax)
	pushq	-200(%rbp)
	movq	-528(%rbp),	%rax
	popq	80(%rax)
	pushq	-184(%rbp)
	movq	-528(%rbp),	%rax
	popq	72(%rax)
	pushq	-168(%rbp)
	movq	-528(%rbp),	%rax
	popq	64(%rax)
	pushq	-152(%rbp)
	movq	-528(%rbp),	%rax
	popq	56(%rax)
	pushq	-136(%rbp)
	movq	-528(%rbp),	%rax
	popq	48(%rax)
	pushq	-120(%rbp)
	movq	-528(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-528(%rbp),	%rax
	popq	32(%rax)
	pushq	-88(%rbp)
	movq	-528(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-528(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-528(%rbp),	%rax
	popq	8(%rax)
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$20,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-528(%rbp)
	popq	%rax
	movq	152(%rax),	%rax
	movq	%rax,	-344(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	144(%rax),	%rax
	movq	%rax,	-328(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	136(%rax),	%rax
	movq	%rax,	-312(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	128(%rax),	%rax
	movq	%rax,	-296(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	120(%rax),	%rax
	movq	%rax,	-280(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	112(%rax),	%rax
	movq	%rax,	-264(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-248(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-232(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-216(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-200(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-184(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-88(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-528(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1851:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$1,	8(%rbx)
	movq	%rbx,	%rbx
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-360(%rbp)
	pushq	-64(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-368(%rbp)
	pushq	-80(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-376(%rbp)
	pushq	-96(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-384(%rbp)
	pushq	-112(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-392(%rbp)
	pushq	-128(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-400(%rbp)
	pushq	-144(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-408(%rbp)
	pushq	-160(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-416(%rbp)
	pushq	-176(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-424(%rbp)
	pushq	-192(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-432(%rbp)
	pushq	-208(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-440(%rbp)
	pushq	-224(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-448(%rbp)
	pushq	-240(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-456(%rbp)
	pushq	-256(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-464(%rbp)
	pushq	-272(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-472(%rbp)
	pushq	-288(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-480(%rbp)
	pushq	-304(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-488(%rbp)
	pushq	-320(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-496(%rbp)
	pushq	-336(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-504(%rbp)
	pushq	-352(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-512(%rbp)
	movq	8(%rbx),	%rax
	movq	%rax,	-520(%rbp)
	movq	$21,	%rbx
	addq	-520(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-512(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-504(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-496(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-488(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-480(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-472(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-464(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-456(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-448(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-440(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-432(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-424(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-416(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-408(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-400(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-392(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-384(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-376(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-368(%rbp),	%rbx
	movq	%rbx,	%rbx
	addq	-360(%rbp),	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$1184,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

