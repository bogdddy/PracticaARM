/*-----------------------------------------------------------------
|   Declaració de tipus, màscares i macro del format Q15, és a dir, 
|	en format Coma Fixa 1:16:15.
| -----------------------------------------------------------------
|	pere.millan@urv.cat
|	santiago.romani@urv.cat
|	(Març 2021, Febrer 2022, Març 2023)
| ----------------------------------------------------------------*/

#ifndef Q15_H
#define Q15_H


/* Declaració de tipus Coma Fixa 1:16:15 
		 1 bit  de signe (bit 31), =0 -> positiu, =1 -> negatiu
		16 bits de part entera (bits 30..15), aprox. 4-5 dígits en base 10
		15 bits de part fraccionària (bits 14..0), aprox. 4-5 dígits en base 10
*/
typedef int Q15;


/* Macro per convertir valors reals en valors Coma Fixa 1:16:15
		Exemples:
		MAKE_Q15(3.1416) --> 0x00019220
		MAKE_Q15(-5.125) --> 0xFFFD7000
*/
#define MAKE_Q15(real)	(int)((real)*(1<<15)+(real<0?-0.5:0.5)) 


/* MÀSCARES per als camps de bits de valors 1:16:15 */
#define MASK_SIGN	0x80000000	/* bit 31:		signe */
#define MASK_INT	0x7FFF8000	/* bits 30..15:	part entera */
#define MASK_FRAC	0x00007FFF	/* bits 14..0:	part fraccionària */


#endif /* Q15_H */
