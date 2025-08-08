组织0x7c00
位16

开始：
MOV ax，0xB800
MOV es，ax
MOV字节[es:0]，'A'
MOV字节[es:1]，0x1F
JMP$

乘以510-($-$$)db0
DW0xAA55
