; fiftysh 最小内核
org 0x1000
bits 16

kernel_main:
    ; 设置数据段
    mov ax, cs
    mov ds, ax
    
    ; 显示内核消息
    mov si, msg_kernel
    call print_string
    
    ; 这里可以添加更多内核功能
    
    ret

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

msg_kernel db "fiftysh kernel v0.1 loaded", 0xD, 0xA, 0
