	.globl	_qwordMfc
	.align	4
	.code	16                      @ @qwordMfc
	.thumb_func	_qwordMfc

_qwordMfc:
    push   {r7, lr}
    mov    r7, sp
    str    r8, [sp, #-4]!
    mov.w  lr, #0x0
    cmp.w  lr, r1, lsr #3
    beq    Lended
    lsr.w  r12, r1, #0x3
LreadNewQword:
    ldrd   r8, r9, [r0]
    add.w  lr, lr, #0x1
    adds   r0, #0x8
    cmp    lr, r12
    uxtb.w r1, r8
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    ubfx   r1, r8, #0x8, #0x8
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    ubfx   r1, r8, #0x10, #0x8
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    lsr.w  r1, r8, #0x18
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    uxtb.w r1, r9
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    ubfx   r1, r9, #0x8, #0x8
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    ubfx   r1, r9, #0x10, #0x8
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    lsr.w  r1, r9, #0x18
    ldr.w  r3, [r2, r1, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r1, lsl #2]
    blo    LreadNewQword
Lended:
    ldr    r8, [sp], #4
    pop    {r7, pc}
