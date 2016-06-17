	.globl add1.1227
add1.1227:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
	movq	%rsi,	%rcx
	movq	%rdx,	%rbx
	movq	%rcx,	%rbx
	addq	$1,	%rbx
	movq	%rbx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$32,	%rsp
	popq	%rbp
	retq

	.globl fmapVec1.1228
fmapVec1.1228:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$40,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-72(%rbp)
	movq	%rsi,	%rsi
	movq	%rdx,	%rdx
	movq	%rcx,	%rbx
	movq	%rdx,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-48(%rbp)
	movq	8(%rsi),	%rcx
	movq	-72(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	%rbx,	%rdx
	movq	-48(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1264
	jmp	end1266
then1264:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1266:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	%rbx,	8(%rcx)
	movq	%rcx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$40,	%rsp
	popq	%rbp
	retq

	.globl main
main:
	pushq	%rbp
	movq	%rsp,	%rbp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	subq	$152,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-72(%rbp)
	leaq	fmapVec1.1228(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1267
	jmp	end1269
then1267:
	movq	-72(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1269:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-48(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-48(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-48(%rbp),	%rax
	movq	%rbx,	8(%rax)
	movq	-48(%rbp),	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-56(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1270
	jmp	end1272
then1270:
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end1272:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-80(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-80(%rbp),	%rax
	movq	$3,	0(%rax)
	movq	-80(%rbp),	%rax
	movq	$41,	8(%rax)
	leaq	add1.1227(%rip),	%rax
	movq	%rax,	-88(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1273
	jmp	end1275
then1273:
	pushq	-80(%rbp)
	movq	-72(%rbp),	%rax
	popq	8(%rax)
	pushq	-48(%rbp)
	movq	-72(%rbp),	%rax
	popq	0(%rax)
	movq	-72(%rbp),	%rcx
	addq	$2,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-72(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-80(%rbp)
	pushq	-72(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end1275:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-88(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	-72(%rbp),	%rdi
	movq	-80(%rbp),	%rsi
	movq	%rcx,	%rdx
	movq	%rbx,	%rcx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	8(%rbx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-64(%rbp),	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$152,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

