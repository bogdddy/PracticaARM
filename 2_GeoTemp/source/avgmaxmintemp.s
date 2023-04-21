@;----------------------------------------------------------------
@;  CelsiusFahrenheit.s: rutines de conversió de temperatura en 
@;						 format Q15 (Coma Fixa 1:16:15). 
@;----------------------------------------------------------------
@;	Programador/a 1: bogdan.struk@estudiants.urv.cat
@;	Programador/a 2: gonzalo.nieto@estudiants.urv.cat 
@;----------------------------------------------------------------*/

.include "include/avgmaxmintemp.i"

.text
		.align 2
		.arm
		
@; avgmaxmin_city(): calcula la temperatura mitjana, màxima i mínima d'una
@;				ciutat d'una taula de temperatures, amb una fila per ciutat i
@;				una columna per mes, expressades en graus Celsius en format Q15.
@;
@;	Entrada:
@;		r0 = ttemp[][12]	->	taula de temperatures, amb 12 columnes i nrows files
@;		r1 = nrows			->	número de files de la taula
@;		r2= id_city			->	índex de la fila (ciutat) a processar
@;		r3 = *mmres			->	adreça de l'estructura t_maxmin que retornarà els
@;							resultats de temperatures màximes i mínimes
@;	Sortida -> r0:	temperatura mitjana, expressada en graus Celsius, en format Q15.
@;

	.global avgmaxmin_city
