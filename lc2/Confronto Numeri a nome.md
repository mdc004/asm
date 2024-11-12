Scrivere un sottoprogramma che riceve in *R1* e *R2* due numeri *num1* e *num2* in complemento a due, li confronta, restituisce in *R0* la seguente indicazione:

- *R0* = -1 se *num1* < *num2*
- *R0* = 0 se *num1* = *num2*
- *R0* = +1 se *num1* > *num2*

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig	x3000
	ld	r1,n1
	ld	r2,n2
	jsr	ese1
	ld	r1,n1
	ld	r2,n1
	jsr	ese1
	ld	r1,n2
	ld	r2,n1
	jsr	ese1
	ld	r1,n3
	ld	r2,n3
	jsr	ese1
	ld	r1,n3
	ld	r2,n3
	jsr	ese1
	ld	r1,n4
	ld	r2,n3
	jsr	ese1
stop	brnzp	stop

;qui variabili e costanti del sottoprogramma
n1	.fill	12
n2	.fill	7
n3	.fill	-9
n4	.fill	-4

;*************************************************************
;qui inizia il sottoprogramma
;istruzioni assembly del sottoprogramma

ese1	st	r3,salvar3

	not	r2,r2
	add	r2,r2,#1	;R2 = -num2
	add	r3,r1,r2	;R3 = num1-num2
	brn	num2mag
	brz	uguali

;qui num1 > num2
	and	r0,r0,#0
	add	r0,r0,#1
	brnzp	fine

;qui num1 < num2
num2mag	and	r0,r0,#0
	add	r0,r0,#-1
	brnzp	fine

;qui num1 = num2
uguali	and	r0,r0,#0

fine	ld	r3,salvar3
	ret
;qui costanti e variabili del sottoprogramma
salvar3	.blkw	1

;qui finisce il sottoprogramma
;*******************************************************************

	.end
```

#### Esercizio Confronto Numeri con Indirizzi
Scrivere un sottoprogramma che riceve in *R1* e *R2* gli indirizzi di due celle di memoria contenenti due numeri *num1* e *num2* in complemento a due, li confronta, restituisce in R0 la seguente indicazione:

- *R0* = -1 se *num1* < *num2*
- *R0* = 0 se *num1* = *num2*
- *R0* = +1 se *num1* > *num2*
  
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig	x3000
	lea	r1,n1
	lea	r2,n2
	jsr	ese1
	lea	r1,n1
	lea	r2,n1
	jsr	ese1
	lea	r1,n2
	lea	r2,n1
	jsr	ese1
	lea	r1,n3
	lea	r2,n3
	jsr	ese1
	lea	r1,n3
	lea	r2,n3
	jsr	ese1
	lea	r1,n4
	lea	r2,n3
	jsr	ese1
stop	brnzp	stop

;qui variabili e costanti del sottoprogramma
n1	.fill	12
n2	.fill	7
n3	.fill	8
n4	.fill	-4

;*************************************************************
;qui inizia il sottoprogramma
;istruzioni assembly del sottoprogramma

ese1	
	ldr R1, R1, #0
	ldr R2, R2, #0

	not	r2,r2
	add	r2,r2,#1	;R2 = -num2
	add	r0,r1,r2	;R3 = num1-num2
	brn	num2mag
	brz	uguali

;qui num1 > num2
	and	r0,r0,#0
	add	r0,r0,#1
	brnzp	fine

;qui num1 < num2
num2mag	and	r0,r0,#0
	add	r0,r0,#-1
	brnzp	fine

;qui num1 = num2
uguali	and	r0,r0,#0

fine	ret
;qui costanti e variabili del sottoprogramma
salvar3	.blkw	1

;qui finisce il sottoprogramma
;*******************************************************************

	.end
```

#### Esercizio Confronto Numeri con Indirizzi di Indirizzi
Scrivere un sottoprogramma che riceve in *R1* e *R2* gli indirizzi di due celle di memoria contenenti gli indirizzi di altre due celle di memoria contenenti a loro volta due numeri *num1* e *num2* in complemento a due, li confronta, restituisce in R0 la seguente indicazione:

- *R0* = -1 se *num1* < *num2*
- *R0* = 0 se *num1* = *num2*
- *R0* = +1 se *num1* > *num2*

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il
sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino
alterati.

```
	.orig	x3000
	lea	r1,n1
	lea	r2,n2
	jsr	ese1
	lea	r1,n1
	lea	r2,n1
	jsr	ese1
	lea	r1,n2
	lea	r2,n1
	jsr	ese1
	lea	r1,n3
	lea	r2,n3
	jsr	ese1
	lea	r1,n3
	lea	r2,n3
	jsr	ese1
	lea	r1,n4
	lea	r2,n3
	jsr	ese1
stop	brnzp	stop

;qui variabili e costanti del sottoprogramma
n11	.fill	12
n22	.fill	7
n33	.fill	8
n44	.fill	-4
n1	.fill	n11
n2	.fill	n22
n3	.fill	n33
n4	.fill	n44


;*************************************************************
;qui inizia il sottoprogramma
;istruzioni assembly del sottoprogramma

ese1	
	ldr R1, R1, #0
	ldr R2, R2, #0
	ldr R1, R1, #0
	ldr R2, R2, #0

	not	r2,r2
	add	r2,r2,#1	;R2 = -num2
	add	r0,r1,r2	;R3 = num1-num2
	brn	num2mag
	brz	uguali

;qui num1 > num2
	and	r0,r0,#0
	add	r0,r0,#1
	brnzp	fine

;qui num1 < num2
num2mag	and	r0,r0,#0
	add	r0,r0,#-1
	brnzp	fine

;qui num1 = num2
uguali	and	r0,r0,#0

fine	ret
;qui costanti e variabili del sottoprogramma
salvar3	.blkw	1

;qui finisce il sottoprogramma
;*******************************************************************

	.end
```
