#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(0); // set pin 0 as output
	DDRB &= ~_BV(4);
	PORTB |= _BV(4); //set  input pin pullup
	TCCR0A |= (_BV(COM0A1)|_BV(WGM00)|_BV(WGM01)); // set the output pin, and set fast pwm
	TCCR0B |= _BV(CS00);
	OCR0A = 0x7D; // set it to half duty cycle
	//OCR0A = 0x00; // set it to 0 duty cycle
	//OCR0A = 0xff; // set it to 100 duty cycle
	int changeInRegister = 1;
	while(1){
		if ((OCR0A==0xff|OCR0A==0x00))
		{
			changeInRegister = changeInRegister * -1;
		}
		OCR0A = OCR0A + changeInRegister;
		if (bit_is_set(PINB,4))
		{
			_delay_ms(9);
		}
		_delay_ms(1);
		}
}