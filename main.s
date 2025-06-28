	.file	"main.cpp"
	.text
	.p2align 4
	.globl	_Z4fun1PfS_PhS_mm
	.type	_Z4fun1PfS_PhS_mm, @function
_Z4fun1PfS_PhS_mm:
.LFB6710:
	.cfi_startproc
	endbr64
	shrq	%r9
	testq	%r8, %r8
	je	.L4
	addq	%rdx, %r9
	vxorps	%xmm2, %xmm2, %xmm2
	vpxor	%xmm5, %xmm5, %xmm5
	xorl	%eax, %eax
	movabsq	$1085102592571150095, %rdx
	vmovdqa	.LC1(%rip), %xmm4
	vmovq	%rdx, %xmm3
	vpunpcklqdq	%xmm3, %xmm3, %xmm3
	.p2align 4,,10
	.p2align 3
.L3:
	movq	%rax, %rdx
	vmovups	(%rcx,%rax,4), %ymm7
	shrq	%rdx
	vmovd	(%r9,%rdx), %xmm6
	vpshufd	$0, %xmm6, %xmm0
	vpsrld	$4, %xmm0, %xmm1
	vpand	%xmm3, %xmm0, %xmm0
	vpand	%xmm3, %xmm1, %xmm1
	vpshufb	%xmm4, %xmm0, %xmm0
	vpshufb	%xmm4, %xmm1, %xmm1
	vpunpcklbw	%xmm0, %xmm1, %xmm1
	vpmovzxbw	%xmm1, %xmm0
	vpunpckhbw	%xmm5, %xmm1, %xmm1
	vpmovzxwd	%xmm0, %xmm0
	vpmovzxwd	%xmm1, %xmm1
	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vfmsub132ps	(%rdi,%rax,4), %ymm7, %ymm0
	vaddps	(%rsi,%rax,4), %ymm0, %ymm0
	addq	$8, %rax
	vfmadd231ps	%ymm0, %ymm0, %ymm2
	cmpq	%r8, %rax
	jb	.L3
.L2:
	vextractf128	$0x1, %ymm2, %xmm1
	vaddps	%xmm1, %xmm2, %xmm0
	vhaddps	%xmm0, %xmm0, %xmm0
	vhaddps	%xmm0, %xmm0, %xmm0
	vzeroupper
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	vxorps	%xmm2, %xmm2, %xmm2
	jmp	.L2
	.cfi_endproc
.LFE6710:
	.size	_Z4fun1PfS_PhS_mm, .-_Z4fun1PfS_PhS_mm
	.p2align 4
	.globl	_Z4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEm
	.type	_Z4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEm, @function
_Z4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEm:
.LFB6711:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	shrq	$2, %rsi
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movq	%rsi, %r15
	pushq	%r14
	.cfi_offset 14, -32
	movq	%rcx, %r14
	pushq	%r13
	.cfi_offset 13, -40
	movq	%r8, %r13
	pushq	%r12
	.cfi_offset 12, -48
	movq	%rdx, %r12
	pushq	%rbx
	movzbl	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts(%rip), %eax
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	andq	$-32, %rsp
	testb	%al, %al
	je	.L25
.L9:
	movzbl	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip), %eax
	testb	%al, %al
	je	.L26
.L12:
	testq	%r13, %r13
	je	.L16
.L27:
	vmovdqa	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts(%rip), %ymm5
	vmovdqa	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip), %ymm4
	xorl	%ecx, %ecx
	vxorps	%xmm1, %xmm1, %xmm1
	.p2align 4,,10
	.p2align 3
.L15:
	movq	%rcx, %rdx
	shrq	$2, %rdx
	leaq	(%r15,%rdx), %rax
	salq	$8, %rdx
	shrq	%rax
	leaq	(%r14,%rax,4), %rsi
	movzbl	3(%rsi), %eax
	movzbl	2(%rsi), %edi
	addq	%rdx, %rax
	leaq	256(%rdx,%rdi), %rdx
	salq	$5, %rax
	salq	$5, %rdx
	vmovaps	(%r12,%rax), %xmm2
	vmovaps	16(%r12,%rax), %xmm3
	movzwl	(%rsi), %eax
	vinsertf128	$0x1, (%r12,%rdx), %ymm2, %ymm2
	vinsertf128	$0x1, 16(%r12,%rdx), %ymm3, %ymm3
	vmovd	%eax, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpsrlvd	%ymm5, %ymm0, %ymm0
	vpand	%ymm0, %ymm4, %ymm0
	vcvtdq2ps	%ymm0, %ymm0
	vfmadd132ps	%ymm3, %ymm2, %ymm0
	vsubps	(%rbx,%rcx,4), %ymm0, %ymm0
	addq	$8, %rcx
	vfmadd231ps	%ymm0, %ymm0, %ymm1
	cmpq	%r13, %rcx
	jb	.L15
.L14:
	vextractf128	$0x1, %ymm1, %xmm0
	vaddps	%xmm1, %xmm0, %xmm0
	vhaddps	%xmm0, %xmm0, %xmm0
	vhaddps	%xmm0, %xmm0, %xmm0
	vzeroupper
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L25:
	.cfi_restore_state
	leaq	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts(%rip), %rdi
	call	__cxa_guard_acquire@PLT
	leaq	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts(%rip), %rdi
	testl	%eax, %eax
	je	.L9
	vmovdqa	.LC2(%rip), %ymm0
	vmovdqa	%ymm0, _ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts(%rip)
	vzeroupper
	call	__cxa_guard_release@PLT
	movzbl	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip), %eax
	testb	%al, %al
	jne	.L12
	.p2align 4,,10
	.p2align 3
.L26:
	leaq	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip), %rdi
	call	__cxa_guard_acquire@PLT
	leaq	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip), %rdi
	testl	%eax, %eax
	je	.L12
	movabsq	$12884901891, %rax
	vmovq	%rax, %xmm0
	vpbroadcastq	%xmm0, %ymm0
	vmovdqa	%ymm0, _ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask(%rip)
	vzeroupper
	call	__cxa_guard_release@PLT
	testq	%r13, %r13
	jne	.L27
	.p2align 4,,10
	.p2align 3
.L16:
	vxorps	%xmm1, %xmm1, %xmm1
	jmp	.L14
	.cfi_endproc
.LFE6711:
	.size	_Z4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEm, .-_Z4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEm
	.local	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask
	.comm	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask,8,8
	.local	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask
	.comm	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE4mask,32,32
	.local	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts
	.comm	_ZGVZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts,8,8
	.local	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts
	.comm	_ZZ4fun2PKfmP20ReconstructParameterPSt5tupleIJhhtEEmE6shifts,32,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.byte	0
	.byte	4
	.byte	8
	.byte	12
	.byte	1
	.byte	5
	.byte	9
	.byte	13
	.byte	2
	.byte	6
	.byte	10
	.byte	14
	.byte	3
	.byte	7
	.byte	11
	.byte	15
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC2:
	.quad	8589934592
	.quad	25769803780
	.quad	42949672968
	.quad	60129542156
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
