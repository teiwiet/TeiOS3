[bits 16] 
[org 0x7c00] 
switch:
	mov ax,0x4f01 			
	mov cx,0x117
	push dx 
	push dx
	xor dx,dx 
	mov dx,0x0800
	mov es,dx 
	pop dx
	mov di,0x00
	int 0x10
	; make the switch to graphics mode 
	mov ax,0x4f02 
	mov bx,0x117 
	int 0x10
	
	xor ax,ax 
	mov ds,ax 
	mov es,ax 

	mov bx,0x1000 			; location where the code load from hard disk
	mov ah,0x02 
	mov al,1				; number of sector to read from hard disk 
	mov ch,0x00
	mov dh,0x00
	mov cl,0x02
	int 0x13

	cli  					; clear the the interrupt
	lgdt[gdt_descriptor] 	; load the address to GDTR register 
	mov eax,cr0 
	or eax,1
	mov cr0,eax				; make the switch
	jmp code_seg:protected_start 
[bits 32]
protected_start:
	mov ax,data_seg 
	mov ds,ax 
	mov es,ax 
	mov ss,ax 
	mov fs,ax 
	mov gs,ax 

	mov ebp,0x90000 	; update the stack pointer
	mov esp,ebp

	call 0x1000
	jmp $ 
gdt_begin:
gdt_null:
	dd 0x00 
	dd 0x00 
gdt_code_seg:
	dw 0xffff 
	dw 0x00 
	db 0x00 
	db 10011010b
	db 11001111b
	db 0x00 
gdt_data_seg:
	dw 0xffff 
	dw 0x00 
	db 0x00 
	db 10010010b
	db 11001111b
	db 0x00 
gdt_end:
gdt_descriptor:
	dw gdt_end - gdt_begin - 1
	dd gdt_begin 
code_seg equ gdt_code_seg - gdt_begin 
data_seg equ gdt_data_seg - gdt_begin 
text: db "hello world",0
times 510-($-$$) db 0 
db 0x55 
db 0xaa
