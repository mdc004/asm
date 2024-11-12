; nasm -f elf -gstabs pp.asm
; to link in 32 bit: ld -I /lib/ld-linux.so.2 -lc -e main -o pp pp.o 
; to link in 64 bit: ld -m elf_i386-linux-gnu/ld-linux.so.2 -lc -e main -o pp pp.o (you need gcc-multilib)

segment .text
	global main
	extern printf

main:
	push msg
	call printf

exit: 
	mov eax, 1
	int 0x80

segment .rodata
msg	db 'Heeeeey', 10, 0
