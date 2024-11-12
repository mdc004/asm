Il candidato scriva un sottoprogramma denominato CONTA_PARI_DISPARI che riceve:
1. nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una sequenza di numeri a 16 bit in complemento a due;
2. nel registro R1 l’indirizzo della cella contenente l’ultimo numero della sequenza di cui al punto 1.
Il sottoprogramma deve restituire:
1. nel registro R0 il conteggio di quanti numeri pari sono presenti nella sequenza;
2. nel registro R1 il conteggio di quanti numeri dispari sono presenti nella sequenza.

Si ricorda che un numero pari codificato in binario ha la caratteristica di avere 0 come cifra di peso $2^0$.

Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

![[Pasted image 20231129111346.png]]
> Funziona ma non è efficiente, bastava fare un `AND` per eliminare tutte le prime 15 cifre e lasciare solo l'ultima che indica il bit di parità.

```LC2
	.orig x3000

;**********************************
; The main program starts here
;**********************************

	lea R0, start
	lea R1, end
	jsr CONTA_PARI_DISPARI
stop	brnzp stop	; system pause

; Here variables and constants of the main program

start	.fill 12
	.fill 22
	.fill 34
	.fill 55
	.fill 123
	.fill 326
	.fill 9320
	.fill 1
end	.fill 179

;**********************************************
; Here starts the subprogram CONTA_PARI_DISPARI
; R2 even counter
; R3 shots counter
;**********************************************

CONTA_PARI_DISPARI	
	st R2, r2data	; save R2 data
	st R3, r3data	; save R3 data
	st R4, r4data	; save R4 data

	and R2, R2, #0	; reset R2 (the even counter)
	and R3, R3, #0	; reset R3 (the shots counter)
	and R4, R4, #0	; reset R4 (temp variable)

	not R1, R1
	add R1, R1, #1

next_i	add R4, R1, R0	; check if the array has been iterated 
	brp sbp_end
	
	ldr R4, R0, #0	; save the [i] element in R4
divide	add R4, R4, #-2
	brp divide
	brz even
	brn shots

even	add R2, R2, #1
	brnzp inc
shots	add R3, R3, #1
	

inc	add R0, R0, #1	; increment the counter
	brnzp next_i	; repeat (loop)	

sbp_end	add R0, R2, #0	; save the even counter in R0
	add R1, R3, #0	; save the shots counter in R1
	ld R2, r2data
	ld R3, r3data
	ld R4, r4data
	ret

;variable and constants of the subprogram
r2data	.blkw 1
r3data	.blkw 1
r4data	.blkw 1

;***********************************
; subprogram ends here
;***********************************
	.end
```

### Soluzione Prof
```LC2
	.orig	x3000

;programma principale
	lea	r0,array
	lea	r1,endarr
	jsr	CONTA_PARI_DISPARI

stop	brnzp	stop

array	.fill	25
	.fill	-2
	.fill	0
	.fill	7
	.fill	-4
endarr	.fill	6

;*************************************************
;sottoprogramma di conteggio numeri pari e dispari

CONTA_PARI_DISPARI
	st	r2,s2
	st	r3,s3
	st	r4,s4

	and	r3,r3,#0	;R3 = contatore numeri pari
	and	r4,r4,#0	;R4 = contatore numeri dispari

	not	r1,r1
	add	r1,r1,#1	;R1 = -indirizzo ultimo elemento array

ciclo	add	r2,r1,r0
	brp	fine

;qui array non finito
	ldr	r2,r0,#0
	and	r2,r2,#1
	brz	pari
;qui numero dispari
	add	r4,r4,#1	;incremento contatore numeri dispari
	brnzp	next
;qui numero pari
pari	add	r3,r3,#1	;incremento contatore numeri pari
next	add	r0,r0,#1
	brnzp	ciclo

fine	add	r0,r3,#0
	add	r1,r4,#0

	ld	r2,s2
	ld	r3,s3
	ld	r4,s4
	ret

;variabili e costanti sottoprogramma

s2	.blkw	1
s3	.blkw	1
s4	.blkw	1

;********************************************************
	.end
```