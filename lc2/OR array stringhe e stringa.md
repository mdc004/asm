Il candidato scriva un sottoprogramma denominato OR_ARRAY che riceve:
1. nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una sequenza di stringhe di 16 bit ciascuna; la stringa costituita da tutti zeri è il terminatore della sequenza e non va considerata;
2. nel registro R1 una stringa di 16 bit.
Il sottoprogramma deve sostituire a ogni stringa dell’array l’OR (somma logica) tra la stringa presente nell’array e la stringa ricevuta in R1. Si ricorda che per il teorema di De Morgan:

![[Pasted image 20231129115411.png]]
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

![[Pasted image 20231129115453.png]]

```LC2
	.orig	x3000
;*************************
; MAIN PROGRAM STARTS HERE
;*************************

	lea	R0, array	; loading the address of the first element of the array
	ld	R1, string	; loading the string in R1

	jsr	OR_ARRAY
stop	brnzp	stop		; loop here


array	.fill	b1010101010101010
	.fill	#0

string	.fill	#0


;********************************
; SUBPROGRAM OR_ARRAY STARTS HERE
;********************************

OR_ARRAY
	st	R2, r2data	; saving R2 data
	
	not	R1, R1		; inversing the string for the de morgan theoreme	

next_i	ldr	R2, R0, #0	; loading from memory the next string
	brz	sb_end		; checking if the string is zero, in this case the program end

	not	R2, R2		; inversing R2 for the de morgan theoreme
	and	R2, R1, R2	; saving the OR of R1 (the base string) and R2 (the array i string)
	not	R2, R2		; inverting R2 for the de morgan theoreme
	str	R2, R0, #0	; storing the result in the array, so in R0 address
	add	R0, R0, #0	; increment the index
	brnzp	next_i

sb_end	ld	R2, r2data	; restoring R2 content
	ret


; variables and constants of the subprogram

r2data	.blkw	#1
;********************************
; SUBPROGRAM OR_ARRAY STARTS HERE
;********************************

	.end
```
