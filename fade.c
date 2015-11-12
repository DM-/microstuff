#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>
#include "INCLUDEHEADER.h"

int main(void){
	DDRB |= _BV(1); // set pin 0 as output
	TCCR1A |= (_BV(COM1A1)|_BV(WGM10)); // set the output pin, and set fast pwm
	TCCR1B |= _BV(CS10)|_BV(WGM12); // and set clock 
	OCR1A = 0x80; // set it to half duty cycle
	//OCR0A = 0x00; // set it to 0 duty cycle
	//OCR0A = 0xff; // set it to 100 duty cycle
	int changeInRegister = 1;
	while(1){
		if ((OCR1A>0xff)|(OCR1A==0x00))
		{
			changeInRegister = changeInRegister * -1;
		}
		OCR1A = OCR1A + changeInRegister;
		_delay_ms(1);
		}
}