org 0x7C00
bits 16

start:
    mov ax, 0xB800
    mov es, ax
    mov byte [es:0], 'A'
    mov byte [es:1], 0x1F
    jmp $

times 510-($-$$) db 0
dw 0xAA55
