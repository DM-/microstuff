#define REVERSED 1
#define F_CPU 8000000
#include "lcdlib.c"
#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
	InitLcd();
	InitPWM();
	SetPWM(0x20);
	SendCharacter('t');
	SendCharacter('e');
	SendCharacter('s');
	SendCharacter('t');
	SendCharacter('i');
	SendCharacter('n');
	SendCharacter('g');
	SendCharacter('1');
	SendCharacter('2');
	SendCharacter('3');
	SendCommand(0x80|0x20);
	SendCharacter('A');
	SendCharacter('L');
	SendCharacter('P');
	SendCommand(0x80|0x40);
	SendCharacter('t');
	SendCharacter('e');
	SendCharacter('s');
	SendCharacter('t');
	SendCharacter('i');
	SendCharacter('n');
	SendCharacter('g');
	SendCharacter('4');
	SendCharacter('5');
	SendCharacter('6');
	SendCommand(0x80|0x61);
	SendCharacter('H');
	SendCharacter('A');
	while(1){
		_delay_ms(300);
		SHIFTSCREENLEFT;

	}
}