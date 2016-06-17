	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$32,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$1,	%rbx
	xorq	$1,	%rbx
	cmpq	$1,	%rbx
	je	then1225
	movq	$1,	%rbx
	jmp	end1227
then1225:
	movq	$0,	%rbx
end1227:
	cmpq	$1,	%rbx
	je	then1228
	movq	$777,	%rbx
	jmp	end1230
then1228:
	movq	$42,	%rbx
end1230:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$32,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

