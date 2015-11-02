#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>

int main(void){
	DDRB |= _BV(0); // set pin 0 as output
	DDRB &= ~_BV(4); // set pin 4 as input
	PORTB |= _BV(4); // set pin 4's pullup
	while(1){
		PORTB ^= _BV(0);
		if (bit_is_set(PINB,4))
		{
			_delay_ms(2000);
		}
		else
		{
			_delay_ms(100);
		}
	}
}