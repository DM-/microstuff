#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>


#define SENSOR 0
#define LED 4



void my_delay_ms(int n) {
 while(n--) {
  _delay_ms(1);
 }
}

uint8_t readCapacitivePin(int pinToMeasure) {
	PORTB &= ~_BV(pinToMeasure); //and low
	DDRB |=  _BV(pinToMeasure); //output
	_delay_ms(1);
	cli();
	DDRB &= ~_BV(pinToMeasure);
	PORTB |= _BV(pinToMeasure);
	uint8_t cycles = 17;
	if (bit_is_set(PINB,pinToMeasure)) { cycles =  0;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  1;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  2;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  3;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  4;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  5;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  6;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  7;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  8;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  9;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  10;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  11;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  12;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  13;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  14;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  15;}
	else if (bit_is_set(PINB,pinToMeasure)) { cycles =  16;}
	sei();
	PORTB &= ~_BV(pinToMeasure); //and low
	DDRB |=  _BV(pinToMeasure); //output
	return cycles;

}

void main(void){
	DDRB |= _BV(LED);
	while(1){
		my_delay_ms(32);
		int sensorValue = readCapacitivePin(SENSOR);
		PORTB |= _BV(LED);
		my_delay_ms(sensorValue*16);
		PORTB &= ~_BV(LED);
		_delay_ms(1);
	}
}