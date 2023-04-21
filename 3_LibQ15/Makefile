#-------------------------------------------------------------------------------
# Example Makefile to build a library and to test the functions of each module
# Authors: Santiago Romani, Pere Millán
# Date: April 2023
#-------------------------------------------------------------------------------
#	Programador/a 1: bogdan.struk@estudiants.urv.cat
#	Programador/a 2: gonzalo.nieto@estudiants.urv.cat
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# options for code generation
#-------------------------------------------------------------------------------
ARCH	:= -march=armv5te -mlittle-endian
INCL    := -I./includes
ASFLAGS	:= $(ARCH) $(INCL) -g
CCFLAGS	:= -Wall -gdwarf-3 -O0 $(ARCH) $(INCL)
LDFLAGS := -z max-page-size=0x8000

#-------------------------------------------------------------------------------
# make commands
#-------------------------------------------------------------------------------
libQ15.a: build/Q15.o
	arm-none-eabi-ar -rs libQ15.a build/Q15.o

build/Q15.o: sources/Q15.s includes/Q15.i
	arm-none-eabi-gcc $(CCFLAGS) -c sources/Q15.s -o build/Q15.o


#-------------------------------------------------------------------------------
# test making commands
#-------------------------------------------------------------------------------
test_Q15.elf : tests/test_Q15.c includes/Q15.h libQ15.a
	arm-none-eabi-gcc $(CCFLAGS) -c tests/test_Q15.c -o build/test_Q15.o
	arm-none-eabi-ld $(LDFLAGS) build/test_Q15.o tests/startup.o \
					libQ15.a tests/libfoncompus.a -o test_Q15.elf

demo.elf : tests/demo.c includes/Q15.h libQ15.a
	arm-none-eabi-gcc $(CCFLAGS) -c tests/demo.c -o build/demo.o
	arm-none-eabi-ld $(LDFLAGS) build/demo.o tests/startup.o \
					libQ15.a tests/libfoncompus.a -o demo.elf


#-------------------------------------------------------------------------------
# clean commands
#-------------------------------------------------------------------------------
clean : 
	@rm -fv build/*
	@rm -fv *.elf


#-----------------------------------------------------------------------------
# run commands
#-----------------------------------------------------------------------------
run : demo.elf
	arm-eabi-insight demo.elf &


#-----------------------------------------------------------------------------
# debug commands
#-----------------------------------------------------------------------------
debug : test_Q15.elf
	arm-eabi-insight test_Q15.elf &
