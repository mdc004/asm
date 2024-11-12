Scrivere un sottoprogramma che: 
- riceve in R0 l’indirizzo del primo elemento di un array A di numeri in complemento a due diversi da zero; la prima occorrenza del valore 0 costituisce il “tappo” dell’array, cioè ne indica la fine; 
- riceve in R1 un numero N in complemento a due; 
- restituisce in R0 l’indice I di N in A, cioè la posizione di N partendo da 1. Se il numero N non è presente in A, viene restituito il valore 0. 
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig x3000
; The main program starts here

	lea R0, array
	ld R1, n
	jsr find_n
stop	brnzp stop	; system pause

n	.fill #44
array	.fill #54
	.fill #113
	.fill #445
	.fill #44
	.fill #0

;**********************************
; Here starts the subprogram find_n
; the index is saved in R0
;**********************************

; R2 is array[i] element
; R3 is i, the index 
find_n	st R2, r2data	; save r2 data
	st R3, r3data	; save r3 data
	and R3, R3, #0	; reset R3
	add R3, R3, R0	; inizialize R3 = R0

	not R1,R1	
	add R1,R1,#1	; two complement of N: N became -N
next_i	and R2, R2, #0	; reset R2 (array[i])
	ldr R2, R3, #0	; load the array[i] element in R2
	brz rtn_0	; if array[i] si zero it means I didnt find N so i return 0
	add R2,R2,R1	; array[i] - n
	brz rtn_i	; if the sum is 0 they are equal so I return i
	add R3, R3, #1	; increment i
	brnzp next_i	; if they are different I increment i

rtn_i	not R0,R0	
	add R0,R0,#1	; R0 became -R0
	add R0, R0, R3	; save i in R0 (-R0 + R3 where R3 is the index) 
	add R0, R0, #1
	brnzp sbp_end

rtn_0	and R0, R0, #0	; reset R0	

sbp_end	ld R2, r2data
	ld R3, r3data	
	ret

;variable and constants of the subprogram
r2data	.blkw 1
r3data	.blkw 1
;***********************************
; subprogram ends here
;***********************************
	.end
```
### Cerca n in un array senza tappo
Scrivere un sottoprogramma che: 
- riceve in R0 l’indirizzo del primo elemento di un array A di numeri in complemento a due;
- riceve in R1 l’indirizzo dell’ultimo elemento dell’array; 
- riceve in R2 un numero N in complemento a due; 
- restituisce in R0 l’indice I di N in A, cioè la posizione di N partendo da 1. Se il numero N non è presente in A, viene restituito il valore 0. 

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

Da rifare brutto down, potevi semplicemente modificare la 1 e invece no, ti diverti a fare il figo, ora modifichi la 1 e trovi l'errore nella nuova variante 2

```LC2
		.orig x3000
; The main program starts here

	lea R0, array
	lea R1, arr_and
	ld R2, n
	jsr find_n
stop	brnzp stop	; system pause

n	.fill #44
array	.fill #54
	.fill #113
	.fill #445
	.fill #44
arr_end	.fill #144

;**********************************
; Here starts the subprogram find_n
; the index is saved in R0
;**********************************
; R0 is the first element address
; R1 is the last element address, in this subprogram became the index (i)                                            
; R2 is the N
; R3 is the array[i] element
; I Start from the end of the array, decrementing R1, to find the position of the element: R1 - R0

; R2 is array[i] element
; R3 is i, the index (the address, not 0,1,2...)


find_n	st R3, r3data	; save r3 data
	st R4, r4data	; save r4 data
	and R4, R4, #0	; reset R4
	not R4, R0	; save notR0 in R4
	add R4, R4, #1
	st R4, r4v
	and R3, R3, #0	; reset R3
	add R3, R3, R0	; inizialize R3 = R0

	not R2,R2	
	add R2,R2,#1	; two complement of N: N became -N

