/*---------------------------------------------------------------------
|   Declaració de prototipus de rutines de càlcul de valors mitjos,
|	màxims i mínims d'una taula de temperatures, expressades en graus
|	Celsius, en format Q15 (coma fixa 1:16:15).
| ---------------------------------------------------------------------
|	pere.millan@urv.cat
|	santiago.romani@urv.cat
|	(Març 2021, Març 2022, Març 2023)
| ---------------------------------------------------------------------*/

#ifndef AVGMAXMINTEMP_H
#define AVGMAXMINTEMP_H

#include "Q15.h"			// definició tipus Q15


  	/* declaració del tipus t_maxmin, per retornar resultats */
typedef struct
{	
	Q15 tmin_C;				// temperatura mínima, en graus Celsius
	Q15 tmax_C;				// temperatura màxima, en graus Celsius
	Q15 tmin_F;				// temperatura mínima, en graus Fahrenheit
	Q15 tmax_F;				// temperatura màxima, en graus Fahrenheit
	unsigned short id_min;	// índex temperatura mínima
	unsigned short id_max; 	// índex temperatura màxima
} t_maxmin;


/* avgmaxmin_city(): calcula la temperatura mitjana, màxima i mínima d'una
|				ciutat d'una taula de temperatures, amb una fila per ciutat i
|				una columna per mes, expressades en graus Celsius en format
|				Q15.
|	Paràmetres:
|		ttemp[][12]	->	taula de temperatures, amb 12 columnes i nrows files
|		nrows		->	número de files de la taula
|		id_city		->	índex de la fila (ciutat) a processar
|		*mmres		->	adreça de l'estructura t_maxmin que retornarà els
|						resultats de temperatures màximes i mínimes
|	Resultat:	temperatura mitjana, expressada en graus Celsius, en format Q15.
*/		
Q15 avgmaxmin_city(Q15 ttemp[][12], unsigned short nrows, unsigned short id_city, t_maxmin *mmres);


/* avgmaxmin_month(): calcula la temperatura mitjana, màxima i mínima d'un mes
|				d'una taula de temperatures, amb una fila per ciutat i una
|				columna per mes, expressades en graus Celsius en format Q15.
|	Paràmetres:
|		ttemp[][12]	->	taula de temperatures, amb 12 columnes i nrows files
|		nrows		->	número de files de la taula
|		id_month	->	índex de la columna (mes) a processar
|		*mmres		->	adreça de l'estructura t_maxmin que retornarà els
|						resultats de temperatures màximes i mínimes
|	Resultat:	temperatura mitjana, expressada en graus Celsius, en format Q15.
*/		
Q15 avgmaxmin_month(Q15 ttemp[][12], unsigned short nrows, unsigned short id_month, t_maxmin *mmres);


#endif 	/* AVGMAXMINTEMP_H */