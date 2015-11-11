TARGET		:= 		atmega8
PORT		:= 		/dev/ttyUSB0
PROGRAMMER	:=		avrisp
RATE		:=		19200
GENERAL		:=		-U 
.PHONY		:		fuses generic

%.upload: %.hex
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U flash:w:$*.hex

%.elf: %.c
	avr-gcc -mmcu=$(TARGET) -Wall -Os -o $@ $<

%.elf: %.asm
	avr-gcc -mmcu=$(TARGET) -x assembler -Wall -Os -o $@ $<

%.hex: %.elf
	avr-objcopy -R .eeprom -O ihex $< $@

%.asmt: %.c
	avr-gcc -mmcu=$(TARGET) -S -Wall -Os -o $@ $<

fuses:
	date >>fuses
	echo "and the target is" $(TARGET) >>fuses
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U hfuse:r:-:b -U lfuse:r:-:b >>fuses

genericdude:
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) $(GENERAL)