next_i	and R3, R3, #0	; reset R3 (array[i])
	ldr R3, R1, #0	; load the array[i] element in R3
	add R3, R3, R2	; array[i] = array[i] - n
	brz rtn_i	; if the sum is 0 they are equal so I return i
	add R4, R4, R3	; R4 + R3 --> R4 = -R1
	brz rtn_0	; if R0 = R1 it means I didnt find R2 (N) so I return 0
	and R4, R4, #0	; reset R4
	ld R4, r4v	; R4 = R4 = -R0
	add R1, R1, #-1	; decrement R1 (i)
	brnzp next_i	; if they are different I increment i

rtn_i	add R0, R4, R1	; save i in R0 (-R0 (R4) + R1 where R1 is the index) 
	add R0, R0, #1
	brnzp sbp_end

rtn_0	and R0, R0, #0	; reset R0	

sbp_end	ld R3, r3data
	ld R4, r4data	
	ret

;variable and constants of the subprogram
r2data	.blkw 1
r3data	.blkw 1
r4data	.blkw 1
r4v	.blkw 1
;***********************************
; subprogram ends here
;***********************************
	.end
```
### Soluzioni prof
#### variante 1
```LC2
	.orig	x3000
;programma principale
	lea	r0,array
	ld	r1,n1
	jsr	findN
	lea	r0,array
	ld	r1,n2
	jsr	findN
	lea	r0,array
	ld	r1,n3
	jsr	findN
	lea	r0,array
	ld	r1,n4
	jsr	findN

stop	brnzp	stop

array	.fill	12
	.fill	-9
	.fill	4
	.fill	5
	.fill	0

n1	.fill	12
n2	.fill	4
n3	.fill	5
n4	.fill	13


;********************************************************
;sottoprogramma di somma con controllo traboccamenti
findN	st	r3,savr3
	st	r4,savr4

	not	r1,r1
	add	r1,r1,#1	;R1 = -N
	and	r4,r4,#0
	add	r4,r4,#1	;R4 = I

ciclo	ldr	r3,r0,#0
	brz	nontrov		;A(I) = 0 quindi N non trovato

;qui A(I) <> 0
	add	r3,r3,r1
	brz	trov

;qui A(I) <> N
	add	r0,r0,#1
	add	r4,r4,#1	;I = I+1
	brnzp	ciclo

;qui non trovato
nontrov	and	r0,r0,#0
	brnzp	fine

;qui trovato
trov	add	r0,r4,#0

;qui comunque
fine	ld	r3,savr3
	ld	r4,savr4

	ret

;variabili e costanti sottoprogramma

savr3	.blkw	1
savr4	.blkw	1

;********************************************************
	.end
```
#### Variante 2
```LC2
	.orig	x3000
;programma principale
	lea	r0,array
	lea	r1,endarr
	ld	r2,n1
	jsr	findN
	lea	r0,array
	lea	r1,endarr
	ld	r2,n2
	jsr	findN
	lea	r0,array
	lea	r1,endarr
	ld	r2,n3
	jsr	findN
	lea	r0,array
	lea	r1,endarr
	ld	r2,n4
	jsr	findN

stop	brnzp	stop

array	.fill	12
	.fill	-9
	.fill	4
	.fill	5
	.fill	0
	.fill	-7
endarr	.fill	8

n1	.fill	12
n2	.fill	0
n3	.fill	8
n4	.fill	13


;********************************************************
;sottoprogramma di somma con controllo traboccamenti
findN	st	r3,savr3
	st	r4,savr4

	not	r1,r1
	add	r1,r1,#1	;R1 = -indirizzo fine array

	not	r2,r2
	add	r2,r2,#1	;R2 = -N

	and	r4,r4,#0
	add	r4,r4,#1	;R4 = I

ciclo	add	r3,r0,r1
	brp	nontrov		;qui R0 > R1 quindi N non trovato
	ldr	r3,r0,#0

;qui A(I) <> 0
	add	r3,r3,r2
	brz	trov

;qui A(I) <> N
	add	r0,r0,#1
	add	r4,r4,#1	;I = I+1
	brnzp	ciclo

;qui non trovato
nontrov	and	r0,r0,#0
	brnzp	fine

;qui trovato
trov	add	r0,r4,#0

;qui comunque
fine	ld	r3,savr3
	ld	r4,savr4

	ret

;variabili e costanti sottoprogramma

savr3	.blkw	1
savr4	.blkw	1

;********************************************************
	.end
```