@;----------------------------------------------------------------
@;   Operacions aritmètiques de números en format Q15
@;						 
@;----------------------------------------------------------------
@;	Programador/a 1: bogdan.struk@estudiants.urv.cat
@;	Programador/a 2: gonzalo.nieto@estudiants.urv.cat 
@;----------------------------------------------------------------*/

.include "includes/Q15.i"

.text
		.align 2
		.arm

@; add_Q15(): suma dos números en Q15 i indica si hi ha hagut overflow
@;				en cas d'haver overflow retorna els bits baixos
@;
@;	Entrada:
@;		r0 = num1
@;		r1 = num2
@;		r2 = @ de la variable on s'indica l'overflow
@;
@;	Sortida -> r0 = resultat suma
@;
	.global add_Q15
	add_Q15:
		push {r1-r9,lr}
			
			adds r4, r0, r1			@; r4 = num1 + num2 i actualitzem flags
			
			mov r5, #0				@; assumim que no hi ha ov
			movvs r5, #1			@; consultem el flag de ov
			
			strb r5, [r2]			@; guardem ov
			mov r0, r4				@; r0 = result
			
		pop {r1-r9,pc}



@; sub_Q15(): resta dos números en Q15 i indica si hi ha hagut overflow
@;				en cas d'haver overflow retorna els bits baixos
@;
@;	Entrada:
@;		r0 = num1
@;		r1 = num2
@;		r2 = @ de la variable on s'indica l'overflow
@;
@;	Sortida -> r0 = resultat resta
@;
	.global sub_Q15
	sub_Q15:
		push {r1-r5,lr}
		
			subs r4, r0, r1			@; r4 = num1 - num2 i actualitzem flags
			
			mov r5, #0				@; assumim que no hi ha ov
			movvs r5, #1			@; consultem el flag de ov
			
			strb r5, [r2]			@; guardem ov
			mov r0, r4				@; r0 = result
			
		pop {r1-r5,pc}
	
@; mul_Q15(): multiplica dos números en Q15 i indica si hi ha hagut overflow
@;				en cas d'haver overflow retorna els bits baixos
@;
@;	Entrada:
@;		r0 = num1
@;		r1 = num2
@;		r2 = @ de la variable on s'indica l'overflow
@;
@;	Sortida -> r0 = resultat multiplicació
@;
		.global mul_Q15
	mul_Q15:
		push {r1-r9,lr}
		
		@; multiplicació + flags
		smulls r3, r4, r0, r1			@; R3(Low), R4(High) 
		
		mov r5, #0						@; assumim que no hi ha ov
		movvs r5, #1					@; consultem el flag de ov
		strb r5, [r2]					@; guardem ov
		
		@; reduim a 32 bits
		mov r3, r3, lsr #15				@; Ajustem la mult. dividint entre 2^f
		orr r0, r3, r4, lsl #17			@; Combinem el bits alts amb els baixos
		
		
		pop {r1-r9,pc}
	
		.global div_Q15
	div_Q15:
		push {r1-r9,lr}

		pop {r1-r9,pc}
		
	.end