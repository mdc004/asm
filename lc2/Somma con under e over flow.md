Scrivere un sottoprogramma che riceve in R0 e R1 due numeri num1 e num2 in complemento a due, li somma, restituisce in R1 il risultato e in R0 la seguente indicazione:

- *R0* = -1 se si è verificato underflow
- *R0* = 0 se la somma ha avuto esito corretto
- *R0* = +1 se si è verificato overflow
  
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig x3000

; The main program starts here

	ld R0, num1	;load the first number in R0
	ld R1, num2	;load the second number in R1
	jsr num_cmp
	ld R0, num3	;load the first number in R0
	ld R1, num4	;load the second number in R1
	jsr num_cmp
stop	brnzp	stop

; Here the constant of the program

num1	.fill #-32750
num2	.fill #32753
num3	.fill #-32760
num4	.fill #-10

;***********************************
; Here starts the subprogram num_cmp
; the sum is saved in R1
; the check is saved in R0
;***********************************

num_cmp	st R2, r2data	; saving the r2 content

	add R0, R0, #0
	brn n1neg
	brnzp n1pos

n1neg	add R1, R1, #0
	brp correct	; discordant numbers
	ld R2, min	; loading the +min value in R2
	add R2, R2, R0
	add R2, R2, R1	; +min - num1 - num2 >= 1 (it means positive)
	brp correct	; no underflow
	brnzp undr		


n1pos	add R1, R1, #0
	brn correct	; discordant numbers
	ld R2, max	; loading the -max value in R2
	add R2, R2, R0
	add R2, R2, R1	; 0 >= -max + num1 + num2
	brnz correct	; no overflow
	brnzp ovr		


correct	add R1, R0, R1
	and R0, R0, #0	; reset R0
	brnzp sb_end	

; underflow
undr	add R1, R0, R1
	and R0, R0, #0	; reset R0
	add R0, R0, #-1
	brnzp sb_end

; overflow
ovr	add R1, R0, R1
	and R0, R0, #0	; reset R0
	add R0, R0, #+1

; restoring R2 data and return to main
sb_end 	ld R2, r2data
	ret

;variable and constants of the subprogram
r2data	.blkw 1
max	.fill #-32767
min	.fill #+32767	;this is the opposite of the min value minus 1 because I can't rapresent 32768


;***********************************
; subprogram ends here
;***********************************

	.end
```
**Potenzialmente è cannato perché il massimo numero rappresentabile è $2^{14}$ non $2^{15}$ e quindi 16383 non 32767**.
#### Soluzione del prof
La mia soluzione è giusta, tuttavia fa calcoli inutili, in quanto sarebbe bastato controllare se la somma avesse segno opposto dei due numeri concordi, infatti se discordi, come ho fatto io, non esiste overflow.
```LC2
	.orig	x3000
;programma principale
	ld	r0,n1
	ld	r1,n1
	jsr	addchk
	ld	r0,n1
	ld	r1,n3
	jsr	addchk
	ld	r0,n4
	ld	r1,n5
	jsr	addchk
	ld	r0,n4
	ld	r1,n6
	jsr	addchk
	ld	r0,n1
	ld	r1,n6
	jsr	addchk
stop	brnzp	stop

n1	.fill	30000
n2	.fill	50
n3	.fill	10000
n4	.fill	-30000
n5	.fill	-50
n6	.fill	-10000

;********************************************************
;sottoprogramma di somma con controllo traboccamenti
addchk	and	r0,r0,r0
	brn	num1neg

;qui num1 >= 0
	add	r1,r1,#0
	brzp	concpos
	brn	disc

;qui num1 < 0
num1neg	add	r1,r1,#0
	brn	concneg
	brzp	disc

;qui concordi positivi
concpos	add	r1,r0,r1
	brzp	ok
	brn	over

;qui concordi negativi
concneg	add	r1,r0,r1
	brn	ok
	brzp	under

;qui discordi
disc	add	r1,r0,r1
	brnzp	ok

;qui overflow
over	and	r0,r0,#0
	add	r0,r0,#1
	ret

;qui underflow
under	and	r0,r0,#0
	add	r0,r0,#-1
	ret

;qui okay
ok	and	r0,r0,#0
	ret

;variabili e costanti sottoprogramma
;********************************************************
	.end
```
