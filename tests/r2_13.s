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
	movq	$1,	%rbx
	cmpq	$1,	%rbx
	je	then1237
	movq	$0,	%rbx
	jmp	end1239
then1237:
	movq	%rbx,	%rbx
end1239:
	cmpq	$1,	%rbx
	je	then1240
	movq	$0,	%rbx
	jmp	end1242
then1240:
	movq	$1,	%rbx
end1242:
	movq	%rbx,	%rbx
	cmpq	$1,	%rbx
	je	then1243
	movq	$777,	%rbx
	jmp	end1245
then1243:
	movq	$42,	%rbx
end1245:
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

