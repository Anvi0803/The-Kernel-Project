ASM=nasm
GCC=gcc

KER=kernel
BUILD=build
BOOT=boot

run: build
	qemu-system-i386 -fda $(BUILD)/boot.img

build: compile
	cp $(BUILD)/boot.bin $(BUILD)/boot.img
	truncate -s 1400k $(BUILD)/boot.img

compile: $(BOOT)/boot.asm
	$(ASM) $(BOOT)/boot.asm -f bin -o $(BUILD)/boot.bin