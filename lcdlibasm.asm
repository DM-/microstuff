	.file	"lcdlib.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1

	.text
	.type	WaitLCDBusyASM, @function
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
	out 0x11,__zero_reg__
	ret
	.size	WaitLCDBusyASM, .-WaitLCDBusyASM
.global	SendCommandASM
	.type	SendCommandASM, @function
SendCommandASM:
	rcall WaitLCDBusyASM
	out 0x12,r24
	cbi 0x18,7
	cbi 0x18,6
	sbi 0x18,0
	nop
	cbi 0x18,0
	out 0x12,__zero_reg__
	ret
	.size	SendCommandASM, .-SendCommandASM
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
.global	InitLcd
	.type	InitLcd, @function
InitLcd:
	sbi 0x17,0
	sbi 0x17,7
	sbi 0x17,6
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ld r24,lo8(28)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(28)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(112)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(-128)
	rcall SendCommandASM
	ldi r18,lo8(2000)
	1: subi r18,1
	brne 1b
	rcall SendCommandASM
	ret
	.size	InitLcd, .-InitLcd
	.ident	"DM- Lin.Git"
