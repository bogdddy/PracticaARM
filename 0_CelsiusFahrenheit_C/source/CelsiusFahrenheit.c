/*----------------------------------------------------------------
|   CelsiusFahrenheit.c: rutines de conversió de temperatura en 
|						 format Q15 (Coma Fixa 1:16:15). 
| ----------------------------------------------------------------
|	santiago.romani@urv.cat
|	pere.millan@urv.cat
|	(Març 2021, Febrer 2022, Març 2023)
| ----------------------------------------------------------------*/

#include "Q15.h"	/* Q15: tipus Coma Fixa 1:16:15
					   MAKE_Q15(real): codifica un valor real en format Q15
					   MASK_SIGN: màscara per obtenir el bit de signe
					*/


/* Celsius2Fahrenheit(): converteix una temperatura en graus Celsius a la
						temperatura equivalent en graus Fahrenheit, utilitzant
						valors codificats en Coma Fixa 1:16:15.
	output = (input * 9/5) + 32.0;
*/
Q15 Celsius2Fahrenheit(Q15 input)
{
	Q15 output;
	long long prod64;		// resultat de la multiplicació (64 bits)

		// ajust d'escala (input * 9/5), amb multiplicació de 64 bits
	prod64 = (((long long) input) * MAKE_Q15(9.0/5.0));
	
		// ajustar bits fraccionaris:
		//	prod64 = real(input) * 2^15 * real(9/5) * 2^15
		//	output = prod64 / 2^15 = real(input * 9/5) * 2^15
	output = (Q15) (prod64 >> 15);
	
	output += MAKE_Q15(32.0);		// afegir desplaçament d'escala Fahrenheit

	return(output);
}


/* Fahrenheit2Celsius(): converteix una temperatura en graus Fahrenheit a la
						temperatura equivalent en graus Celsius, utilitzant
						valors codificats en Coma Fixa 1:16:15.
	output = (input - 32.0) * 5/9;
*/
Q15 Fahrenheit2Celsius(Q15 input)
{
	Q15 output;
	long long prod64;		// resultat de la multiplicació (64 bits)

	input -= MAKE_Q15(32.0);		// treure desplaçament d'escala Fahrenheit
		
		// ajust d'escala ((input - 32.0) * 5/9), amb multiplicació de 64 bits
	prod64 = (((long long) input) * MAKE_Q15(5.0/9.0));
	
		// ajustar bits fraccionaris:
		//	prod64 = real(input - 32.0) * 2^15 * real(5/9) * 2^15
		//	output = prod64 / 2^15 = real(input - 32.0) * real(5/9) * 2^15
	output = (Q15) (prod64 >> 15);

	return(output);
}

