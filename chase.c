#define F_CPU 8000000
#import <avr/io.h>
#include <util/delay.h>

#define LEFT 4
#define BOTT 3
#define RIGH 2
#define TOPP 1
#define DOTT 0

void main(void){
	DDRB |= 0b00011111;
	while(1){
		PORTB |= _BV(LEFT);
		_delay_ms(100);
		PORTB &= ~_BV(LEFT);
		PORTB |= _BV(BOTT);
		_delay_ms(100);
		PORTB &= ~_BV(BOTT);
		PORTB |= _BV(RIGH);
		_delay_ms(100);
		PORTB &= ~_BV(RIGH);
		PORTB |= _BV(TOPP);
		_delay_ms(100);
		PORTB &= ~_BV(TOPP);
	}
	
}