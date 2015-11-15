.include "liblcdcom.asm"
.global WaitLCDBusyASM
	.type WaitLCDBusyASM, @function
WaitLCDBusyASM:
	out 0x11,__zero_reg__
	out 0x12,__zero_reg__
	cbi 0x18,7
	sbi 0x18,6
.L2:
	sbi 0x18,0
	nop
	cbi 0x18,0
	sbic 0x10,0
	rjmp .L2
	ldi r25,0xFF
	out 0x11,r25 ; I hav no idea why ser 0x11 doesnt work. Wtf?
	ret
	.size	WaitLCDBusyASM, .-WaitLCDBusyASM