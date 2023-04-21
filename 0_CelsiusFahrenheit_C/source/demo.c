/*-----------------------------------------------------------------------
|   Description: a program to check the temperature-scale conversion
|				functions implemented in "CelsiusFahrenheit.c".
|	IMPORTANT NOTE: there is a much confident testing set implemented in
|				"tests/test_CelsiusFahrenheit.c"; the aim of "demo.c" is
|				to show how would it be a usual main() code invoking the
|				mentioned functions.
|------------------------------------------------------------------------
|	Author: Santiago Romani (DEIM, URV)
|	Date:   March/2021, February/2022 , March/2023
| -----------------------------------------------------------------------*/

#include "Q15.h"				/* external declarations of types, defines and
								   macro for dealing with Q15 numbers */
#include "CelsiusFahrenheit.h"	/* external declarations of function
								   prototypes for temperature conversions */


/* global variables as inputs and output */
Q15 temp1C = MAKE_Q15(35.21);		// sample Celsius temperature
Q15 temp2F = MAKE_Q15(-23.75);		// sample Fahrenheit temperature

Q15 temp1F;		// expected conversion of temp1C:  95.378  �F
Q15 temp2C;		// expected conversion of temp2C: -30.97222... �C

int main(void)
{
	temp1F = Celsius2Fahrenheit(temp1C);
	temp2C = Fahrenheit2Celsius(temp2F);
	
	Q15 ddd = MAKE_Q15(1.8);
	Q15 bbb = MAKE_Q15(32);

/* TESTING POINT: check the results
	(gdb) p /f temp1F/32768.0		->  95.377532958984375
	(gdb) p /f temp2C/32768.0		-> -30.971466064453125
*/

/* BREAKPOINT */
	return(0);
}
