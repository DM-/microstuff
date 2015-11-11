#include <avr/io.h>

int main(void){
	DDRB |= _BV(1); // set pin 0 as output
	TCCR1A |= _BV(COM1A1);
	TCCR1A |= _BV(WGM10); // set the output pin, and set fast pwm(8bit), and select output pin
	TCCR1B |= _BV(CS10)|_BV(WGM12); //continue setting fast pwm, and set clock source = clk.io
	OCR1A = 0xFF;
	while(1){};
}