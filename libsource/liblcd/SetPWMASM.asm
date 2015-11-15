.include "liblcdcom.asm"
.global SetPWMASM
	.type SetPWMASM, @function
SetPWMASM:
	out 0x2a, r24
	ret
	.size SetPWMASM, .-SetPWMASM