#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(3); // set pin 0 as output
	DDRB |= _BV(4);
	PORTB |= _BV(4);
	while(1){
		PORTB ^= _BV(3);
		_delay_ms(100);
	}
}