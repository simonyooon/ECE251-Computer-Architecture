# Comparch-Project-2
Project 2 - Sort a List of Numbers

How to build the program on linux (with arm processor installed):

1. Download the files to your local machine
2. A sample input.txt is provided but if you want to make a list replace it with your own input.txt
3. After that, type: make all
4. Then, run: ./Project2.out
5. To view the output, open output.txt to see the sorted list
6. Run make clean to remove Project2.out 

*If Makefile is not running...*
1. Instead of the "make all" command, simply run: arm-linux-gnueabi-gcc Project2.s -o Project2.out -static
2. The command "make clean" will not work this case
