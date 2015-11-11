#define F_CPU 8000000

#include <avr/io.h>
#include <util/delay.h> // for delay
#include <avr/interrupt.h> // for isr
#include <avr/cpufunc.h> //for _NOP


ISR(INT0_vect){
	OCR1A=0xff;
	while(bit_is_clear(PORTD,2)){
		_delay_ms(10);
	}
}

int main(void){
	DDRB |= _BV(1); // set pin 0 as output
	PORTD |=_BV(2); // set the internal pullup on portd pin 2
	TCCR1A |= (_BV(COM1A1)|_BV(WGM10)); // set the output pin, and set fast pwm(8bit), and select output pin
	TCCR1B |= _BV(CS10)|_BV(WGM12); //continue setting fast pwm, and set clock source = clk.io
	ADMUX |= _BV(REFS0); // set the refrence to avcc.
	ADMUX |= _BV(ADLAR); // left adjust the results so we can just read ADCH
	ADCSRA |= _BV(ADEN)|_BV(ADSC)|_BV(ADFR)|_BV(ADPS0)|_BV(ADPS1)|_BV(ADPS2); 
	//enable the adc, start the adc, and put it into free running mode. And prescale clock for the 8mhs 
	GICR |=_BV(INT0); // enable the int0 external interrupt request
	sei(); //enable interrupts
	while (1){
		OCR1A = ADCH;
	}
}