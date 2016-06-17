	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$48,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rbx
	movq	$42,	%rbx
	movq	$42,	%rax
	cmpq	%rbx,	%rax
	sete	%al
	movzbq	%al,	%rcx
	cmpq	$1,	%rcx
	je	then1252
	movq	$20,	%rbx
	jmp	end1254
then1252:
	movq	%rbx,	%rbx
end1254:
	movq	$42,	%rax
	cmpq	%rbx,	%rax
	sete	%al
	movzbq	%al,	%rbx
	cmpq	$1,	%rbx
	je	then1255
	movq	$777,	%rbx
	jmp	end1257
then1255:
	movq	$42,	%rbx
end1257:
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$48,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

