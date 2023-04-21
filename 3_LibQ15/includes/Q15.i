@;----------------------------------------------------------------
@;  Declaració de constants GAS per al tractament de dades 
@;	en format Coma Fixa 1:16:15.
@;----------------------------------------------------------------
@;	pere.millan@urv.cat
@;	santiago.romani@urv.cat
@;	(Març 2021, Març 2022, Març 2023)
@;----------------------------------------------------------------

	@; MÀSCARES per als camps de bits de valors 1:16:15
MASK_SIGN = 0x80000000				@; bit 31:		signe
MASK_INT  = 0x7FFF8000				@; bits 30..15:	part entera
MASK_FRAC =	0x00007FFF				@; bits 14..0:	part fraccionària
