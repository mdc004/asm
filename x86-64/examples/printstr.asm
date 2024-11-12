SECTION .data
msg     db      'Hello solab2 World!', 0Ah    ; assign msg variable with your message string
 
SECTION .text
global  _start
 
_start:
 
    mov     ecx, msg    ; number of bytes to write - one for each letter plus 0Ah (line feed character)
    mov     edx, ecx

loop:    
    cmp     byte [edx], 0
    jz      end
    inc	    edx
    jmp     loop
    
end:
    sub     edx, ecx
    inc     edx

    mov     ecx, msg   ; move the memory address of our message string into ecx
    mov     ebx, 1     ; write to the STDOUT file
    mov     eax, 4     ; invoke SYS_WRITE (kernel opcode 4)
    int     80h

exit:
    mov	    ebx, 0	; exit without errors
    mov     eax, 1	; sys call number for exit
    int     80h