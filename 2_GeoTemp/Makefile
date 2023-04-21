#-------------------------------------------------------------------------------
# Authors: Bogdan Struk, Gonzalo Nieto
# Date: March 2023
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# options for code generation
#-------------------------------------------------------------------------------
ARCH	:= -march=armv5te -mlittle-endian
INCL    := -I./include
ASFLAGS	:= $(ARCH) $(INCL) -g
CCFLAGS	:= -Wall -gdwarf-3 -O0 $(ARCH) $(INCL)
LDFLAGS := -z max-page-size=0x8000 -Lp_lib

#-------------------------------------------------------------------------------
# make commands
#-------------------------------------------------------------------------------
geotemp.elf : build/geotemp.o build/data.o build/avgmaxmintemp.o 
	arm-none-eabi-ld $(LDFLAGS) build/geotemp.o build/data.o build/avgmaxmintemp.o \
						p_lib/startup.o p_lib/libfoncompus.a p_lib/CelsiusFahrenheit.o -o geotemp.elf

build/geotemp.o: source/geotemp.c include/CelsiusFahrenheit.h include/Q15.h include/divmod.h include/avgmaxmintemp.h include/geotemp.h include/data.h 
	arm-none-eabi-gcc $(CCFLAGS) -c source/geotemp.c -o build/geotemp.o


build/data.o: source/data.c include/geotemp.h include/Q15.h include/data.h
	arm-none-eabi-gcc $(CCFLAGS) -c source/data.c -o build/data.o

build/avgmaxmintemp.o: source/avgmaxmintemp.s include/avgmaxmintemp.i 
	arm-none-eabi-as $(ASFLAGS) -c source/avgmaxmintemp.s -o build/avgmaxmintemp.o


test_geotemp.elf : build/test_geotemp.o build/data.o build/avgmaxmintemp.o
	arm-none-eabi-ld $(LDFLAGS) build/test_geotemp.o build/data.o build/avgmaxmintemp.o \
						p_lib/startup.o p_lib/libfoncompus.a p_lib/CelsiusFahrenheit.o -o test_geotemp.elf

build/test_geotemp.o: tests/test_geotemp.c include/avgmaxmintemp.h include/Q15.h
	arm-none-eabi-gcc $(CCFLAGS) -c tests/test_geotemp.c -o build/test_geotemp.o


#-------------------------------------------------------------------------------
# clean commands
#-------------------------------------------------------------------------------
clean : 
	@rm -fv build/*
	@rm -fv *.elf


#-----------------------------------------------------------------------------
# run commands
#-----------------------------------------------------------------------------
run : geotemp.elf
	arm-eabi-insight geotemp.elf &


#-----------------------------------------------------------------------------
# debug commands
#-----------------------------------------------------------------------------
debug : test_geotemp.elf
	arm-eabi-insight test_geotemp.elf &
