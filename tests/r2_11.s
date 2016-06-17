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
	movq	$0,	%rbx
	xorq	$1,	%rbx
	cmpq	$1,	%rbx
	je	then1215
	movq	$1,	%rbx
	jmp	end1217
then1215:
	movq	$0,	%rbx
end1217:
	cmpq	$1,	%rbx
	je	then1218
	movq	$42,	%rbx
	jmp	end1220
then1218:
	movq	$777,	%rbx
end1220:
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

