	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$16,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$1,	%rax
	cmpq	$1,	%rax
	je	then1190
	movq	$0,	%rbx
	jmp	end1192
then1190:
	movq	$42,	%rbx
end1192:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$16,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

