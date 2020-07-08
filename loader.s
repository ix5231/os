extern kmain

; allocate stack in .bss
section .bss

KERNEL_STACK_SIZE equ 4096

kernel_stack:
align 4
    resb KERNEL_STACK_SIZE

section .text
global loader

MAGIC_NUMBER equ 0x1BADB002
FLAGS equ 0x0
CHECKSUM equ -MAGIC_NUMBER

align 4
    dd MAGIC_NUMBER
    dd FLAGS
    dd CHECKSUM

loader:
    mov esp, kernel_stack + KERNEL_STACK_SIZE ; set frame pointer
    ;mov [0x000B8000], 0x2841
    call kmain
.loop:
    jmp .loop
