ASM=nasm

SRC=src
BUILD=build
BOOT=boot

run: build
	qemu-system-i386 $(BUILD)/boot.img

build: comp
	cp $(BUILD)/boot.bin $(BUILD)/boot.img
	truncate -s 1400k $(BUILD)/boot.img

comp: $(BOOT)/basic_boot.asm
	$(ASM) $(BOOT)/basic_boot.asm -f bin -o $(BUILD)/boot.bin
	
