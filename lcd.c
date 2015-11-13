#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

#define CONTROLPORT 	PORTB  	// The port on which the control pins are
#define CONTROLPORTDIR	DDRB	// The control register for the control pins
#define ENABLE 			0 		// The pin for the enable signal on the control port //1= lcd reads stuff, falling edge = lcd does stuff	
#define REGISTERSELECT 	7		// The pin for the RS signal on the control port // 1=character, 0=command
#define READWRITE 		6		// The pin for the RW signal on the control port // 1= read, 0=write
#define DATAPORT		PORTD	// The port on which the data pins are
#define DATAPORTDIR		DDRD	// The control register for the data pins

void EnablePulse(void){
	CONTROLPORT	|= _BV(ENABLE);
	asm ("nop"::);
	asm ("nop"::);
	asm ("nop"::);
	asm ("nop"::);
	CONTROLPORT &= ~_BV(ENABLE);
	asm ("nop"::);
	asm ("nop"::);
	asm ("nop"::);
	asm ("nop"::);
}

void WaitLCDBusy(void){
	DATAPORTDIR = 0x00;
	CONTROLPORT &= _BV(REGISTERSELECT); // this is inefficient in assembly, make it a cbi
	CONTROLPORT	|= _BV(READWRITE);
	while (bit_is_set(DATAPORT,7)){
		EnablePulse();
	}
	DATAPORTDIR = 0xff; // this is ineffcient too, use SBR DATAPORTDIR 0xFF
}

void SendCommand(unsigned char command){ // both this and sendchar are TERRIBLY INEFFICIENT
	WaitLCDBusy();
	DATAPORT = command;
	CONTROLPORT &= _BV(REGISTERSELECT);
	CONTROLPORT &= _BV(READWRITE);
	EnablePulse();
	DATAPORT = 0;
}

void SendCharacter(unsigned char character){
	WaitLCDBusy();
	DATAPORT = character;
	CONTROLPORT &= _BV(READWRITE);
	CONTROLPORT |= _BV(REGISTERSELECT);
	EnablePulse();
	DATAPORT = 0;
}

void InitLcd(void){
	CONTROLPORTDIR |= _BV(ENABLE);
	CONTROLPORTDIR |= _BV(REGISTERSELECT);
	CONTROLPORTDIR |= _BV(READWRITE);
	_delay_ms(40);
	SendCommand(0x3C); //Function set, for reset
	_delay_ms(40);
	SendCommand(0x3C); //Function set, for real
	_delay_ms(40);
	SendCommand(0xF0); //Display, cursor and blink on
	_delay_ms(400);
	SendCommand(0x80); //Clear the display
	_delay_ms(400);
	SendCommand(0x60); //Entry mode set to increment, no shift
	_delay_ms(400);

}

int main(void)
{
	InitLcd();
	SendCharacter(0xff);
	while(1){

	}
}