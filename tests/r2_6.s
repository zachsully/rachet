	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$24,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$2,	%rax
	cmpq	$1,	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then1196
	movq	$42,	%rbx
	jmp	end1198
then1196:
	movq	$777,	%rbx
end1198:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$24,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

