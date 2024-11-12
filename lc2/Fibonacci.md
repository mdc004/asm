Il candidato scriva un sottoprogramma denominato FIBONACCI che riceve nel registri R0 il numero intero N e che restituisce sempre in R0 il termine N-esimo FN della sequenza di Fibonacci.

Si ricorda che il termine N-esimo della sequenza di Fibonacci è dato da: $F_N = F_{N-1} + F_{N-2}$ con $F_1 = 1$ e $F_2 = 1$. Si faccia inoltre l’ipotesi che sia $F_N = 0$ per $N ≤ 0$.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.
### ESEMPI DI FUNZIONAMENTO DEL SOTTOPROGRAMMA
| | Input | Output |
| --- | :---: | :---: |
| R0 | 10 | 55 |
| R0 | 2 | 1 |
| R0 | -4 | 0 |

## Soluzione di deca
```LC2
	.orig	x3000

;**********************************
;*****MAIN PROGRAM STARTS HERE*****
;**********************************


	ld	R0, test1
	jsr	FIBONACCI
stop	brnzp 	stop


; constants and variables of the main program
test1	.fill	#2


;******************************************
;*****SUBPROGRAM FIBONACCI STARTS HERE*****
;******************************************

FIBONACCI
	st 	R1, r1data	; save R1 data
	st	R2, r2data	; save R2 data
	st	R3, r3data	; save R3 data
		
	add	R0, R0, #0	; trigger the CC
	brnz	return0		; check if R0 is 0 or less

	add 	R1, R0, #-1	; check if R0 is 1
	brz	return1

	add	R1, R0, #-2	; check if R0 is 2
	brz	return1

;R1 = Fn-1
;R2 = Fn-2
;R3 = n
	and 	R1, R1, #0
	add	R1, R1, #1
	and	R2, R2, #0
	add	R2, R2, #1
	add	R3, R0, #-2

next_i	brz	sb_end
	add	R0, R1, R2
	add	R2, R1, #0	; R2 -> Fn-2 (R1)
	add	R1, R0, #0	; R1 -> Fn-1 (R0)
	add	R3, R3, #-1	; n = n-1
	brnzp	next_i	

return0	and 	R0, R0, #0	; set the return value to 0
	brnzp	sb_end

return1	and	R0, R0,	#0
	add	R0, R0, #1	; set the return value to 1

sb_end	ld	R1, r1data
	ld	R2, r2data
	ld	R3, r3data
	ret 

; variables and costants of the subprogram FIBONACCI
r1data	.blkw 1
r2data	.blkw 1
r3data	.blkw 1

;******************************************
;******SUBPROGRAM FIBONACCI ENDS HERE******
;******************************************

	.end
```
## Soluzione prof
```LC2
	.orig	x3000

;qui istruzioni assembly del programma principale

	ld	r0,n1
	jsr	FIBONACCI
	ld	r0,n2
	jsr	FIBONACCI
	ld	r0,n3
	jsr	FIBONACCI

stoqui	brnzp	stoqui

;qui costanti e variabili del programma principale
n1	.fill	-4
n2	.fill	2
n3	.fill	10

;************************************************
;qui inizia il sottoprogramma - istruzioni assembly del sottoprogramma
FIBONACCI
	add	r0,r0,#0
	brnz	zero
;qui N > 0
	add	r0,r0,#-2
	brnz	uno

;qui N > 2, inizio il calcolo
	st	r1,sr1
	st	r2,sr2
	st	r3,sr3

	and	r1,r1,#0
	add	r1,r1,#1	;R1 = F(2) -> sar� F(N-1)
	add	r2,r1,#0	;R2 = F(1) -> sar� F(N-2)

ciclo	add	r3,r1,r2	;R3 = F(N)
	add	r0,r0,#-1
	brz	fine
;qui non ho ancora finito
	add	r2,r1,#0	;F(N-2) = precedente F(N-1)
	add	r1,r3,#0	;F(N-1) = precedente F(N)
	brnzp	ciclo

;qui restituire zero
zero	and	r0,r0,#0
	ret

;qui restituire uno
uno	and	r0,r0,#0
	add	r0,r0,#1
	ret

;qui fine normale
fine	add	r0,r3,#0
	ld	r1,sr1
	ld	r2,sr2
	ld	r3,sr3

	ret

;variabili e costanti del sottoprogramma
sr1	.blkw	1
sr2	.blkw	1
sr3	.blkw	1
;************************************************

	.end
```