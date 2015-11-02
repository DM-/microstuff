#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(0); // set pin 0 as output
	TCCR0A |= (_BV(COM0A1)|_BV(WGM00)|_BV(WGM00)); // set the output pin, and set fast pwm
	TCCR0B |= _BV(CS00);
	OCR0A = 0x7D; // set it to half duty cycle
	//OCR0A = 0x00; // set it to 0 duty cycle
	//OCR0A = 0xff; // set it to 100 duty cycle
	volatile int changeInRegister = 1;
	while(1){
		if ((OCR0A==0xff|OCR0A==0x00))
		{
			changeInRegister = changeInRegister * -1;
		}
		OCR0A = OCR0A + changeInRegister;
		_delay_ms(10);
		}
}