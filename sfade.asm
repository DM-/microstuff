#include "avr/io.h"


.section	.text
.global	main
.org 0x0000
main:
.L1:
	sbi _SFR_IO_ADDR(DDRB) , PB1
	in r24 , _SFR_IO_ADDR(TCCR1A)
	ori r24 , -127
	out _SFR_IO_ADDR(TCCR1A) , r24
	in r24 , _SFR_IO_ADDR(TCCR1B)
	ori r24 , 9
	out _SFR_IO_ADDR(TCCR1B) , r24
	ldi r24 , 100
	out _SFR_IO_ADDR(OCR1A) , r24
.L2:
	rjmp .L2
