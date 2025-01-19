org 0x7c00 
bits 16 
section code

switch:
	mov bx,0x1000 	; location where the code is loaded from hard disk 
	mov ah,0x02 
	mov al,30  	; the number of the sectors to read from hard disk 
	mov ch,0x00 
	mov dh,0x00 
	mov cl,0x02 
	int 0x13

	cli 
	lgdt [gdt_descriptor]
	mov eax,cr0
	or eax,0x1
	mov cr0,eax 
	jmp code_seg:protected_start
[bits 32] 
protected_start:
	mov ax,data_seg 
	mov ds,ax
	mov ss,ax
	mov gs,ax
	mov fs,ax
	mov es,ax

	; update the stack 
	mov ebp,0x90000
	mov esp,ebp
	
	call 0x1000
	jmp $
gdt_begin:
gdt_null:
	dd 0x00 
	dd 0x00 
gdt_code_seg:
	dw 0xffff
	dw 0x0000 
	db 0x00 
	db 10011010b
	db 11001111b
	db 0x00
gdt_data_seg:
	dw 0xffff
	dw 0x0000 
	db 0x00 
	db 10010010b
	db 11001111b
	db 0x00
gdt_end:
gdt_descriptor:
	dw gdt_end - gdt_begin -1 
	dd gdt_begin 
code_seg equ gdt_code_seg - gdt_begin 
data_seg equ gdt_data_seg - gdt_begin 
text: db "Hello World",0
text1: db "This is another text",0
times 510-($-$$) db 0 
db 0x55
db 0xaa 
