upload%: %.hex
	avrdude -v -P /dev/ttyUSB0 -p attiny45 -c avrisp -b 19200 -U flash:w:$*.hex
%.elf: %.c
	avr-gcc -mmcu=attiny45 -Wall -Os -o $@ $<
%.hex: %.elf
	avr-objcopy -R .eeprom -O ihex $< $@

%.asm: %.c
	avr-gcc -mmcu=attiny45 -S -Wall -Os -o $@ $<
