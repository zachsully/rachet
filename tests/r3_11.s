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
	je	then1557
	jmp	end1559
then1557:
	movq	-528(%rbp),	%rbx
	addq	$0,	%rbx
	movq	%rbx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1559:
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
	je	then1560
	jmp	end1562
then1560:
	movq	-528(%rbp),	%rax
	movq	%rbx,	0(%rax)
	movq	-528(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	movq	-528(%rbp),	%rax
	movq	0(%rax),	%rbx
end1562:
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
	je	then1563
	jmp	end1565
then1563:
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
end1565:
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
	je	then1566
	jmp	end1568
then1566:
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
end1568:
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
	je	then1569
	jmp	end1571
then1569:
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
end1571:
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
	je	then1572
	jmp	end1574
then1572:
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
end1574:
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
	je	then1575
	jmp	end1577
then1575:
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
end1577:
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
	je	then1578
	jmp	end1580
then1578:
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
end1580:
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
	je	then1581
	jmp	end1583
then1581:
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
end1583:
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
	je	then1584
	jmp	end1586
then1584:
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
end1586:
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
	je	then1587
	jmp	end1589
then1587:
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
end1589:
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
	je	then1590
	jmp	end1592
then1590:
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
end1592:
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
	je	then1593
	jmp	end1595
then1593:
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
end1595:
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
	je	then1596
	jmp	end1598
then1596:
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
end1598:
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
	je	then1599
	jmp	end1601
then1599:
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
end1601:
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
	je	then1602
	jmp	end1604
then1602:
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
end1604:
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
	je	then1605
	jmp	end1607
then1605:
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
end1607:
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
	je	then1608
	jmp	end1610
then1608:
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
end1610:
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
	je	then1611
	jmp	end1613
then1611:
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
end1613:
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
	je	then1614
	jmp	end1616
then1614:
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
end1616:
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
	je	then1617
	jmp	end1619
then1617:
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
end1619:
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

