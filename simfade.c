#define F_CPU 8000000
#include <util/delay.h>
#include <avr/io.h>
#define STRENGTH 0x80
#define FADEPORT PB1


int main(void){
	DDRB |= _BV(FADEPORT); // set pin 0 as output
	TCCR1A |= _BV(COM1A1)|_BV(WGM10); // set the output pin, and set fast pwm(8bit), and select output pin
	TCCR1B |= _BV(CS10)|_BV(WGM12); //continue setting fast pwm, and set clock source = clk.io
	OCR1A = STRENGTH;
	while(1){
	};
}