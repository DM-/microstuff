#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

#define CONTROLPORT 	PORTB 
#define ENABLE 			0
#define REGISTERSELECT 	7
#define READWRITE 		6
#define DATAPORT		PORTD
#define DATAPORTDIR		DDRD

void EnablePulse(void){
	CONTROLPORT	|= _BV(ENABLE);
	asm ("nop"::);
	CONTROLPORT &= ~_BV(ENABLE);
}

void WaitLCDBusy(void){
	DATAPORTDIR = 0x00;
	CONTROLPORT &= _BV(REGISTERSELECT);
	CONTROLPORT	|= _BV(READWRITE);
	while (bit_is_set(DATAPORT,7)){
		EnablePulse();
	}
	DATAPORTDIR = 0xff;
}

void SendCharacter(unsigned char character){
CheckIfBusy();
PORTB = character;
PORTD &= ~(1<<7); //turn off RW (write mode)
PORTD |= (1<<2); //turn on RS (character display mode)
BlinkLight();
DDRB = 0;
}

void SendCommand(unsigned char command){
	WaitLCDBusy();
	DATAPORT = command
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
	DATAPORT = 0
}