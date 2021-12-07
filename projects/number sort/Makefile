# Makefile
.PHONY: clean

all: Project2.out

Project2.out: Project2.s
	arm-linux-gnueabi-gcc $< -o $@ -ggdb3 -static

clean:
	rm -f Project2.out
