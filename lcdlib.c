#include "RBLT.h"

##ifndef REVERSED
#define REVERSED 0  // Set this to 1 here, on as a config define in your file to get stuff right
#endif

#if REVERSED
#define OUT RBLT
#define InitLcd InitLcdASMR
#else
#define OUT(X) X
#define InitLcd InitLcdASM
#endif

#define SHIFTCURSORRIGHT	SendCommand(0x14)
#define SHIFTCURSORLEFT		SendCommand(0x10)
#define SHIFTSCREENRIGHT	SendCommand(0x1C)
#define SHIFTSCREENLEFT		SendCommand(0x18)
#define CLEARDISPLAY		SendCommand(0x01)
#define	HOMEDISPLAY			SendCommand(0x02)
; // just here to fix a syntax highlight bug in sublime

void SendCommandASM(unsigned char);
void SendCharacterASM(unsigned char);
void InitLcd(void); // Actually is replaced by asm version by preprocessor.
void SendStringASM(char *); // There is no reversed option for sendstring
#define SendString 			SendStringASM



static void SendCommand(unsigned char command){
	SendCommandASM(OUT(command));
}

static void SendCharacter(unsigned char character){
	SendCharacterASM(OUT(character));
}