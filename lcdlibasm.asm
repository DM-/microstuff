__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
; can use _SFR_IO_ADDRESS & local symbol defines to make this very portable
;	.text
.global WaitLCDBusyASM
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
	ldi r25,0xFF
	out 0x11,r25 ; I hav no idea why ser 0x11 doesnt work. Wtf?
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
.global	InitLCDASM
	.type	InitLCDASM, @function
InitLCDASM:
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
	ldi r24,lo8(0x38)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x38)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x0E)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x01)
	rcall SendCommandASM
	ldi r24,lo8(2000)
	ldi r25,hi8(2000)
	1: sbiw r24,1
	brne 1b
	ldi r24,lo8(0x06)
	rcall SendCommandASM
	ret
	.size	InitLCDASM, .-InitLCDASM
.global	InitLCDASMR
	.type	InitLCDASMR, @function
InitLCDASMR: //reversed InitLcdASM
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
	ldi r24,lo8(0x1C)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x1C)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x70)
	rcall SendCommandASM
	ldi r18,lo8(40)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x80)
	rcall SendCommandASM
	ldi r24,lo8(2000)
	ldi r25,hi8(2000)
	1: sbiw r24,1
	brne 1b
	ldi r24,lo8(0x60)
	rcall SendCommandASM
	ret
	.size	InitLCDASMR, .-InitLCDASMR

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

.global SetPWMASM
	.type SetPWMASM, @function
SetPWMASM:
	out 0x2a, r24
	ret
	.size SetPWMASM, .-SetPWMASM


	.ident	"DM- Lin.Git"