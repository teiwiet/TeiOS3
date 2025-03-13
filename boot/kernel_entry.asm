[bits 32]
global _start
_start:
[extern start]
	call start
	jmp $
