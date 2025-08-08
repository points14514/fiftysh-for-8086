nasm -f bin test.asm -o test.bin
qemu-system-i386 -drive format=raw,file=test.bin
