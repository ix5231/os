OBJECTS = loader.o kmain.o io.o fb.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
	 -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

all: kernel

kernel: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

run: kernel
	qemu-system-x86_64 -kernel kernel.elf -d guest_errors

rundcpu: kernel
	qemu-system-x86_64 -kernel kernel.elf -d cpu

%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf
