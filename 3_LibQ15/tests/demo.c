/*-----------------------------------------------------------------------
|   Description: a program to check some fixed point arithmetic functions
|				implemented in "libQ15.a"; specifically, it computes the
|				area of a trapezium, given the key parameters (long base,
|				short base, height).
|------------------------------------------------------------------------
|	Author: Santiago Romani (DEIM, URV)
|	Date:   April/2021, March/2022, March/2023 
| -----------------------------------------------------------------------*/

#include "Q15.h"	/* external declarations of types, defines, macros
				   and function prototypes for operating with Q15 numbers */


/* global variables as inputs and output, for computing the areas */
Q15 long_base = MAKE_Q15(45.12);		// B = 45.12 cm
Q15 short_base = MAKE_Q15(30.75);		// b = 30.75 cm
Q15 height = MAKE_Q15(29.99);			// h = 29.99 cm
Q15 trapezium_area;		// expected value: (B+b)*h/2 = 1137.67065 cm^2

int main(void)
{
	unsigned char ov;			/* possible overflow */
	Q15 pr;						/* partial result */
	
		// trapezium_area = (long_base + short_base)*height / 2.0
	pr = add_Q15(long_base, short_base, &ov);
	if (!ov)
	{			// proceed with remaining ops only if not overflow
		pr = mul_Q15(pr, height, &ov);
		if (!ov)
		{
			pr = div_Q15(pr, MAKE_Q15(2.0), &ov);
			if (!ov)				// if everthing went fine,
				trapezium_area = pr;	// update output global variable
		}
	}

/* TESTING POINT: check the result (if no overflow)
	(gdb) p ov
	(gdb) p /f trapezium_area/32768.0
*/

/* BREAKPOINT */
	return(ov);
}
