Scrivere un sottoprogramma che:
- riceve in R0 l’indirizzo del primo elemento di un array di numeri in complemento a due, ordinati per valori crescenti;
- riceve in R1 l’indirizzo dell’ultimo elemento dell’array;
- restituisce l’array con i numeri ordinati per valori decrescenti.
Qualora per la realizzazione del sottoprogramma fosse necessario utilizzare altri registri della CPU, il sottoprogramma stesso deve restituire il controllo al programma chiamante senza che tali registri risultino alterati.

```LC2
	.orig x3000

; The main program starts here
	

	lea R0, str_ar
	lea R1, end_ar
	jsr swap_ar

stop	brnzp	stop

; Here the constant of the program

str_ar	.fill 1
	.fill 2
	.fill 3
end_ar	.fill 4


;***********************************

; Here starts the subprogram num_cmp

; the sum is saved in R1

; the check is saved in R0

;***********************************

swap_ar st R2, r2data	; save r2 data
	st R3, r3data	; save r3 data

; r3 = r1-r0
; r2 = temp
	
next_i	and R2, R2, #0	;reset R2
	and R3, R3, #0	; reset R3
	
	; check if i iterated all the array
	not R3, R0
	add R3, R3, #1 	; save in R3 -R0
	add R3, R3, R1	; R3 = -R0 + R1
	brnz sb_end

	;swap
	and R3, R3, #0	; reset R3, R2 is already zero
	ldr R2, R0, #0	; R2 = val(R0)
	ldr R3, R1, #0	; R3 = val(R1)
	str R3, R0, #0	; write R3 in R0 address
	str R2, R1, #0	; write R2 in R1 address

	;decrement the address
	add R0, R0, #1
	add R1, R1, #-1
	brnzp next_i

sb_end	ld R2, r2data	
	ld R3, r3data	
	ret

r2data	.blkw 1

r3data	.blkw 1


;***********************************

; subprogram ends here

;***********************************

	.end
```