#define F_CPU 8000000 //remove this after testing

#include <avr/io.h>
#include <util/delay.h>
#include "RBLT.h"



#define CONTROLPORT 	PORTB  	// The port on which the control pins are
#define CONTROLPORTDIR	DDRB	// The control register for the control pins
#define ENABLE 			0 		// The pin for the enable signal on the control port //1= lcd reads stuff, falling edge = lcd does stuff	
#define REGISTERSELECT 	7		// The pin for the RS signal on the control port // 1=character, 0=command
#define READWRITE 		6		// The pin for the RW signal on the control port // 1= read, 0=write
#define DATAPORT		PORTD	// The port on which the data pins are written to
#define DATAPIN			PIND	// The input register for the data pins
#define DATAPORTDIR		DDRD	// The control register for the data pins
#define REVERSED		1		// Set this to one if the data port between uC and LCD are reversed. 0 Otherwise.
								// Reversed uses a 300 byte lookuptable and  few cycles per character. Not recommended.
								// You can set Reversed to 0 and manually invoke SendCharacter(RBLT(OUTPUT)) to have
								// The preprocessor optimize it out (if its static). Wont work on runtime generated output.

#if REVERSED
#define OUT RBLT
#else
#define OUT(X) X
#endif

#define SHIFTCURSORRIGHT	SendCommand(OUT(0x14))
#define SHIFTCURSORLEFT		SendCommand(OUT(0x10))
#define SHIFTSCREENRIGHT	SendCommand(OUT(0x1C))
#define SHIFTSCREENLEFT		SendCommand(OUT(0x18))
#define CLEARDISPLAY		SendCommand(OUT(0x01))
#define	HOMEDISPLAY			SendCommand(OUT(0x02))


static inline void  __attribute__ ((always_inline)) EnablePulse(void){
	CONTROLPORT	|= _BV(ENABLE);
	asm ("nop"::);
	CONTROLPORT &= ~_BV(ENABLE);
}

static void WaitLCDBusyASM(void){
	DATAPORTDIR = 0x00;
	DATAPORT 	= 0x00;
	CONTROLPORT &=~_BV(REGISTERSELECT); // this is inefficient in assembly, make it a cbi
	CONTROLPORT	|= _BV(READWRITE);
	EnablePulse();
	while (bit_is_set(DATAPIN,0)){
		EnablePulse();
		// CONTROLPORT	|= _BV(ENABLE);
		// _delay_ms(10);
		// CONTROLPORT &= ~_BV(ENABLE);
		// asm ("nop"::);
	}
	DATAPORTDIR = 0xff; // this is ineffcient too, use SBR DATAPORTDIR 0xFF
}

void SendCommandASM(unsigned char command){ // both this and sendchar are TERRIBLY INEFFICIENT
	WaitLCDBusyASM();
	DATAPORT = command;
	CONTROLPORT &=~_BV(REGISTERSELECT);
	CONTROLPORT &=~_BV(READWRITE);
	EnablePulse();
	DATAPORT = 0;
	// WaitLCDBusyASM();
	// asm ("out %0 %5" "\n\t"
	// 	"cbi %1 %2" "\n\t"
	// 	"cbi %1 %3" "\n\t"
	// 	"sbi %1 %4" "\n\t"
	// 	"nop" "\n\t"
	// 	"cbi %1 %4" "\n\t"
	// 	"out %0 %6" "\n\t"
	// 	"ret"
	// 	:"=&I" (_SFR_IO_ADDR(PORTD)),"=&I" (_SFR_IO_ADDR(PORTB )) // Output ops
	// 	:"M" (REGISTERSELECT),"M"(READWRITE),"M" (ENABLE),"a" (command), "M" (0x00)
	// 	); // input ops
}

static void SendCommand(unsigned char command){
	SendCommandASM(OUT(command));
}

void SendCharacterASM(unsigned char character){
	WaitLCDBusyASM();
	DATAPORT = OUT(character);
	CONTROLPORT &=~_BV(READWRITE);
	CONTROLPORT |= _BV(REGISTERSELECT);
	EnablePulse();
	DATAPORT = 0;
}

static void SendCharacter(unsigned char character){
	SendCharacterASM(OUT(character));
}

static void SendString(char *String){
	while(*String){
		SendCharacterASM(*String++);
	}
}

volatile int XD = 0x38;
void InitLcd(void){
	CONTROLPORTDIR |= _BV(ENABLE);
	CONTROLPORTDIR |= _BV(REGISTERSELECT);
	CONTROLPORTDIR |= _BV(READWRITE);
	_delay_ms(40);
	SendCommand(XD); //Function set, for reset
	_delay_ms(40);
	SendCommand(0x38); //Function set, for real
	_delay_ms(40);
	SendCommand(0x0E); //Display, cursor and blink off
	_delay_ms(40);
	SendCommand(0x01); //Clear the display
	_delay_ms(40);
	SendCommandASM(0x06); //Entry mode set to increment, no shift
	_delay_ms(40);
}