avgmaxmin_city:
		push {r1-r11, lr}
		
			mov r10, #0						@; r10 = idmax = 0
			mov r11, #0						@; r11 = idmin = 0
			mov r1, #12						@; r1 = total mesos
			mul r4, r1, r2					@; r4 = @ttemp[id_city][0]				
			
			@; primer mes
			ldr r5, [r0, r4, lsl #2]		@; r5 = avg = ttemp[id_city][0]
			mov r6, r5						@; r6 = max = avg 
			mov r7, r5						@; r7 = min = avg 
			
			mov r8, #1						@; r8 = i
			
		.LFor:
			cmp r8, #12						@; cmp i, 12
			bhs .LendFor					@; i >= 12 go .LendFor
			
			add r4, #1						@; r4 += i
			ldr r9, [r0, r4, lsl #2]		@; r9 = tvar = ttemp[id_city][i].
			add r5, r9						@; avg += tvar
			
			@; resta de mesos
			@; if (tvar > max)
			cmp r9, r6						@; cmp tvar, max
			ble .LnotMax					@; tvar <= max go .LnotMax
			mov r6, r9						@; max = tvar
			mov r10, r8						@; idmax = i
			
			@; if (tvar < min)
			.LnotMax:
			cmp r9, r7						@; cmp tvar, min			
			bge .LnotMin					@; tvar >= min go .LnotMin
			mov r7, r9						@; min = tvar
			mov r11, r8						@; idmin = i
			.LnotMin:
			
			add r8, #1						@; i++
			b .LFor							@; go to for start
		
		.LendFor:
			
			str r7, [r3, #MM_TMINC]			@; mmres->tmin_C = min
			str r6, [r3, #MM_TMAXC]			@; mmres->tmax_C = max
			
			mov r0, r7						@; r0 = min
			bl Celsius2Fahrenheit			@; Celsius2Fahrenheit(min)
			str r0, [r3, #MM_TMINF]			@; mmres-> tmin_F = min
			
			mov r0, r6						@; r0 = max
			bl Celsius2Fahrenheit			@; Celsius2Fahrenheit(max)
			str r0, [r3, #MM_TMAXF]			@; mmres->tmax_F = max
			
			strh r11, [r3, #MM_IDMIN]		@; mmres->id_min = idmin
			strh r10, [r3, #MM_IDMAX]		@; mmres->id_max = idmax
			
			mov r0, r5           			@; r0 = avg
			ldr r9, =0x80000000				@; r9 = mascara signe
			tst r0, r9						@; avg < 0 -> r0 = -r0
			mvnne r0, r0					
			addne r0, #1								
			
			mov r1, #12						@; r1 = divisor
			sub sp, #64						@; reservem espai per 2 ints
			mov r2, sp						@; r2 = @quo
			add r3, sp, #32					@; r3 = @mod
			bl div_mod		
			ldr r0, [sp]					@; r0 = quo
			add sp, #64						@; borrem ints
				
			tst r5, r9						@; passar a negatiu si ho era abans
			subne r0, #1					@; r0 = -r0
			mvnne r0, r0
			
		pop {r1-r11, pc}

@; avgmaxmin_month(): calcula la temperatura mitjana, màxima i mínima d'un mes
@;				d'una taula de temperatures, amb una fila per ciutat i una
@;				columna per mes, expressades en graus Celsius en format Q15.
@;	Entrada:
@;		r0 = ttemp[][12]	->	taula de temperatures, amb 12 columnes i nrows files
@;		r1 = nrows		->	número de files de la taula (mínim 1 fila)
@;		r2 = id_month	->	índex de la columna (mes) a processar
@;		r3 = *mmres		->	adreça de l'estructura t_maxmin que retornarà els
@;							resultats de temperatures màximes i mínimes
@;	Sortida -> r0:	temperatura mitjana, expressada en graus Celsius, en format Q15.
@;		
	.global avgmaxmin_month
avgmaxmin_month:
		push {r1-r11, lr}
		
			mov r10, #0						@; r10 = idmax = 0
			mov r11, #0						@; r11 = idmin = 0		
			
			@; primera ciutat
			ldr r5, [r0, r2, lsl #2]		@; r5 = avg = ttemp[0][id_month]
			mov r6, r5						@; r6 = max = avg 
			mov r7, r5						@; r7 = min = avg 
			
			mov r8, #1						@; r8 = i
			
		.LWhile:
			cmp r8, r1						@; cmp i, nrows
			bhs .LendWhile					@; i >= nrows go .LendWhile
			
			add r2, #12						@; id_month += 12
			ldr r9, [r0, r2, lsl #2]		@; r9 = tvar = ttemp[i_dmonth + 12*i].
			add r5, r9						@; avg += tvar
			
			@; resta de ciutats
			@; if (tvar > max)
			cmp r9, r6						@; cmp tvar, max
			ble .LnotMax1					@; tvar <= max go .LnotMax
			mov r6, r9						@; max = tvar
			mov r10, r8						@; idmax = i
			
			@; if (tvar < min)
			.LnotMax1:
			cmp r9, r7						@; cmp tvar, min			
			bge .LnotMin1					@; tvar >= min go .LnotMin
			mov r7, r9						@; min = tvar
			mov r11, r8						@; idmin = i
			.LnotMin1:
			
			add r8, #1						@; i++
			b .LWhile						@; go to for start
		
		.LendWhile:
			
			str r7, [r3, #MM_TMINC]			@; mmres->tmin_C = min
			str r6, [r3, #MM_TMAXC]			@; mmres->tmax_C = max
			
			mov r0, r7						@; r0 = min
			bl Celsius2Fahrenheit			@; Celsius2Fahrenheit(min)
			str r0, [r3, #MM_TMINF]			@; mmres-> tmin_F = min
			
			mov r0, r6						@; r0 = max
			bl Celsius2Fahrenheit			@; Celsius2Fahrenheit(max)
			str r0, [r3, #MM_TMAXF]			@; mmres->tmax_F = max
			
			strh r11, [r3, #MM_IDMIN]		@; mmres->id_min = idmin
			strh r10, [r3, #MM_IDMAX]		@; mmres->id_max = idmax
			
			mov r0, r5           			@; r0 = avg
			ldr r9, =0x80000000				@; r9 = mascara signe
			tst r0, r9						@; avg < 0 -> r0 = -r0
			mvnne r0, r0					
			addne r0, #1					
			
			sub sp, #64						@; reservem espai per 2 ints
			mov r2, sp						@; r2 = @quo
			add r3, sp, #32					@; r3 = @mod
			bl div_mod		
			ldr r0, [sp]					@; r0 = quo
			add sp, #64						@; borrem ints
				
			tst r5, r9						@; passar a negatiu si ho era abans
			subne r0, #1					@; r0 = -r0
			mvnne r0, r0											
		
		
		pop {r1-r11, pc}
	
.end