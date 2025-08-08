#!/bin/bash

# 汇编引导加载程序
nasm -f bin boot.asm -o boot.bin

# 汇编内核
nasm -f bin kernel.asm -o kernel.bin

# 汇编UI框架
nasm -f bin ui.asm -o ui.bin

# 创建磁盘映像 (1.44MB 软盘)
dd if=/dev/zero of=disk.img bs=512 count=2880
dd if=boot.bin of=disk.img conv=notrunc
dd if=kernel.bin of=disk.img seek=1 conv=notrunc
dd if=ui.bin of=disk.img seek=10 conv=notrunc

# 运行模拟器
qemu-system-i386 -drive format=raw,file=disk.img
