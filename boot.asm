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
    
    ; 在boot.asm的jmp $前添加:
    mov ah, 0x02    ; 读取扇区
    mov al, 1       ; 扇区数
    mov ch, 0       ; 柱面号
    mov cl, 2       ; 扇区号 (从2开始)
    mov dh, 0       ; 磁头号
    mov bx, 0x1000  ; 加载地址
    mov es, bx
    mov bx, 0x0000
    int 0x13

    call 0x1000:0x0000 ; 跳转到内核
    
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
