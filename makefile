blink.hex: blink.elf
	avr-objcopy -R .eeprom -O ihex blink.elf blink.hex
blink.elf: blinky.c
	avr-gcc -mmcu=attiny45 -Wall -Os -o blink.elf blinky.c
upload: blink.hex
	avrdude -v -P /dev/ttyUSB0 -p attiny45 -c avrisp -b 19200 -U flash:w:blink.hex