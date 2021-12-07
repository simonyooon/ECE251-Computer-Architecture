#Makefile

.PHONY: clean

all: calc

calc: project3.s
	arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static

clean:
	rm -f calc
