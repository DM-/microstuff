.include "liblcdcom.asm"
.global InitPWMASM
	.type InitPWMASM, @function
InitPWMASM:
	sbi 0x17, 1
	ldi r24, 0x81
	out 0x2f, r24
	ldi r24, 0x09
	out 0x2e, r24
	ret
	.size InitPWMASM, .-InitPWMASM