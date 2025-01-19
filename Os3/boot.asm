org 0x7c00 
bits 16 

section code
init:
	mov eax,0xb800
	mov es,eax 
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor dl,dl
clear:
	mov byte[es:eax],0x0 
	inc eax
	mov byte[es:eax],0xb0 
	inc eax 
	cmp eax,2*25*80 
	jl clear 
call print
jmp switch
print_end:
	ret
print:
	mov eax,text
	mov dl,byte[eax+ebx]
	mov byte[es:ecx],dl
	inc ecx 
	inc ecx 
	inc ebx
	cmp dl,0 
	je print_end
	jmp print

end:
jmp $

switch:
	cli 
	lgdt [gdt_descriptor]
	mov eax,cr0
	or eax,0x1
	mov cr0,eax 
	jmp protected_start
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
