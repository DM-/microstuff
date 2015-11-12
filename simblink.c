#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>
#define BLINKPORT 1

int main(void){
	DDRB |= _BV(BLINKPORT); // set pin 3 as output
	while(1){
		PORTB ^= _BV(BLINKPORT);
		_delay_ms(100);
	}
}