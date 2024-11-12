Scrivere un sottoprogramma che:
- riceve in R0 l’indirizzo del primo elemento di un array di numeri in modulo e segno diversi da zero (lo zero costituisce il tappo finale dell’array)
- restituisce in R0 il risultato (in modulo e segno) della sommatoria di tutti i numeri dell’array, trascurando eventuali traboccamenti

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.


```LC2
	.orig	x3000
; MAIN PROGRAM START HERE
	
	lea	R0, ar
	jsr	sommatoria
stop	brnzp	stop

ar	.fill	10
	.fill 	-20
	.fill	30
	.fill	0

; SUBPROGRAM sommatoria
	
sommatoria
	
	st 	R1, r1data	; R1 is the current element
	st	R2, r2data	; R2 is the sum
	and	R2, R2, #0	; reset R2

next_i	ldr	R1, R0, #0	; load i element
	brz	sb_end		; if the element is 0 end the sub program
	add	R2, R2, R1	; add R1 to the sum
	add	R0, R0, #1	; increment the index
	brnzp	next_i		; reiterating the cicle


sb_end	add	R0, R2, #0	; saving the sum in R0
	ld	R1, r1data
	ld	R2, r2data
	ret
		



;variables and constant of the subprogram

r1data	.blkw	1
r2data	.blkw	1

	.end	

```
