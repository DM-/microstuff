.section	.text.
.global	main
main:
.L1:
	sbi 0x17,1
	in r24,0x2f
	ori r24,lo8(-127)
	out 0x2f,r24
	in r24,0x2e
	ori r24,lo8(9)
	out 0x2e,r24
	ldi r24,lo8(125)
	out 0x2a,r24
	ldi r18,lo8(1)
.L6:
	in r24,0x2a
	in r20,0x2a
	or r20,r1
	breq .L7
	cpi r24,-1
	breq .L2
	brlo .L2
.L7:
	neg r18
.L2:
	in r24,0x2a
	in r25,0x2a+1
	add r24,r18
	adc r25,r19
	out 0x2a+1,r25
	out 0x2a,r24
	ldi r24,lo8(1999)
	ldi r25,hi8(1999)
	1: sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L6
	.size	main, .-main
	.ident	"GCC: (GNU) 4.8.1"
