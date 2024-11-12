section .data
msg1	db	'Please enter your name: ', 0
msg2	db 	'Hello ', 0

section .bss
name	resb	255

section	.text
global	_start

_start:
	; Print message asking for name
	mov     eax, msg1
	call 	print	

	; Get user input
	mov	eax, name
	call	input

	; Print greeting message
	mov	eax, msg2
	call	print

	; Print the name
	mov	eax, name
	call	print

	; Exit the program
        mov     ebx, 0
        mov     eax, 1
        int     80h

print:	
	mov	edx, 255


	mov     edx, eax   ; move the memory address of our message string into ecx
loop:	
	cmp 	byte [edx], 0
	jz	len_end
	inc 	edx
	jmp	loop

len_end:
	sub	edx, eax
	mov	ecx, eax
    	mov     ebx, 1     ; write to the STDOUT file
    	mov     eax, 4     ; invoke SYS_WRITE (kernel opcode 4)
    	int     80h
	ret

input:
        mov	edx, 255
        mov     ecx, eax
        mov     ebx, 0
        mov     eax, 3
        int     80h
        ret