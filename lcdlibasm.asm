	.file	"lcd.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
	.type	WaitLCDBusy, @function
WaitLCDBusy:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	out 0x11,__zero_reg__
	out 0x12,__zero_reg__
	cbi 0x18,7
	sbi 0x18,6
.L3:
	sbi 0x18,0
/* #APP */
 ;  36 "lcd.c" 1
	nop
 ;  0 "" 2
/* #NOAPP */
	cbi 0x18,0
	sbic 0x10,0
	rjmp .L3
	ldi r24,lo8(-1)
	out 0x11,r24
	ret
	.size	WaitLCDBusy, .-WaitLCDBusy
.global	SendCommand
	.type	SendCommand, @function
SendCommand:
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
	rcall WaitLCDBusy
	ldd r24,Y+1
	mov r30,r24
	ldi r31,0
	subi r30,lo8(-(table.1622))
	sbci r31,hi8(-(table.1622))
	ld r24,Z
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
	.size	SendCommand, .-SendCommand
.global	SendCharacter
	.type	SendCharacter, @function
SendCharacter:
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
	rcall WaitLCDBusy
	ldd r24,Y+1
	mov r30,r24
	ldi r31,0
	subi r30,lo8(-(table.1622))
	sbci r31,hi8(-(table.1622))
	ld r24,Z
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
	.size	SendCharacter, .-SendCharacter
.global	InitLcd
	.type	InitLcd, @function
InitLcd:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
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
	ldi r24,lo8(56)
	rcall SendCommand
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(56)
	rcall SendCommand
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(14)
	rcall SendCommand
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(1)
	rcall SendCommand
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(6)
	rcall SendCommand
	ldi r18,lo8(63999)
	ldi r24,hi8(63999)
	ldi r25,hlo8(63999)
	1: subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ret
	.size	InitLcd, .-InitLcd
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"testing"
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall InitLcd
	ldi r24,lo8(116)
	rcall SendCharacter
	ldi r24,lo8(101)
	rcall SendCharacter
	ldi r24,lo8(115)
	rcall SendCharacter
	ldi r24,lo8(116)
	rcall SendCharacter
	ldi r24,lo8(-56)
	rcall SendCommand
	ldi r28,lo8(.LC0)
	ldi r29,hi8(.LC0)
.L9:
	ld r24,Y+
	tst r24
	breq .L11
	rcall SendCharacter
	rjmp .L9
.L11:
	rjmp .L11
	.size	main, .-main
	.section	.rodata
	.type	table.1622, @object
	.size	table.1622, 256
table.1622:
	.byte	0
	.byte	-128
	.byte	64
	.byte	-64
	.byte	32
	.byte	-96
	.byte	96
	.byte	-32
	.byte	16
	.byte	-112
	.byte	80
	.byte	-48
	.byte	48
	.byte	-80
	.byte	112
	.byte	-16
	.byte	8
	.byte	-120
	.byte	72
	.byte	-56
	.byte	40
	.byte	-88
	.byte	104
	.byte	-24
	.byte	24
	.byte	-104
	.byte	88
	.byte	-40
	.byte	56
	.byte	-72
	.byte	120
	.byte	-8
	.byte	4
	.byte	-124
	.byte	68
	.byte	-60
	.byte	36
	.byte	-92
	.byte	100
	.byte	-28
	.byte	20
	.byte	-108
	.byte	84
	.byte	-44
	.byte	52
	.byte	-76
	.byte	116
	.byte	-12
	.byte	12
	.byte	-116
	.byte	76
	.byte	-52
	.byte	44
	.byte	-84
	.byte	108
	.byte	-20
	.byte	28
	.byte	-100
	.byte	92
	.byte	-36
	.byte	60
	.byte	-68
	.byte	124
	.byte	-4
	.byte	2
	.byte	-126
	.byte	66
	.byte	-62
	.byte	34
	.byte	-94
	.byte	98
	.byte	-30
	.byte	18
	.byte	-110
	.byte	82
	.byte	-46
	.byte	50
	.byte	-78
	.byte	114
	.byte	-14
	.byte	10
	.byte	-118
	.byte	74
	.byte	-54
	.byte	42
	.byte	-86
	.byte	106
	.byte	-22
	.byte	26
	.byte	-102
	.byte	90
	.byte	-38
	.byte	58
	.byte	-70
	.byte	122
	.byte	-6
	.byte	6
	.byte	-122
	.byte	70
	.byte	-58
	.byte	38
	.byte	-90
	.byte	102
	.byte	-26
	.byte	22
	.byte	-106
	.byte	86
	.byte	-42
	.byte	54
	.byte	-74
	.byte	118
	.byte	-10
	.byte	14
	.byte	-114
	.byte	78
	.byte	-50
	.byte	46
	.byte	-82
	.byte	110
	.byte	-18
	.byte	30
	.byte	-98
	.byte	94
	.byte	-34
	.byte	62
	.byte	-66
	.byte	126
	.byte	-2
	.byte	1
	.byte	-127
	.byte	65
	.byte	-63
	.byte	33
	.byte	-95
	.byte	97
	.byte	-31
	.byte	17
	.byte	-111
	.byte	81
	.byte	-47
	.byte	49
	.byte	-79
	.byte	113
	.byte	-15
	.byte	9
	.byte	-119
	.byte	73
	.byte	-55
	.byte	41
	.byte	-87
	.byte	105
	.byte	-23
	.byte	25
	.byte	-103
	.byte	89
	.byte	-39
	.byte	57
	.byte	-71
	.byte	121
	.byte	-7
	.byte	5
	.byte	-123
	.byte	69
	.byte	-59
	.byte	37
	.byte	-91
	.byte	101
	.byte	-27
	.byte	21
	.byte	-107
	.byte	85
	.byte	-43
	.byte	53
	.byte	-75
	.byte	117
	.byte	-11
	.byte	13
	.byte	-115
	.byte	77
	.byte	-51
	.byte	45
	.byte	-83
	.byte	109
	.byte	-19
	.byte	29
	.byte	-99
	.byte	93
	.byte	-35
	.byte	61
	.byte	-67
	.byte	125
	.byte	-3
	.byte	3
	.byte	-125
	.byte	67
	.byte	-61
	.byte	35
	.byte	-93
	.byte	99
	.byte	-29
	.byte	19
	.byte	-109
	.byte	83
	.byte	-45
	.byte	51
	.byte	-77
	.byte	115
	.byte	-13
	.byte	11
	.byte	-117
	.byte	75
	.byte	-53
	.byte	43
	.byte	-85
	.byte	107
	.byte	-21
	.byte	27
	.byte	-101
	.byte	91
	.byte	-37
	.byte	59
	.byte	-69
	.byte	123
	.byte	-5
	.byte	7
	.byte	-121
	.byte	71
	.byte	-57
	.byte	39
	.byte	-89
	.byte	103
	.byte	-25
	.byte	23
	.byte	-105
	.byte	87
	.byte	-41
	.byte	55
	.byte	-73
	.byte	119
	.byte	-9
	.byte	15
	.byte	-113
	.byte	79
	.byte	-49
	.byte	47
	.byte	-81
	.byte	111
	.byte	-17
	.byte	31
	.byte	-97
	.byte	95
	.byte	-33
	.byte	63
	.byte	-65
	.byte	127
	.byte	-1
	.ident	"GCC: (GNU) 4.8.1"
.global __do_copy_data
