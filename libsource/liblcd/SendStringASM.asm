.include "liblcdcom.asm"
.global SendStringASM
	.type SendStringASM, @function
SendStringASM:
	movw r26, r24
	1: ld r24, X+
	tst r24
	breq 2f
	rcall SendCharacterASM
	rjmp 1b
	2:ret
	.size SendStringASM, .-SendStringASM