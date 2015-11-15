#include "RBLT.h"

void SendCommandASM(unsigned char);
void SendCharacterASM(unsigned char);
void InitLcd(void);
void SendStringASM(char *);

int main(void)
{
	InitLcd();
	SendCharacterASM(RBLT('t'));
	SendCharacterASM('e');
	SendCharacterASM('s');
	SendCharacterASM('t');
	SendCommandASM(RBLT(0xC8));
	SendStringASM("testing");
	while(1){

	}
}