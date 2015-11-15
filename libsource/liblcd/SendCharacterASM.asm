.include "liblcdcom.asm"
.global	SendCharacterASM
	.type	SendCharacterASM, @function
SendCharacterASM:
	rcall WaitLCDBusyASM
	out 0x12,r24
	sbi 0x18,7
	cbi 0x18,6
	sbi 0x18,0
	nop
	cbi 0x18,0
	out 0x12,__zero_reg__
	ret
	.size	SendCharacterASM, .-SendCharacterASM