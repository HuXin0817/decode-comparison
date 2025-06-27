	.file	"main.c"
	.text
	.p2align 4
	.globl	uq4decode
	.type	uq4decode, @function
uq4decode:
.LFB5284:
	.cfi_startproc
	endbr64
	vmovq	(%rdx), %xmm0
	vpand	.LC0(%rip), %xmm0, %xmm1
	vpand	.LC1(%rip), %xmm0, %xmm0
	vmovups	(%rdi), %xmm3
	vpsrlw	$4, %xmm1, %xmm1
	vinsertf128	$0x1, 16(%rdi), %ymm3, %ymm2
	vmovups	(%rsi), %xmm4
	vpunpcklbw	%xmm0, %xmm1, %xmm1
	vpmovzxbd	%xmm1, %xmm0
	vpsrldq	$4, %xmm1, %xmm1
	vpmovzxbd	%xmm1, %xmm1
	vinserti128	$0x1, %xmm1, %ymm0, %ymm0
	vinsertf128	$0x1, 16(%rsi), %ymm4, %ymm1
	vcvtdq2ps	%ymm0, %ymm0
	vfmadd132ps	%ymm2, %ymm1, %ymm0
	vmovups	%xmm0, (%rcx)
	vextractf128	$0x1, %ymm0, 16(%rcx)
	vzeroupper
	ret
	.cfi_endproc
.LFE5284:
	.size	uq4decode, .-uq4decode
	.p2align 4
	.globl	uq8decode
	.type	uq8decode, @function
uq8decode:
.LFB5285:
	.cfi_startproc
	endbr64
	vpmovzxbd	(%rdx), %ymm0
	vmovups	(%rdi), %xmm3
	vmovups	(%rsi), %xmm4
	vinsertf128	$0x1, 16(%rdi), %ymm3, %ymm2
	vinsertf128	$0x1, 16(%rsi), %ymm4, %ymm1
	vcvtdq2ps	%ymm0, %ymm0
	vfmadd132ps	%ymm2, %ymm1, %ymm0
	vmovups	%xmm0, (%rcx)
	vextractf128	$0x1, %ymm0, 16(%rcx)
	vzeroupper
	ret
	.cfi_endproc
.LFE5285:
	.size	uq8decode, .-uq8decode
	.p2align 4
	.globl	pouq4decode
	.type	pouq4decode, @function
pouq4decode:
.LFB5286:
	.cfi_startproc
	endbr64
	vpmovzxbd	(%rdx), %xmm2
	vmovdqa	.LC2(%rip), %xmm0
	vpsrld	$6, %xmm2, %xmm5
	vpsrld	$2, %xmm2, %xmm4
	vpand	%xmm0, %xmm4, %xmm3
	vpand	%xmm0, %xmm5, %xmm4
	vpunpckldq	%xmm3, %xmm4, %xmm1
	vpunpckhdq	%xmm3, %xmm4, %xmm4
	vpsrld	$4, %xmm2, %xmm3
	vpand	%xmm0, %xmm2, %xmm2
	vinserti128	$0x1, %xmm4, %ymm1, %ymm1
	vpand	%xmm0, %xmm3, %xmm3
	vpaddd	.LC3(%rip), %ymm1, %ymm1
	vpunpckldq	%xmm2, %xmm3, %xmm0
	vpunpckhdq	%xmm2, %xmm3, %xmm2
	vinserti128	$0x1, %xmm2, %ymm0, %ymm0
	vxorps	%xmm2, %xmm2, %xmm2
	vcmpps	$0, %ymm2, %ymm2, %ymm2
	vcvtdq2ps	%ymm0, %ymm0
	vmovaps	%ymm2, %ymm6
	vgatherdps	%ymm2, (%rsi,%ymm1,4), %ymm4
	vgatherdps	%ymm6, (%rdi,%ymm1,4), %ymm3
	vfmadd132ps	%ymm4, %ymm3, %ymm0
	vmovups	%xmm0, (%rcx)
	vextractf128	$0x1, %ymm0, 16(%rcx)
	vzeroupper
	ret
	.cfi_endproc
.LFE5286:
	.size	pouq4decode, .-pouq4decode
	.p2align 4
	.globl	pouq8decode
	.type	pouq8decode, @function
pouq8decode:
.LFB5287:
	.cfi_startproc
	endbr64
	vxorps	%xmm2, %xmm2, %xmm2
	vpmovzxbd	(%rdx), %ymm1
	vpand	.LC5(%rip), %ymm1, %ymm0
	vcmpps	$0, %ymm2, %ymm2, %ymm2
	vpsrld	$4, %ymm1, %ymm3
	vpaddd	.LC4(%rip), %ymm3, %ymm3
	vcvtdq2ps	%ymm0, %ymm0
	vmovaps	%ymm2, %ymm6
	vgatherdps	%ymm2, (%rsi,%ymm3,4), %ymm5
	vgatherdps	%ymm6, (%rdi,%ymm3,4), %ymm4
	vfmadd132ps	%ymm5, %ymm4, %ymm0
	vmovups	%xmm0, (%rcx)
	vextractf128	$0x1, %ymm0, 16(%rcx)
	vzeroupper
	ret
	.cfi_endproc
.LFE5287:
	.size	pouq8decode, .-pouq8decode
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	-1085102592571150096
	.quad	-1085102592571150096
	.align 16
.LC1:
	.quad	1085102592571150095
	.quad	1085102592571150095
	.align 16
.LC2:
	.quad	12884901891
	.quad	12884901891
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC3:
	.long	0
	.long	0
	.long	4
	.long	4
	.long	8
	.long	8
	.long	12
	.long	12
	.align 32
.LC4:
	.long	0
	.long	16
	.long	32
	.long	48
	.long	64
	.long	80
	.long	96
	.long	112
	.align 32
.LC5:
	.quad	64424509455
	.quad	64424509455
	.quad	64424509455
	.quad	64424509455
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
