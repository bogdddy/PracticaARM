@;-----------------------------------------------------------------------
@;  Description: a program to check the temperature-scale conversion
@;				functions implemented in "CelsiusFahrenheit.c".
@;	IMPORTANT NOTE: there is a much confident testing set implemented in
@;				"tests/test_CelsiusFahrenheit.c"; the aim of "demo.s" is
@;				to show how would it be a usual main() code invoking the
@;				mentioned functions.
@;-----------------------------------------------------------------------
@;	Author: Bogdan Struk && Gonzalo Nieto
@;	Date:   March/2023 
@;-----------------------------------------------------------------------
@;	Programmer 1: bogdan.struk@estudiants.urv.cat
@;	Programmer 2: gonzalo.nieto@estudiants.urv.cat
@;-----------------------------------------------------------------------*/

.data
		.align 2
	temp1C:	.word 0x00119AE1		@; temp1C = 35.21 ºC
	temp2F:	.word 0xFFF42000		@; temp2F = -23.75 ºF

.bss
		.align 2
	temp1F:	.space 4				@; expected conversion:  95.377532958984375 ºF
	temp2C:	.space 4				@; expected conversion: -30.971466064453125 ºC 


.text
		.align 2
		.arm
		.global main
main:
		push {lr}
		
		@; temp1F = Celsius2Fahrenheit(temp1C);
		
		ldr r1, =temp1C				@; R1 = @temp1C
		ldr r0, [r1]				@; R0 = R1
		bl Celsius2Fahrenheit		@; R0 = input -> R0 = output
		ldr r1, =temp1F				@; R1 = @temp1F
		str r0, [r1]				@; R1 = Celsius2Fahrenheit(temp1C)
		
		@; temp2C = Fahrenheit2Celsius(temp2F);
		
		ldr r1, =temp2F				@; R1 = @temp2F
		ldr r0, [r1]				@; R0 = R1
		bl Fahrenheit2Celsius		@; R0 = input -> R0 = output
		ldr r1, =temp2C				@; R1 = @temp2C
		str r0, [r1]				@; R1 = Celsius2Fahrenheit(temp1C)


@; TESTING POINT: check the results
@;	(gdb) p /x temp1F		-> 0x002FB053 
@;	(gdb) p /x temp2C		-> 0xFFF083A7 
@; BREAKPOINT
		mov r0, #0					@; return(0)
		
		pop {pc}

.end

