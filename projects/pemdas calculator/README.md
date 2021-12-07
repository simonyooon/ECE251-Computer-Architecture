# Comparch-Project-3
**Project 3 - PEMDAS Calculator**

*The program is currently not operational and will return an error message*

How to build the program on linux (with arm processor installed):

1. Clone the files to your local machine
2. After that, type: make all
3. Then, run: ./calc *equation*
4. Run make clean to remove ./calc

*If Makefile is not running...*
1. Instead of the "make all" command, simply run: arm-linux-gnueabi-gcc project3.s -o calc -static
2. The command "make clean" will not work this case
