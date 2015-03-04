	.globl	_naiveMfc
	.align	4
	.code	16                      @ @naiveMfc
	.thumb_func	_naiveMfc

_naiveMfc:
    cmp    r1, #0x0
    it     eq
    bxeq   lr
LreadNewByte:
    ldrb   r9, [r0], #1
    subs   r1, #0x1
    ldr.w  r3, [r2, r9, lsl #2]
    add.w  r3, r3, #0x1
    str.w  r3, [r2, r9, lsl #2]
    bne    LreadNewByte
    bx     lr
