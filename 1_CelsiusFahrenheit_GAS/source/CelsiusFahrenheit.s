@;----------------------------------------------------------------
@;  CelsiusFahrenheit.s: rutines de conversió de temperatura en 
@;						 format Q15 (Coma Fixa 1:16:15). 
@;-----------------------------------------------------------------------
@;	Author: Bogdan Struk && Gonzalo Nieto
@;	Date:   March/2023 
@;-----------------------------------------------------------------------
@;	Programmer 1: bogdan.struk@estudiants.urv.cat
@;	Programmer 2: gonzalo.nieto@estudiants.urv.cat
@;-----------------------------------------------------------------------*/

.include "Q15.i"	

.text
		.align 2
		.arm

@; Celsius2Fahrenheit(): converteix una temperatura en graus Celsius a la
@;						temperatura equivalent en graus Fahrenheit, utilitzant
@;						valors codificats en Coma Fixa 1:16:15.
@;	Entrada:
@;		input 	-> R0 (TempC)
@;	Sortida:
@;		output	-> R0 = (input * 9/5) + 32.0 (TempF) 
	.global Celsius2Fahrenheit
Celsius2Fahrenheit:
		push {r1-r4, lr}
		
		ldr r1, =0x0000E666				@; R1 -> 9/5 en Q15
		ldr r2, =0x00100000				@; R2 -> 32 en Q15
		
		smull r3, r4, r0, r1			@; R3(Low), R4(High) -> (tempC * 9/5)
		mov r3, r3, lsr #15				@; Ajustem la mult. dividint entre 2^f
		orr r0, r3, r4, lsl #17			@; Combinem el bits alts amb els baixos
		adds r0, r2						@; R0 = (tempC * 9/5) + 32
		
		pop {r1-r4, pc}



@; Fahrenheit2Celsius(): converteix una temperatura en graus Fahrenheit a la
@;						temperatura equivalent en graus Celsius, utilitzant
@;						valors codificats en Coma Fixa 1:16:15.
@;	Entrada:
@;		input 	-> R0 (TempF)
@;	Sortida:
@;		output	-> R0 = (input - 32.0) * 5/9 (TempC)
	.global Fahrenheit2Celsius
Fahrenheit2Celsius:
		push {r1-r4, lr}
		
		ldr r1, =0x0000471C				@; R1 -> 5/9 en Q15
		ldr r2, =0x00100000				@; R2 -> 32 en Q15
		
		sub r0, r0, r2					@; tempC -= 32
		smull r3, r4, r0, r1			@; R3(Low), R4(High) -> (tempC * 5/9)
		mov r3, r3, lsr #15				@; Ajustem la mult. dividint entre 2^f
		orr r0, r3, r4, lsl #17			@; Combinem el bits alts amb els baixos
		
		pop {r1-r4, pc}

