###### Appello del 4 luglio 2023
Il candidato scriva un sottoprogramma denominato PAR_PARI che riceve nel registro R0 la codifica a 16 bit di una informazione di cui calcolare la parità pari.

Il sottoprogramma deve restituire nel registro R1 il bit di parità pari, cioè il valore 0 se il numero di uni presenti nella codifica ricevuta in ingresso è pari, il valore 1 se il numero di uni presenti nella codifica ricevuta in ingresso è dispari.

Il sottoprogramma deve restituire nel registro R1 il bit di parità pari, cioè il valore 0 se il numero di uni presenti nella codifica ricevuta in ingresso è pari, il valore 1 se il numero di uni presenti nella codifica ricevuta in ingresso è dispari.
- moltiplicare per 2 un numero binario significa spostare di un posto a sinistra tutti i suoi bit e inserire un bit di valore 0 nella posizione meno significativa;
- moltiplicare per 2 un numero binario contenente un solo 1 corrisponde a spostare di un posto a sinistra tale 1.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig	x3000

	ld	R0, data1
	jsr 	PAR_PARI

stop	brnzp	stop

data1	.fill	b0000000000000000


;***************************
;*** SUBPROGRAM PAR_PARI ***
;***************************
; R0 data
; R1 counter
; R2 ander
; R3 
PAR_PARI 
	st	R2, r2data
	st	R3, r3data
	and	R1, R1, #0	; reset R1
	and	R2, R2, #0	; reset R2
	add 	R2, R2, #1	; inizialize R2 to 1 

next	and	R3, R2, R0
	brz	incr
	add	R1, R1, #1	; if the and result is 1 increment the counter
incr	add	R2, R2, R2	;add a 0 at the end of the ander
	brz	sb_end		;check if executed for 16 times
	brnzp	next		; else check the next bit

sb_end	ld 	R2, r2data
	ld 	R3, r3data
	and	R1, R1, #1	; check if the counter is even or shots
	ret

r2data	.blkw 1

r3data	.blkw 1


;***************************
;*** SUBPROGRAM END ********
;***************************

.end
```