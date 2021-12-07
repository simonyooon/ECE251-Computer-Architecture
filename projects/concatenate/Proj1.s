/*Project 1*/
/*Michael Bentivegna, Serene Joe, Joya Debi, Simon Yoon*/
.data 

.balign 4 /*String that will be a label for us to ask for Strings */
input_msg: .asciz "Type a string:\n"

/*Storage for string 1 */
.balign 32
string_read1: .word 0

/*Storage for string 2 */
.balign 32
string_read2: .word 0 

/*Concatenated String Print */
.balign 64
printf_msg: .asciz "The Concatenated String is: %s \n"

/*Holds newline character*/
.balign 4
newline: .asciz "\n"

/*Error Message */
.balign 4
error_msg: .asciz "The string is too long\n" 

/*Concatenated String */
.balign 4
new_string: .skip 32

/*Where we store the link register*/
.balign 4
return: .word 0

.global main
main:

/*Storing link register */
ldr r1, address_of_return
str lr, [r1]

/*Printing the message to ask user for input*/
ldr r0, address_of_input_msg
bl printf

/*Reading first string*/
ldr r0, address_of_string_read1
mov r1, #16 
ldr r2, address_of_stdin
ldr r2, [r2]
bl fgets

/*Preparing registers for length check */
ldr r1, address_of_string_read1
mov r5, #0
ldr r6, address_of_newline
ldr r6, [r6]
ldr r7, address_of_new_string

/*Loops through inputted string until newline character is reached*/
/*If null character is reached it means it exceeded the read alottment*/
loop1:
ldrb r3, [r1, r5] 
cmp r3, r6
beq compare1
cmp r3, #0
beq error7
strb r3, [r7, r5]
add r5, r5, #1
b loop1

/*Compare length to 12, if longer send to error message */
compare1:
cmp r5, #13
bge error7

/*Asking the user for input again */
ldr r0, address_of_input_msg
bl printf

/*Reading second string*/
ldr r0, address_of_string_read2
mov r1, #16
ldr r2, address_of_stdin
ldr r2, [r2]
bl fgets

/*Preparing registers for length check */
ldr r1, address_of_string_read2
mov r4, #0

/*Same as first loop but for string 2 */
loop2:
ldrb r3, [r1, r4]
cmp r3, r6
beq compare2
cmp r3, #0
beq error8
strb r3, [r7,r5]
add r5, r5, #1
add r4, r4, #1
b loop2

/*Same as first compare but for string 2 */
compare2:
cmp r4, #13
bge error8

/*Printing concatenated String*/
ldr r0, address_of_printf_msg
ldr r1, address_of_new_string
bl printf

/*Returns total number of characters */
mov r0, r5

/*Send to end function */
b end

/*Print error message with a 7 return code*/
error7:
ldr r0, address_of_error_msg
bl printf
mov r0, #7
b end

/*Print error message with an 8 return code*/
error8:
ldr r0, address_of_error_msg
bl printf
mov r0, #8

/*Retrieves link register and exits programs */
end:
ldr lr, address_of_return
ldr lr, [lr]
bx lr

/*Declarations */
address_of_input_msg: .word input_msg
address_of_string_read1: .word string_read1
address_of_string_read2: .word string_read2
address_of_printf_msg: .word printf_msg
address_of_return: .word return
address_of_error_msg: .word error_msg
address_of_stdin: .word stdin
address_of_newline: .word newline
address_of_new_string: .word new_string

/*External functions*/
.global printf
.global fgets
