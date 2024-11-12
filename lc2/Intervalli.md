Il candidato scriva un sottoprogramma denominato INTERVALLI_ASS che riceve:
1. nel registro R0 l’indirizzo del primo elemento dell’array A di numeri a 16 bit in complemento a due; il valore zero è il “tappo” finale dell’array;
2. nei registri R1 e R2 due numeri N1 e N2 in complemento a due entrambi positivi, con N1.

Il sottoprogramma deve restituire:
- in R0 il numero di elementi │A(i)│ < N1 (ovvero gli elementi in valore assoluto minori N1;
- in R1 il numero di elementi A(i) per i quali vale N1 ≤ │A(i)│ ≤ N2
- in R2 il numero di elementi │A(i)│ > N2.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.
![[Pasted image 20240110123843.png]]
## Soluzione

```LC2
	.orig	x3000

; Main program

	lea	R0, arr
	ld	R1, n1
	ld	R2, n2
	jsr	INTERVALLI_ASS

stop	brnzp	stop	; stay here

;variables

n1	.fill	#8
n2	.fill 	#87
arr	.fill	#1
	.fill	#2
	.fill	#123
	.fill	#24
	.fill	#13
	.fill	#15
	.fill	#44
	.fill	#23
	.fill	#16
	.fill	#145
	.fill	#1
	.fill	#154
	.fill	#0


;*****************************************
;**Subprogram INTERVALLI_ASS starts here**
;*****************************************

; R3 --> R0 : arr[i] < N1 (min)	
; R4 --> R1 : N1 < arr[i] < N2
; R5 --> R2 : arr[i] > N2 (max)
; R6 the result of the sum

INTERVALLI_ASS
	
	st	R3, r3data	; load R3 data
	st	R4, r4data	; load R4 data
	st	R5, r5data	; load R5 data
	st	R6, r6data	; load R6 data

	not	R1, R1
	add	R1, R1, #1	; R1 --> -R1

	not	R2, R2
	add 	R2, R2, #1	; R2 --> -R2

next_i	ldr	R6, R0, #0	; load the arr[i] element
	brz	sb_end		; the array has been iterated

	add	R6, R6, R1	
	brn	neg		; arr[i] < N1
	
	ldr	R6, R0, #0
	add	R6, R6, R2	
	brp	pos		; arr[i] > N2
	brnzp	btw		; N1 < arr[i] < N2

neg	add	R3, R3, #1	; increment min counter
	brnzp 	incr		; increment index
pos	add	R5, R5, #1	; increment max counter
	brnzp 	incr		; increment index
btw	add	R4, R4, #1	; increment between counter

incr	add	R0, R0, #1	; increment the index
	brnzp	next_i

sb_end	add	R0, R3, #0	; store the min counter
	add	R1, R4, #0	; store the between counter
	add	R2, R5, #0	; store the max counter

	ld	R3, r3data	; load R3 data
	ld	R4, r4data	; load R4 data
	ld	R5, r5data	; load R5 data
	ld	R6, r6data	; load R6 data

	ret
; variables and costants of the subprogram

r3data	.blkw	#1
r4data	.blkw	#1
r5data	.blkw	#1
r6data	.blkw	#1

;*****************************************
;***Subprogram INTERVALLI_ASS ends here***
;*****************************************

	.end
```
