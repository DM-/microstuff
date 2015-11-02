#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(0); // set pin 0 as output
	TCCR0A |= (_BV(COM0A1)|_BV(WGM00)|_BV(WGM01)); // set the output pin, and set fast pwm
	OCR0A = 0x7D // set it to half duty cycle
	// OCR0A = 0x00 // set it to 0 duty cycle
	// OCR0A = 0xff // set it to 100 duty cycle
	while(1){
		}
	}
}