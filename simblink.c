#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(0); // set pin 3 as output
	while(1){
		PORTB ^= _BV(0);
		_delay_ms(100);
	}
}