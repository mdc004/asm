Scrivere un sottoprogramma che:
- riceve in R0 un numero in modulo e segno
- restituisce in R0 il numero in complemento a due
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

> hint
> devo partire dal presupposto che anche nel caso del complemento a due il primo bit è a $1$ per i numeri negativi.
> Io so che un numero in modulo e segno in negativo è uguale al positivo, ma con un 1 davanti, ciò che io devo fare è azzerare quel bit davanti e poi convertire il numero, ora positivo, in complemento a due.
> [soluzione](#soluzione)


```LC2
	.orig x3000

;**********************************
; The main program starts here
;**********************************

	ld 	R0, n1
	jsr 	conv_two
	ld 	R0, n2
	jsr 	conv_two
	ld 	R0, n3
	jsr 	conv_two
	ld 	R0, n4
	jsr 	conv_two
	ld 	R0, n5
	jsr 	conv_two
stop	brnzp 	stop		; system pause

; Here variables and constants of the main program

n1	.fill	#0
n2	.fill	#1554
n3	.fill	b1010000000000000
n4	.fill	#1
n5	.fill	#10

;************************************
; Here starts the subprogram conv_two
;************************************

conv_two	
	st 	R1, r1data	; save R1 data
	ld	R1, invert	; load the inverter number

	add 	R0, R0, #0	; trigger the condition code
	brzp 	sbp_end		; if the number is positive or zero return
	and	R0, R0, R1	; invert the number
	not	R0, R0
	add	R0, R0, #1	; two complement the number

sbp_end	ld 	R1, r1data	; restore R1 data
	ret

;variable and constants of the subprogram
r1data	.blkw 	1
invert	.fill 	b0111111111111111

;***********************************
; subprogram ends here
;***********************************
	.end
```
### Soluzione
Mi basta fare un and con un numero con tutti $1$ tranne il primo bit che deve essere a $0$.
```LC2
	 ld R1, mask
	 and R1, R1, R0 ; R1 = R1*(-1)
	 not R1, R1
	 add R1, R1, #1 ; two complement of -(R1)
mask .fill b011111111111111
```
### Soluzione Prof
```LC2
	.orig	x3000

modtoc2	st	r1,s1
	and	r0,r0,r0
	brn	conv		;se primo bit a 1 il numero è negativo
	ret
conv	ld	r1,mask
	and	r0,r1,r0	;azzero primo bit, il numero diventa positivo in complemento a 2
	not	r0,r0
	add	r0,r0,#1	;cambio segno nel mondo del complemento a 2
	ld	r1,s1
	ret

;costanti e variabili
mask	.fill	b0111111111111111
s1	.blkw	1


	.end
```
