	.file	"lcdlib.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
; can use _SFR_IO_ADDRESS & local symbol defines to make this very portable
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
	ldi r24,0xFF
	out 0x11,r24
	;sbr 0x11,0xFF ;mb swap later
	ret
	.size	WaitLCDBusyASM, .-WaitLCDBusyASM
.global	SendCommandASM
	.type	SendCommandASM, @function
SendCommandASM:
	; in r25, __zero_reg__
	; or r25, r24
	; rcall WaitLCDBusyASM
	; out 0x12,r25
	; cbi 0x18,7
	; cbi 0x18,6
	; sbi 0x18,0
	; nop
	; cbi 0x18,0
	; out 0x12,__zero_reg__
	; ret
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,r24
	rcall WaitLCDBusyASM
	ldd r24,Y+1
	out 0x12,r24
	cbi 0x18,7
	cbi 0x18,6
	sbi 0x18,0
/* #APP */
 ;  36 "lcd.c" 1
	nop
 ;  0 "" 2
/* #NOAPP */
	cbi 0x18,0
	out 0x12,__zero_reg__
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	SendCommandASM, .-SendCommandASM
.global	SendCharacterASM
	.type	SendCharacterASM, @function
SendCharacterASM:
	; in r25, __zero_reg__
	; or r25, r24
	; rcall WaitLCDBusyASM
	; out 0x12,r25
	; sbi 0x18,7
	; cbi 0x18,6
	; sbi 0x18,0
	; nop
	; cbi 0x18,0
	; out 0x12,__zero_reg__
	; ret
		push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	std Y+1,r24
	rcall WaitLCDBusyASM
	ldd r24,Y+1
	out 0x12,r24
	cbi 0x18,6
	sbi 0x18,7
	sbi 0x18,0
/* #APP */
 ;  36 "lcd.c" 1
	nop
 ;  0 "" 2
/* #NOAPP */
	cbi 0x18,0
	out 0x12,__zero_reg__
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
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
	ldi r24,lo8(0x1C)
	rcall SendCommandASM
	ldi r18,lo8(200)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x1C)
	rcall SendCommandASM
	ldi r18,lo8(200)
	1: subi r18,1
	brne 1b
	ldi r24,lo8(0x70)
	rcall SendCommandASM
	ldi r18,lo8(200)
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
	sbi 0x17, 1
	sbi 0x18, 1
	ret
	.size	InitLcd, .-InitLcd
.global main
	.type main, @function
main:
	rcall InitLcd
	ldi r24,lo8(0x2e)
	rcall SendCharacterASM
	ldi r24,lo8(101)
	rcall SendCharacterASM
	ldi r24,lo8(115)
	rcall SendCharacterASM
	ldi r24,lo8(116)
	rcall SendCharacterASM
.L11:
	rjmp .L11
	.ident	"DM- Lin.Git"


