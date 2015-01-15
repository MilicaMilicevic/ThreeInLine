section .data
format db	'%s',0 ;10 is not needed here!

section .bss
string 	resd	1
current	resb	5 ;three chars + 10 + 0


section .text
extern strlen,printf
global main
main:

push ebp
mov ebp,esp
push ebx
push esi
push edi

push eax	;save address of arguments
pop ebx	
	
mov esi,[ebx+4]

push esi	
call strlen
add esp,4 	;in eax is lenght of second argument

mov ecx,eax
mov edi,string
rep movsb	;string is address of user input (2nd arg)

mov byte[current+3],10
mov byte[current+4],0
 
mov bl,3
div bl

mov edi,0

iterate:
    cmp al,0
    je end
    mov ecx,3
    mov esi,0
    loop_a:	;write in one line
      mov dl,byte[string+edi]	;ex:'a' is in al
      mov byte[current+esi],dl
      inc edi
      inc esi
      loop loop_a  
      jmp print
label_a:
    dec al
    loop iterate

print:
    pushad
    push current
    push format
    call printf
    add esp,8
    popad
    jmp label_a
 
end:
    pop edi
    pop esi
    pop ebx
    mov esp,ebp
    pop ebp
    ret