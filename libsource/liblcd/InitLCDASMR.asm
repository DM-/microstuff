.include "liblcdcom.asm"
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