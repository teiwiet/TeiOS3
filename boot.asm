bits 16
org 0x00 
section code
.main:
	mov eax,0x07c0
	mov ds,eax
	mov eax,0xb800 
	mov es,eax
	xor eax,eax
	mov ebx,0
	mov ecx,0
	mov dl,0; value of the char 
.clear:
	mov byte[es:eax],0 
	inc eax 
	mov byte[es:eax],10110000b
	inc eax
	cmp eax,2*25*80 
	jl .clear
mov eax,text
call print_char
print_char:
	mov dl,byte[eax+ebx]
	cmp dl,0 
	je print_end 
	mov byte[es:ecx],dl 
	inc ebx
	inc ecx 
	inc ecx 
	jmp print_char
print_end:
	ret
.end:
	jmp $
text: db "Hello World!",0 
times 510-($-$$) db 0
dw 0xaa55
