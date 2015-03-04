	.globl	_dwordMfcRaw
	.align	4
	.code	16                      @ @dwordMfcRaw
	.thumb_func	_dwordMfcRaw


_dwordMfcRaw:
    push   {r7, lr}
    movs   r3, #0x0
    mov    r7, sp
    cmp.w  r3, r1, lsr #2
    it     eq
    popeq  {r7, pc}
    lsr.w  r9, r1, #0x2
LreadNewDword:
    ldr.w  lr, [r0, r3, lsl #2]
    adds   r3, #0x1
    cmp    r3, r9
    uxtb.w r12, lr
    ldr.w  r1, [r2, r12, lsl #2]
    add.w  r1, r1, #0x1
    str.w  r1, [r2, r12, lsl #2]
    ubfx   r12, lr, #0x8, #0x8
    ldr.w  r1, [r2, r12, lsl #2]
    add.w  r1, r1, #0x1
    str.w  r1, [r2, r12, lsl #2]
    ubfx   r12, lr, #0x10, #0x8
    ldr.w  r1, [r2, r12, lsl #2]
    add.w  r1, r1, #0x1
    str.w  r1, [r2, r12, lsl #2]
    lsr.w  r12, lr, #0x18
    ldr.w  r1, [r2, r12, lsl #2]
    add.w  r1, r1, #0x1
    str.w  r1, [r2, r12, lsl #2]
    blo    LreadNewDword
    pop    {r7, pc}
