Il candidato scriva un sottoprogramma denominato CONV_MAIUS che riceve nel registro R0 l’indirizzo della prima cella di una zona di memoria contenente una stringa di caratteri codificati ASCII (un carattere per cella). La stringa è terminata dal valore 0 (corrispondente al carattere NUL).

Il sottoprogramma deve:
	1. convertire tutte le lettere minuscole contenute nella stringa nelle corrispondenti lettere maiuscole;
	2. restituire nel registro R0 il conteggio delle lettere convertite.

Si ricorda che:
- nel codice ASCII, le lettere maiuscole hanno codifiche decimali da “A”=65 a “Z”=90;
- nel codice ASCII, le lettere minuscole hanno codifiche decimali da “a”=97 a “z”=122;
- la differenza numerica fra la codifica ASCII di una lettera minuscola e quella della corrispondente lettera maiuscola espressa in notazione decimale è pari a 32 (quindi per convertire una lettera minuscola nella corrispondente maiuscola basta sottrarre 32 al codice della lettera minuscola).
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.
##### ESEMPIO DI FUNZIONAMENTO DEL SOTTOPROGRAMMA 
***Input***
R0 punta alla zona di memoria contenente la stringa “Buon Lunedi 7 febbraio 2011” 
***Output***
La stringa è diventata “BUON LUNEDI 7 FEBBRAIO 2011” e R0 contiene il valore 16.

```LC2
		.orig x3000

;**********************************
; The main program starts here
;**********************************

	lea R0, string
	jsr CONV_MAIUS
stop	brnzp stop	; system pause

; Here variables and constants of the main program

string	.stringz "CiAo"

;**************************************
; Here starts the subprogram CONV_MAIUS
; the index is saved in R0
;**************************************

CONV_MAIUS	
	st R1, r1data	; save R1 data
	st R2, r2data	; save R2 data
	st R3, r3data	; save R3 data

	and R3, R3, #0	; reset R3 (the counter)

next_c	ldr R1, R0, #0	; save the [i] character in R1

	brz sbp_end	; if the character is 0 return

	ld R2, lower	; load -97
	add R1, R1, R2; chef if the character is already upper
	brn inc

	ld R2, upper	; load 65
	add R1, R1, R2	; convert in upper
	str R1, R0, #0	; store the new character
	add R3, R3, #1	; increment the counter

inc	add R0, R0, #1	; increment the counter
	brnzp next_c	; repeat (loop)	

sbp_end	add R0, R3, #0	; save the counter in R0
	ld R1, r1data
	ld R2, r2data
	ld R3, r3data
	ret

;variable and constants of the subprogram
r1data	.blkw 1
r2data	.blkw 1
r3data	.blkw 1
lower	.fill #-97
upper	.fill #65

;***********************************
; subprogram ends here
;***********************************
	.end
```
### Soluzione Prof
```LC2
.orig	x3000
;programma principale

	lea	r0,testo
	jsr	CONV_MAIUS

stop	brnzp	stop

testo	.stringz	"Data Di Oggi 29 11 23"
;************************************************************
;sottoprogramma di conversione lettere maiuscole in minuscole

CONV_MAIUS
	st	r1,s1
	st	r2,s2
	st	r3,s3
	st	r4,s4
	st	r5,s5
	st	r6,s6

	ld	r2,coda		; -codice a minuscola
	ld	r3,codz		; -codice z minuscola
	ld	r5,minmaiu	; costante conversione da minuscola a maiuscola
	and	r6,r6,#0	;contatore minuscole convertite

ciclo	ldr	r1,r0,#0
	brz	fine
	add	r4,r1,r2
	brn	nominu		;carattere < 97
	add	r4,r1,r3
	brp	nominu		;carattere > 122
;qui è una lettera minuscola
	add	r1,r1,r5	;converte in maiuscola
	str	r1,r0,#0	;SCRIVE IN MEMORIA !!!!!
	add	r6,r6,#1	;incrementa contatore minuscole convertite

;qui comunque
nominu	add	r0,r0,#1
	brnzp	ciclo

fine	add	r0,r6,#0
	ld	r1,s1
	ld	r2,s2
	ld	r3,s3
	ld	r4,s4
	ld	r5,s5
	ld	r6,s6
	ret

;variabili e costanti sottoprogramma
coda	.fill	-97
codz	.fill	-122
minmaiu	.fill	-32
s1	.blkw	1
s2	.blkw	1
s3	.blkw	1
s4	.blkw	1
s5	.blkw	1
s6	.blkw	1

;********************************************************
	.end
```