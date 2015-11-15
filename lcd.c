#define REVERSED 1
#include "lcdlib.c"

int main(void)
{
	InitLcd();
	SendCharacter('t');
	SendCharacter('e');
	SendCharacter('s');
	SendCharacter('t');
	SendCommand(0xC8);
	SendString("testing");
	while(1){

	}
}