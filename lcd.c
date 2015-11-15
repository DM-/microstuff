#define REVERSED 1
#define F_CPU 8000000
#include "lcdlib.c"
#include <util/delay.h>

int main(void)
{
	InitLcd();
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
	SendCommand(0xA5);
	SendCharacter('A');
	SendCharacter('L');
	SendCharacter('P');
	SendCommand(0xC0);
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
	SendCommand(0xE6);
	SendCharacter('H');
	SendCharacter('A');
	while(1){
		_delay_ms(100);
		SendCommand(0x18);

	}
}