; fiftysh 引导加载程序
org 0x7C00
bits 16

start:
    ; 设置视频模式 (80x25 文本)
    mov ax, 0x0003
    int 0x10
    
    ; 显示启动消息
    mov si, msg_loading
    call print_string
    
    ; 这里可以添加内核加载代码
    
    jmp $ ; 无限循环

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

msg_loading db "fiftysh bootloader v0.1", 0xD, 0xA, 0

times 510-($-$$) db 0
dw 0xAA55
