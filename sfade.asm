.section	.text
.global	main
main:
.L__stack_usage = 0
	sbi 0x17,1
	in r24,0x2f
	ori r24,-127
	out 0x2f,r24
	in r24,0x2e
	ori r24,9
	out 0x2e,r24
	ldi r24,1
	out 0x2a,r24
.L2:
	rjmp .L2
