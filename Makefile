TARGET		:= 		atmega8
PORT		:= 		/dev/ttyUSB0
PROGRAMMER	:=		avrisp
RATE		:=		19200
.PHONY		:		fuses
%.upload: %.hex
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U flash:w:$*.hex
%.elf: %.c
	avr-gcc -mmcu=$(TARGET) -Wall -Os -o $@ $<
%.hex: %.elf
	avr-objcopy -R .eeprom -O ihex $< $@

%.asm: %.c
	avr-gcc -mmcu=$(TARGET) -S -Wall -Os -o $@ $<
fuses:
	date >>fuses
	echo "and the target is" $(TARGET) >>fuses
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U hfuse:r:-:b -U lfuse:r:-:b >>fuses