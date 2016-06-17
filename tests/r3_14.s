	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$624,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-88(%rbp)
	movq	free_ptr(%rip),	%rbx
	addq	$16,	%rbx
	cmpq	fromspace_end(%rip),	%rbx
	setl	%al
	movzbq	%al,	%rbx
	cmpq	$0,	%rbx
	je	then2061
	jmp	end2063
then2061:
	movq	-88(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end2063:
	movq	free_ptr(%rip),	%rbx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rbx)
	movq	$20,	8(%rbx)
	movq	%rbx,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2064
	jmp	end2066
then2064:
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2066:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-56(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-56(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-56(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-56(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-56(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-56(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-56(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-56(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2067
	jmp	end2069
then2067:
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2069:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-72(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-72(%rbp),	%rax
	movq	$2059,	0(%rax)
	pushq	-64(%rbp)
	movq	-72(%rbp),	%rax
	popq	8(%rax)
	movq	-72(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-72(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-72(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-72(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-72(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2070
	jmp	end2072
then2070:
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$3,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2072:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-96(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-96(%rbp),	%rax
	movq	$1035,	0(%rax)
	movq	-96(%rbp),	%rax
	movq	$1,	8(%rax)
	pushq	-64(%rbp)
	movq	-96(%rbp),	%rax
	popq	16(%rax)
	movq	-96(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-96(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-96(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-96(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2073
	jmp	end2075
then2073:
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$4,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2075:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-104(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-104(%rbp),	%rax
	movq	$523,	0(%rax)
	movq	-104(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-104(%rbp),	%rax
	movq	$2,	16(%rax)
	pushq	-64(%rbp)
	movq	-104(%rbp),	%rax
	popq	24(%rax)
	movq	-104(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-104(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-104(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2076
	jmp	end2078
then2076:
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$5,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2078:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-112(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-112(%rbp),	%rax
	movq	$267,	0(%rax)
	movq	-112(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-112(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-112(%rbp),	%rax
	movq	$3,	24(%rax)
	pushq	-64(%rbp)
	movq	-112(%rbp),	%rax
	popq	32(%rax)
	movq	-112(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-112(%rbp),	%rax
	movq	%rax,	-64(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2079
	jmp	end2081
then2079:
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$6,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2081:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-120(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-120(%rbp),	%rax
	movq	$139,	0(%rax)
	movq	-120(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-120(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-120(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-120(%rbp),	%rax
	movq	$4,	32(%rax)
	pushq	-64(%rbp)
	movq	-120(%rbp),	%rax
	popq	40(%rax)
	movq	-120(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2082
	jmp	end2084
then2082:
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$7,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2084:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-64(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-64(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-64(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-64(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-64(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-64(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-64(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-64(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2085
	jmp	end2087
then2085:
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$8,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2087:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-128(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-128(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-128(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-128(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-128(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-128(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-128(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-128(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2088
	jmp	end2090
then2088:
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$9,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2090:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-136(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-136(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-136(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-136(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-136(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-136(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-136(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-136(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2091
	jmp	end2093
then2091:
	pushq	-136(%rbp)
	movq	-88(%rbp),	%rax
	popq	72(%rax)
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$10,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2093:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-144(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-144(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-144(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-144(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-144(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-144(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-144(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-144(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2094
	jmp	end2096
then2094:
	pushq	-144(%rbp)
	movq	-88(%rbp),	%rax
	popq	80(%rax)
	pushq	-136(%rbp)
	movq	-88(%rbp),	%rax
	popq	72(%rax)
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$11,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-144(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2096:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-152(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-152(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-152(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-152(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-152(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-152(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-152(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-152(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2097
	jmp	end2099
then2097:
	pushq	-152(%rbp)
	movq	-88(%rbp),	%rax
	popq	88(%rax)
	pushq	-144(%rbp)
	movq	-88(%rbp),	%rax
	popq	80(%rax)
	pushq	-136(%rbp)
	movq	-88(%rbp),	%rax
	popq	72(%rax)
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$12,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-144(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2099:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-160(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-160(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-160(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-160(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-160(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-160(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-160(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-160(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2100
	jmp	end2102
then2100:
	pushq	-160(%rbp)
	movq	-88(%rbp),	%rax
	popq	96(%rax)
	pushq	-152(%rbp)
	movq	-88(%rbp),	%rax
	popq	88(%rax)
	pushq	-144(%rbp)
	movq	-88(%rbp),	%rax
	popq	80(%rax)
	pushq	-136(%rbp)
	movq	-88(%rbp),	%rax
	popq	72(%rax)
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$13,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-160(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-144(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2102:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-168(%rbp)
	addq	$48,	free_ptr(%rip)
	movq	-168(%rbp),	%rax
	movq	$11,	0(%rax)
	movq	-168(%rbp),	%rax
	movq	$1,	8(%rax)
	movq	-168(%rbp),	%rax
	movq	$2,	16(%rax)
	movq	-168(%rbp),	%rax
	movq	$3,	24(%rax)
	movq	-168(%rbp),	%rax
	movq	$4,	32(%rax)
	movq	-168(%rbp),	%rax
	movq	$5,	40(%rax)
	movq	-168(%rbp),	%rcx
	movq	free_ptr(%rip),	%rcx
	addq	$48,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then2103
	jmp	end2105
then2103:
	pushq	-168(%rbp)
	movq	-88(%rbp),	%rax
	popq	104(%rax)
	pushq	-160(%rbp)
	movq	-88(%rbp),	%rax
	popq	96(%rax)
	pushq	-152(%rbp)
	movq	-88(%rbp),	%rax
	popq	88(%rax)
	pushq	-144(%rbp)
	movq	-88(%rbp),	%rax
	popq	80(%rax)
	pushq	-136(%rbp)
	movq	-88(%rbp),	%rax
	popq	72(%rax)
	pushq	-128(%rbp)
	movq	-88(%rbp),	%rax
	popq	64(%rax)
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	56(%rax)
	pushq	-120(%rbp)
	movq	-88(%rbp),	%rax
	popq	48(%rax)
	pushq	-112(%rbp)
	movq	-88(%rbp),	%rax
	popq	40(%rax)
	pushq	-104(%rbp)
	movq	-88(%rbp),	%rax
	popq	32(%rax)
	pushq	-96(%rbp)
	movq	-88(%rbp),	%rax
	popq	24(%rax)
	pushq	-72(%rbp)
	movq	-88(%rbp),	%rax
	popq	16(%rax)
	pushq	-56(%rbp)
	movq	-88(%rbp),	%rax
	popq	8(%rax)
	movq	-88(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$14,	%rcx
	movq	%rcx,	%rdi
	movq	$48,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	104(%rax),	%rax
	movq	%rax,	-168(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	96(%rax),	%rax
	movq	%rax,	-160(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	88(%rax),	%rax
	movq	%rax,	-152(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	80(%rax),	%rax
	movq	%rax,	-144(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	72(%rax),	%rax
	movq	%rax,	-136(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	64(%rax),	%rax
	movq	%rax,	-128(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	56(%rax),	%rax
	movq	%rax,	-64(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	48(%rax),	%rax
	movq	%rax,	-120(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	40(%rax),	%rax
	movq	%rax,	-112(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	32(%rax),	%rax
	movq	%rax,	-104(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	24(%rax),	%rax
	movq	%rax,	-96(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	16(%rax),	%rax
	movq	%rax,	-72(%rbp)
	pushq	-88(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-56(%rbp)
	movq	-88(%rbp),	%rax
	movq	0(%rax),	%rbx
end2105:
	movq	free_ptr(%rip),	%rbx
	addq	$48,	free_ptr(%rip)
	movq	$11,	0(%rbx)
	movq	$1,	8(%rbx)
	movq	$2,	16(%rbx)
	movq	$3,	24(%rbx)
	movq	$4,	32(%rbx)
	movq	$5,	40(%rbx)
	movq	%rbx,	%rbx
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-80(%rbp)
	movq	$22,	%rbx
	addq	-80(%rbp),	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$624,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

