// this is for attiny 45, led cathode is on portb 3, anode on portb 4.
// the LED is a blue LED , the light is fluro blue. The LED is on at basically full power with light on and off.
#define F_CPU 1000000

#include <avr/io.h>
#include <util/delay.h>
#include <stdint.h>

#define LED_N 3
#define LED_P 4

void main(void)
{
    uint16_t count = 0;

    while (1) {
        DDRB |= _BV(LED_N); // n output
        DDRB |= _BV(LED_P); // p output
        PORTB |= _BV(LED_N); // n high (+)
        PORTB &= ~_BV(LED_P); // p low (-)

        DDRB &= ~_BV(LED_N); // n input
        PORTB &= ~_BV(LED_N); // remove n pullup, n now (-)

        while (bit_is_set(PINB, LED_N)) { // waits for B to go from (+) to (-)
            count++;
        }

        DDRB |= _BV(LED_N); // n output
        DDRB |= _BV(LED_P); // p output
        PORTB &= ~_BV(LED_N); // n low (-)
        PORTB |= _BV(LED_P); // p high (+)
        for (uint16_t delayer = 0; delayer < count; delayer++) _delay_us(1);
        PORTB &= ~_BV(LED_P); // p low (-)
        for (uint16_t delayer = 0; delayer < count; delayer++) _delay_us(1);
        count = 0;
    }
}