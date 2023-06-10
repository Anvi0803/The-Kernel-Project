bits 16
org 0x7c00

main:
    hlt ; halt instruction

.halt:
    jmp .halt   ; loop if halt fails


times 510-($-$$) db 0   ; pad with zeros upto 510 bytes


dw 0xaa55   ; The boot signature (or Magic Number)