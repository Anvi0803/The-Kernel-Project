; ------------------ Boot Loader --------------------- ;

bits 16
org 0x7c00

; ------------------ Definitions ---------------------

%define ENDL 0x0D, 0x0A, 0x00   


; ---------- initialzation code ----------------
start:

    ; Set up the segment registers
    mov ax, 0  
    mov ds, ax  ; putting ds, es and ss to 0 (can't be set directly)    
    mov es, ax  
    
    ; Setting up the stack
    mov ss, ax
    mov sp, 0x7c00      ; stack pointer to 0x7c00 (so it doesn't overwrite the bootloader)
    call main





; Function to print String
; 
; Arguments: 
;   ds:si -> string to print
;   
print:
    push si
    push ax

.print_loop:
    lodsb      ; loads next character from ds:si into al and increments si
    or al, al   ; check if al is null
    jz .print_end

    mov ah, 0x0e    ; interrupt handler to print text to screen
    int 0x10    ; print character in al
    jmp .print_loop

.print_end:
    pop ax
    pop si
    ret



main:
    mov si, msg
    call print 
    mov si, new_msg
    call print
    call halt



; Function to halt the system
halt:
    hlt
    jmp halt   ; loop if halt fails


msg:
    db "Hello World!", ENDL, 0

new_msg:
    db "Hello World! 2", ENDL, 0

times 510-($-$$) db 0   ; pad with zeros upto 510 bytes
dw 0xaa55   ; The boot signature (or Magic Number)
