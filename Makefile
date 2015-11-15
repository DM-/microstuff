TARGET		:= 		atmega8
PORT		:= 		/dev/ttyUSB0
PROGRAMMER	:=		avrisp
RATE		:=		19200
GENERAL		:=		-U 
LIBRARIES	:=		
LIBOBJ		:=		
.PHONY		:		fuses generic

# -flto can let the compiler optimise many .c s together

%.upload: %.hex
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U flash:w:$*.hex

%.elf: %.c
	avr-gcc -mmcu=$(TARGET) $(COMPILEROPTIONS) -L./lib/ -I./include/ -Wall -Os -o $@ $< $(LIBRARIES)

%.elf: %.asm
	avr-gcc -mmcu=$(TARGET) $(COMPILEROPTIONS) -L./lib/ -I./include/ -x assembler-with-cpp -Wall -Os -o $@ $< $(LIBRARIES)

%.hex: %.elf
	avr-objcopy -R .eeprom -O ihex $< $@

%.asmt: %.c
	avr-gcc -mmcu=$(TARGET) $(COMPILEROPTIONS) -S -L./lib/ -I./include/ -Wall -Os -o ./asmt/$@ $<

%.asmt: %.asm
	avr-gcc -mmcu=$(TARGET) $(COMPILEROPTIONS) -S -x assembler-with-cpp -L./lib/ -I./include/ -Wall -Os $< >./asmt/$@

%.asmtd: %.elf
	avr-objdump -S $< >./asmtd/$@

%.o: %.c
	avr-gcc -mmcu=$(TARGET) -c -Wall -Os -o $@ $<

%.o: %.asm
	avr-gcc -mmcu=$(TARGET) -x assembler -c -Wall -Os -o $@ $<

fuses:
	date >>fuses
	echo "and the target is" $(TARGET) >>fuses
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) -U hfuse:r:-:b -U lfuse:r:-:b >>fuses

genericdude:
	avrdude -v -P $(PORT) -p $(TARGET) -c $(PROGRAMMER) -b $(RATE) $(GENERAL)