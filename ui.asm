; fiftysh UI框架
org 0x2000
bits 16

ui_init:
    ; 保存当前视频模式
    mov ah, 0x0F
    int 0x10
    mov [old_mode], al
    
    ; 设置图形模式 (CGA 640x200 黑白)
    mov ax, 0x0006
    int 0x10
    
    ; 绘制桌面背景
    call draw_desktop
    
    ; 绘制窗口
    mov cx, 50  ; X位置
    mov dx, 30  ; Y位置
    mov si, 200 ; 宽度
    mov di, 100 ; 高度
    mov al, 1   ; 颜色
    call draw_window
    
    ret

draw_desktop:
    ; 简单的桌面背景
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 80*25
    mov ax, 0x7000 ; 灰色背景
    rep stosw
    ret

draw_window:
    ; 简单窗口绘制
    ; 参数: CX=X, DX=Y, SI=宽, DI=高, AL=颜色
    pusha
    mov bx, dx
    shl bx, 7    ; Y*128
    shl dx, 5    ; Y*32
    add bx, dx   ; Y*160
    add bx, cx   ; +X
    
    mov ah, al
    mov al, ' '
    mov cx, si
    
    mov dx, di
.win_loop:
    push cx
    push bx
    rep stosw
    pop bx
    pop cx
    add bx, 160
    dec dx
    jnz .win_loop
    
    popa
    ret

old_mode db 0
