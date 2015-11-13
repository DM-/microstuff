#define F_CPU 8000000

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
#define OUT(X) RBLT(X)
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

static void WaitLCDBusy(void){
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

void SendCommand(unsigned char command){ // both this and sendchar are TERRIBLY INEFFICIENT
	WaitLCDBusy();
	DATAPORT = OUT(command);
	CONTROLPORT &=~_BV(REGISTERSELECT);
	CONTROLPORT &=~_BV(READWRITE);
	EnablePulse();
	DATAPORT = 0;
}

void SendCharacter(unsigned char character){
	WaitLCDBusy();
	DATAPORT = OUT(character);
	CONTROLPORT &=~_BV(READWRITE);
	CONTROLPORT |= _BV(REGISTERSELECT);
	EnablePulse();
	DATAPORT = 0;
}

static void SendString(char *String){
	while(*String){
		SendCharacter(OUT(*String++));
	}
}

void InitLcd(void){
	CONTROLPORTDIR |= _BV(ENABLE);
	CONTROLPORTDIR |= _BV(REGISTERSELECT);
	CONTROLPORTDIR |= _BV(READWRITE);
	_delay_ms(40);
	SendCommand(0x38); //Function set, for reset
	_delay_ms(40);
	SendCommand(0x38); //Function set, for real
	_delay_ms(40);
	SendCommand(0x0E); //Display, cursor and blink off
	_delay_ms(40);
	SendCommand(0x01); //Clear the display
	_delay_ms(40);
	SendCommand(0x06); //Entry mode set to increment, no shift
	_delay_ms(40);
}

int main(void)
{
	InitLcd();
	SendString("testing");
	SendCharacter(0x17);
	SendCommand(0xC8);
	SHIFTCURSORRIGHT;
	while(1){

	}
}