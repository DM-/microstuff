#include "RBLT.h"

void SendCommandASM(unsigned char);
void SendCharacterASM(unsigned char);
void InitLcd(void);

int main(void)
{
	InitLcd();
	//SendCharacterASM(RBLT('t'));
	//SendCharacterASM('e');
	//SendCharacterASM('s');
	//SendCharacterASM('t');
	//SendCommandASM(RBLT(0xC8));
	while(1){

	}
}