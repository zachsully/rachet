	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$40,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$0,	%rax
	cmpq	$1,	%rax
	je	then1272
	movq	$0,	%rbx
	jmp	end1274
then1272:
	callq	read_int
	movq	%rax,	%rbx
	movq	$42,	%rax
	cmpq	%rbx,	%rax
	sete	%al
	movzbq	%al,	%rbx
	movq	%rbx,	%rbx
end1274:
	cmpq	$1,	%rbx
	je	then1275
	movq	$42,	%rbx
	jmp	end1277
then1275:
	movq	$777,	%rbx
end1277:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$40,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

