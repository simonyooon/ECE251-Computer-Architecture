/*Project 2*/
/*Michael Bentivegna, Serene Joe, Joya Debi, Simon Yoon*/
.data

.balign 4
name_of_file: .asciz "input.txt"

.balign 4
input_type: .asciz "%u"

.balign 4
read: .asciz "r"

.balign 4
write: .asciz "w"

.balign 4
scanned_number: .word 0

.balign 4
test: .asciz "The number is: %u \n"

.balign 4
return: .word 0

.balign 4
array: .skip 400

.balign 4
output_file: .asciz "output.txt"

.balign 4
write_format: .asciz "%u\n"

.global main

main:
/*Link Register*/
ldr r1, address_of_return
str lr, [r1]

/*Stores in r0 the file pointer*/
ldr r0, address_of_name_of_file
ldr r1, address_of_read
bl fopen

/*r0 becomes the file pointer*/
mov r4, r0
mov r8, #0

loop:

/*Each time it loops, the file pointer is put back into r0*/
mov r0, r4

ldr r1, address_of_input_type
ldr r2, address_of_scanned_number
bl fscanf

/*r0 = 1 if scanf returns a number */
mov r6, r0
cmp r6, #1
bne done

ldr r1, address_of_scanned_number
ldr r1, [r1]

ldr r7, address_of_array
add r9, r7, r8, LSL #2
str r1, [r9]
add r8, r8, #1

b loop

done:
  
mov r1, #0
mov r2, #1

/*Start of selection sort loop*/
outer:

ldr r7, address_of_array
add r3, r7, r1, LSL #2
ldr r4, [r3]
mov r10, r4
mov r9, r3

innerA:

/*Check if value is greater than first value in the subarray*/
add r5, r7, r2, LSL #2
ldr r6, [r5]
cmp r6, r10
blt iff

/*Make sure the checker does not exceed the bounds of the array */
/*Swap the proper numbers */
innerB:

add r2, r2, #1
cmp r2, r8
ble innerA

add r1, r1, #1
add r2, r1, #1
str r4, [r9]
str r10, [r3]
cmp r1, r8
blt outer
b write2

/*Store minimum value (and its address) in these registers */
iff:

mov r10, r6
mov r9, r5
b innerB

/*Open output file*/
write2:

ldr r0, address_of_output_file
ldr r1, address_of_write
bl fopen

mov r6, r0
mov r5, #0

/*Loop to write the sorted numbers into the output file */
write_loop:

add r5, r5, #1

cmp r5, r8
bgt end

mov r0, r6
ldr r1, address_of_write_format 
ldr r2, [r7, r5,LSL #2]
bl fprintf
b write_loop

/*Return link register */
end:

mov r0, r8
ldr lr, address_of_return
ldr lr, [lr]
bx lr

address_of_name_of_file: .word name_of_file
address_of_input_type: .word input_type
address_of_read: .word read
address_of_scanned_number: .word scanned_number
address_of_test: .word test
address_of_return: .word return
address_of_array: .word array
address_of_output_file: .word output_file
address_of_write: .word write
address_of_write_format: .word write_format

.global printf
.global fscanf
.global fopen
.global fclose
.global fprintf
