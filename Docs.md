# boot.asm


## Important Points

- Here we start our boot loader in 16-bit real mode.
- We use the 1st sector of the floppy (i.e. 512 byte in size) as the memory for the boot loader.
- The last 2 bytes of the 1st sector are supposed to be the magic number (i.e. 0xaa55) to tell the BIOS to load this file for booting
- 0x7c00 is the address where we expect our boot loader to reside

## Code Explaination

To start the OS in 16 bit real mode, we have used :

```bash
    bits 16
```

then the directive for specifying the expected address for the code

```bash
    org 0x7c00
```

We have also defined some constants

```bash
    %define ENDL 0x0D, 0x0A, 0x00
```

Then comes the 'start' label, that initialize different segments and calls the main label. Inside start label :

```bash
    mov ax, 0
    mov ds, ax
    mov es, ax
```

Here, we are basically setting the defaults for the ds and es segment registers, as they can't be done directly we have used the ax registers to do so.
Also, we are setting up the stack registers to the default values

```bash
    mov ss, ax
    mov sp, 0x7c00
```

We have set the stack pointer to the start of code location so that, the stack doesn't overwrite the boot loader.
Then, we have our start calling the 'main' label.

```bash
    main:
    mov si, msg
    call print 
```

Inside 'main', we store the msg in 'SI' register (i.e. the stack index register), SI register is passed to print function as argument and then we are calling out the 'print' function (label)

Now, the print function is helping us with printing out the message onto the screen

within the 'print' label, we push si and ax to the stack as we will be modifying it

```bash
    push si
    push ax
```

Now, we have created a sub label '.print_loop', that will loop through each character of the message till the null character (0) is found

```bash
    lodsb
    or al, al  
    jz .print_end
```

the 'lodsb' is a instruction to load next character from ds:si to al and also increment si.
Then, the line 'or al, al' is using bitwise or operation to check if we get the null character, if yes it sets the flag to 0.
Next line checks the flag, if zero then jump to '.print_end' sub label

Then,

```bash
    mov ah, 0x0e   
    int 0x10    
    jmp .print_loop
```

We set the AH register to 0x0e value that refers to printing onto video screen, and then call the 0x10 interrupt to print. Then, it loops again the whole 'print_loop' till we get a null as discussed above

When we get null we jump to '.print_end' label, that pops out all the values from stack previously set

```bash
    pop ax
    pop si
    call halt
```

and also calls the 'halt' label to end the program


The second last line of code : 

```bash
    times 510 - ($ - $$) db 0
```
It pads the remaining sector with 0s till we reach the last two bytes, where the last two bytes are set to the magic number for the BIOS

```bash
    dw 0xaa55
```

dw instruction gives out two bytes



