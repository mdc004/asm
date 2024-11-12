Main instructions [here](https://www.cs.uaf.edu/2006/fall/cs301/support/x86/)

To compile: `nasm -f elf64 -o hello.o hello.asm`
Use -f bin for machine code 

To link: `ld hello.o -o hello`

[syscall x86](https://x86.syscall.sh/)

## Simple *Hello, , World!*
```x86-64
section .data
	text db "Hello, World!", 10
section .text
	global_start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, text
	mov rdx, 14
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
```

## Generate assembly code from C
`gcc -g -Wa,-adhln -masm=intel -fverbose-asm sbrkincr.c > sbrkincr.s`

parametri:

The -masm=intel option tell gcc to generate assembly code in intel format (instead of AT&T)
The -adhln options are passed to the assembler since we prefixed it with -Wa. The -adhln options essentially ask the assembler to:
	-enable assembly code listings -a
	- omit debugging directives -d
	- include C source code -h
	- include assembly -l
	- and omit other stuff -n