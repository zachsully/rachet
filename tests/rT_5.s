	.globl const.1145
const.1145:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$40,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-88(%rbp)
	movq	%rsi,	%rbx
	movq	%rdx,	%rdx
	movq	%rcx,	%rbx
	movq	%rdx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$40,	%rsp
	popq	%rbp
	retq

	.globl id.1146
id.1146:
	pushq	%rbp
	movq	%rsp,	%rbp
	subq	$32,	%rsp
	pushq	%rbx
	pushq	%r12
	pushq	%r13
	pushq	%r14
	pushq	%r15
	movq	%rdi,	-88(%rbp)
	movq	%rsi,	%rcx
	movq	%rdx,	%rbx
	movq	%rcx,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	addq	$32,	%rsp
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
	subq	$400,	%rsp
	movq	$65536,	%rdi
	movq	$65536,	%rsi
	callq	initialize
	movq	rootstack_begin(%rip),	%rax
	movq	%rax,	-88(%rbp)
	leaq	const.1145(%rip),	%rbx
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1206
	jmp	end1208
then1206:
	movq	-88(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1208:
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
	leaq	const.1145(%rip),	%rax
	movq	%rax,	-96(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1209
	jmp	end1211
then1209:
	pushq	-48(%rbp)
	movq	-88(%rbp),	%rax
	popq	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-48(%rbp)
end1211:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-96(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	%rcx,	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-64(%rbp)
	movq	-88(%rbp),	%rdi
	movq	$0,	%rsi
	movq	$1,	%rdx
	movq	%rcx,	%rcx
	movq	-64(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	cmpq	$1,	%rcx
	je	then1212
	leaq	const.1145(%rip),	%rax
	movq	%rax,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1215
	jmp	end1217
then1215:
	movq	-88(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1217:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-64(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-64(%rbp),	%rax
	movq	$3,	0(%rax)
	pushq	-48(%rbp)
	movq	-64(%rbp),	%rax
	popq	8(%rax)
	movq	-64(%rbp),	%rax
	movq	%rax,	-48(%rbp)
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-72(%rbp)
	leaq	const.1145(%rip),	%rax
	movq	%rax,	-96(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1218
	jmp	end1220
then1218:
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-64(%rbp)
end1220:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-96(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	%rcx,	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-80(%rbp)
	movq	-88(%rbp),	%rdi
	movq	$1,	%rsi
	movq	$0,	%rdx
	movq	%rcx,	%rcx
	movq	-80(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	movq	-88(%rbp),	%rdi
	movq	%rcx,	%rsi
	movq	$777,	%rdx
	movq	-48(%rbp),	%rcx
	movq	-72(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	movq	%rcx,	%rcx
	jmp	end1214
then1212:
	leaq	const.1145(%rip),	%rax
	movq	%rax,	-48(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1221
	jmp	end1223
then1221:
	movq	-88(%rbp),	%rcx
	addq	$0,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
end1223:
	movq	free_ptr(%rip),	%rax
	movq	%rax,	-64(%rbp)
	addq	$16,	free_ptr(%rip)
	movq	-64(%rbp),	%rax
	movq	$3,	0(%rax)
	pushq	-48(%rbp)
	movq	-64(%rbp),	%rax
	popq	8(%rax)
	movq	-64(%rbp),	%rax
	movq	%rax,	-48(%rbp)
	pushq	-48(%rbp)
	popq	%rax
	movq	8(%rax),	%rax
	movq	%rax,	-72(%rbp)
	leaq	id.1146(%rip),	%rax
	movq	%rax,	-96(%rbp)
	movq	free_ptr(%rip),	%rcx
	addq	$16,	%rcx
	cmpq	fromspace_end(%rip),	%rcx
	setl	%al
	movzbq	%al,	%rcx
	cmpq	$0,	%rcx
	je	then1224
	jmp	end1226
then1224:
	pushq	-64(%rbp)
	movq	-88(%rbp),	%rax
	popq	0(%rax)
	movq	-88(%rbp),	%rcx
	addq	$1,	%rcx
	movq	%rcx,	%rdi
	movq	$16,	%rsi
	callq	collect
	pushq	-88(%rbp)
	popq	%rax
	movq	0(%rax),	%rax
	movq	%rax,	-64(%rbp)
end1226:
	movq	free_ptr(%rip),	%rcx
	addq	$16,	free_ptr(%rip)
	movq	$3,	0(%rcx)
	movq	-96(%rbp),	%rax
	movq	%rax,	8(%rcx)
	movq	%rcx,	%rcx
	movq	8(%rcx),	%rax
	movq	%rax,	-80(%rbp)
	movq	-88(%rbp),	%rdi
	movq	$42,	%rsi
	movq	%rcx,	%rdx
	movq	-80(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	movq	-88(%rbp),	%rdi
	movq	$0,	%rsi
	movq	%rcx,	%rdx
	movq	-48(%rbp),	%rcx
	movq	-72(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rcx
	movq	%rcx,	%rcx
end1214:
	movq	-88(%rbp),	%rdi
	movq	$0,	%rsi
	movq	%rcx,	%rdx
	movq	%rbx,	%rcx
	movq	-56(%rbp),	%rax
	callq	*%rax
	movq	%rax,	%rbx
	movq	%rbx,	%rax
	movq	%rax,	%rdi
	callq	print_int
	addq	$400,	%rsp
	movq	$0,	%rax
	popq	%r15
	popq	%r14
	popq	%r13
	popq	%r12
	popq	%rbx
	popq	%rbp
	retq

