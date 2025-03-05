[bits 16]
[org 0x00]
main:
	mov eax,0x07c0
	mov ds,eax 
	mov eax,0xb800
	mov es,eax 
	xor ebx,ebx 
	xor ecx,ecx 
	xor dl,dl 
	xor eax,eax
clear_screen:
	mov byte[es:eax],0
	inc eax 
	mov byte[es:eax],10110000b
	inc eax 
	cmp eax,2*25*80 
	jl clear_screen 
mov eax,text 
call print_char
end:
	jmp $
print_char:
	mov dl,byte[eax+ebx]
	cmp dl,0 
	je print_end 
	mov byte[es:ecx],dl 
	inc ecx 
	mov byte[es:ecx],0x7
	inc ecx 
	inc ebx
	jmp print_char
print_end:
	ret

text: db "Hello World!",0
times 510-($-$$) db 0 
db 0x55 
db 0xaa 
