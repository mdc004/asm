Il candidato scriva un sottoprogramma denominato CONTA_DOPPIE che riceve:
1. nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente in ciascuna cella il codice ASCII di un carattere di un testo in lingua italiana privo di lettere maiuscole;
2. nel registro R1 l’indirizzo della cella contenente l’ultimo carattere del testo italiano di cui al punto 1.

Il sottoprogramma deve restituire nel registro R0 il numero di "doppie", cioè di coppie di lettere consecutive uguali. Si faccia l'ipotesi che il testo sia "ben formato", cioè non contenga sequenze di lettere uguali di lunghezza maggiore di 2.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

![[Pasted image 20231213111546.png]]
## Soluzione di deca
```LC2
	.orig	x3000

;**********************************
;*****MAIN PROGRAM STARTS HERE*****
;**********************************


	lea	R0, start
	lea	R1, end
	jsr	CONTA_COPPIE
stop	brnzp 	stop


; constants and variables of the main program
start	.fill	#109
	.fill	#97
	.fill	#109
	.fill	#109
	.fill	#97
end	.fill	#97


;*********************************************
;*****SUBPROGRAM CONTA_COPPIE STARTS HERE*****
;*********************************************

CONTA_COPPIE
	st	R2, r2data	; save R2 data ----> R2 is the temp counter
	st	R3, r3data	; save R3 data ----> R3 is the current char
	st	R4, r4data	; save R4 data ----> R4 is the precedent char
	st	R5, r5data	; save R5 data ----> R5 is the temp variable to end the loop

	and	R2, R2, #0	; reset R2
	and 	R3, R3, #0	; reset R3
	and	R4, R4, #0	; reset R4

	not	R1, R1
	add	R1, R1, #1	; R1 = -R1

next_c	add	R5, R0, R1	
	brp	sb_end		; check if the string has been iterated
	ldr	R3, R0, #0	; load the character
	not	R4, R4
	add	R4, R4, #1
	add	R4, R4, R3
	brnp	next
	add	R2, R2, #1	; increment the counter

next	ldr	R4, R0, #0	; save the current char in R4 for the next iteration
	add 	R0, R0, #1	; increment R0 (the index)
	brnzp	next_c	

sb_end	add	R0, R2, #0
	ld	R2, r2data
	ld	R3, r3data
	ld	R4, r4data
	ld	R5, r5data
	ret 

; variables and costants of the subprogram FIBONACCI
r2data	.blkw 1
r3data	.blkw 1
r4data	.blkw 1
r5data	.blkw 1

;*********************************************
;******SUBPROGRAM CONTA_COPPIE ENDS HERE******
;*********************************************

	.end
```