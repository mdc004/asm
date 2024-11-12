###### Appello del 19 settembre 2023
Il candidato scriva un sottoprogramma denominato SCAMBIA_COPPIE che riceve:
- nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una stringa di caratteri S codificati in codice ASCII terminata dal valore 0 (corrispondente al carattere NUL);
- nel registro R1 il codice ASCII del carattere C1;
- nel registro R2 il codice ASCII del carattere C2.

Il sottoprogramma deve cercare nella stringa ogni occorrenza della coppia di caratteri adiacenti C1C2, sostituirla con la coppia C2C1 e restituire nel registro R0 il numero di coppie sostituite.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

![[Pasted image 20231205133229.png]]

```LC2
	.orig	x3000

;************************************
;****THE MAIN PROGRAM STARTS HERE****
;************************************

	lea	R0, str1
	ld	R1, c1
	ld	R2, c2
	jsr	SCAMBIA_COPPIE
stop	brnzp	stop

c1	.fill	x69		; i
c2	.fill	x61		; a
str1	.stringz "ciao sono mattiaiaia"

;****SUBPROGRAM SCAMBIA_COPPIE START****

SCAMBIA_COPPIE
	st 	R3, r3data 	;save the R3 content --> R3 is the counter
	st 	R5, r5data 	;save the R3 content --> R5 is the char[index]
	
	and 	R3, R3, #0	;reset R3

	not 	R1, R1
	add 	R1, R1, #1	;invert R1

	not 	R2, R2
	add 	R2, R2, #1	;invert R2

next_c	ldr	R5, R0, #0	;load the character
	brz	end_sb		; if the char is 0 the string ends
	add	R0, R0, #1	;increment R0 (the index)
	add 	R5, R5, R1	;check if R5 is equal to C1 (R5 - C1)
	brnp	next_c		; if not equal try with the next char
	
	ldr	R5, R0, #0	; load the next character
	brz	end_sb		; if the char is 0 the string ends
	add 	R5, R5, R2	; check if R5 is equal to C2 (R5 - C2)
	brnp	next_c		; if not equal try with the next char else swap
	add	R3, R3, #1	; increment R3 (the counter)
	add	R0, R0, #-1	; decrement R0 (the index)
	str	R2, R0, #0	; store C2 in the first position
	add	R0, R0, #1	; increment R0 (the index)
	str	R1, R0, #0	; store C1 in the second position
	brnzp	next_c

end_sb	add 	R0, R3, #0	; saving the counter value in R0
	ld 	R3, r3data	
	ld	R5, r5data
	ret

r3data	.blkw	1
r5data	.blkw	1	

;****SUBPROGRAM SCAMBIA_COPPIE END****
	
	.end

;**********************************
;****THE MAIN PROGRAM ENDS HERE****
;**********************************
```