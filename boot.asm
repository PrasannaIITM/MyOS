;BIOS loads us into 0x7c00
;assembler originates from this address
ORG 0x7c00
;assemble into 16 bit code
BITS 16

start:
    ;move address of message label to si register
    mov si, message
    call print
    jmp $

print:
    mov bx, 0
.loop:
    ;load character si register is pointing to into al register, and increments si register
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop
.done:
    ret

;output char from al register to screen
print_char:
    ;move 0eh into the ah register
    mov ah, 0eh
    ;calling BIOS
    int 0x10
    ret


message: db 'Hello World', 0 
;append 0 till 510
times 510-($ - $$) db 0
;boot signature, byte sequence 0x55, 0xAA at byte offsets 510 and 511 respectively
dw 0xAA55