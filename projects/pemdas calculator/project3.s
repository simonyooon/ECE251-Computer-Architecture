/*Project 3: Serene Joe, Michael Bentivegna, Joya Debi, Simon Yoon*/ 

/*PEMDAS CALCULATOR WITH FLOATING POINT INTEGERS*/

.data

/*variables*/

.balign 4
num_array: .skip 32

.balign 4
op_array: .skip 16

.balign 4
num_temp_array: .skip 32

.balign 4
op_temp_array: .skip 16

.balign 4
string_message:.asciz "The calculator is currently inoperable.\n"

.balign 4
num: .asciz "%f\n"

.balign 4
return: .word 0

.text

.global main

/*Link Register load*/ 
main:
	ldr r2, =return
	str lr, [r2]

/*Initializing arrays*/
init:
	ldr r4, [r1, #4]
	mov r5, #-1 /*Input indexer*/

	ldr r6, =num_array
	mov r7, #0 /*Number array indexer*/
	
	ldr r8, =op_array
	mov r9, #0 /*Operator array indexer*/
	
	ldr r11, =num_temp_array
	ldr r12, =op_temp_array
	

	ldr r0, =string_message 
	bl printf

/*Read input from user and identify as a number or operator*/
input_read:
	add r5, r5, #1
	ldrb r3, [r4, r5] /*Loading each indivual element of input into r3, one at a time*/
	
	cmp r3, #0 /*Null character is end of the input string*/
	beq end

	cmp r3, #94 /*^*/
	beq op_load

	cmp r3, #42 /*Multiplication*/
	beq op_load

	cmp r3, #47 /*Division*/
	beq op_load
	
	cmp r3, #43 /*+*/
	beq op_load

	cmp r3, #45 /*-*/
	beq op_load
	
	cmp r3, #48 /*Number?**/
	bge num_load

/*Convert ASCII string into an integer and storing into num_array*/
num_load:
	push {r0-r12, lr}
	ldr r1, [r3]
	bl atoi
	pop {r0-r12, lr}
	strb r1, [r6, r7]
	add r7, r7, #1
	b input_read

/*Loading the operators into op_array*/
op_load:
	strb r3, [r8, r9]
	add r9, r9, #1	
	b input_read

/*Restoring the opeartor index*/
op_index_restore:
	mov r9, #0

/*Searching through op_array for exponent*/
exp_search:
	cmp r9, #5
	beq multi_search
	ldrb r4, [r8, r9]
	cmp r4, #94
	beq exp_calc
	add r9, r9, #1
	b exp_search	

/*Performing the exponent calculation*/
exp_calc:
	ldr r1, [r6, r9]
	add r10, r9, #1
	ldr r2, [r6, r10]
	cmp r2, #0
	bne exp_loop

exp_loop:
	mul r1, r4, r1
	ldr r4, [r1]
	sub r2, r2, r1
	b exp_calc2

exp_calc2:
	str r1, [r6, r9]
	mov r2, #0
	str r2, [r6, r10]
	b num_array_reset

/*Searching through op_array for multiplication sign*/
multi_search:
	beq div_search
	ldrb r4, [r8, r9]
	cmp r4, #42
	beq multi_calc
	add r9, r9, #1
	b multi_search

/*Performing the multiplication*/
multi_calc:
	ldr r1, [r6, r9]
	add r10, r9, #1
	ldr r2, [r6, r10]
	mul r1, r2, r1
	str r1, [r6, r9]
	mov r2, #0
	str r2, [r6, r10]
	b num_array_reset

/*Searching through op_array for division sign*/
div_search:
	cmp r9, #5
	beq add_search
	ldrb r4, [r8, r9]
	cmp r4, #47
	beq div_calc
	add r9, r9, #1
	b div_search

/*Performing the division*/
/*Division oeartion has been commented out because it will not build*/
div_calc:
	ldr r1, [r6, r9]
	add r10, r9, #1
	ldr r2, [r6, r10]
/*	div r1, r1, r2*/
	str r1, [r6, r9]
	mov r2, #0
	str r2, [r6, r10]
	b num_array_reset

/*Searching through the op_array for the addition sign*/
add_search:
	cmp r9, #5
	beq sub_search
	ldrb r4, [r8, r9]
	cmp r4, #43
	beq add_calc
	add r9, r9, #1
	b add_search

/*Performing the addition*/
add_calc:
	ldr r1, [r6, r9]
	add r10, r9, #1
	ldr r2, [r6, r10]
	add r1, r1, r2
	str r1, [r6, r9]
	mov r2, #0
	str r2, [r6, r10]
	b num_array_reset

/*Searching through op_array for the subtraction sign*/
sub_search:
	cmp r9, #5
	beq end
	ldrb r4, [r8, r9]
	cmp r4, #45
	beq sub_calc
	add r9, r9, #1
	b sub_search

/*Performing the subtraction*/
sub_calc:
	ldr r1, [r6, r9]
	add r10, r9, #1
	ldr r2, [r6, r10]
	sub r1, r1, r2
	str r1, [r6, r9]
	mov r2, #0
	str r2, [r6, r10]
	b num_array_reset

/*Resetting num_array to remove the placeholder null character*/
num_array_reset:
	mov r7, #0
	ldr r3, [r6, r7]
	cmp r3, #0
	beq skip_num
	str r3, [r6, r7]
	add r7, r7, #1
	b num_array_reset

skip_num:
	add r7, r7, #1
	b num_array_reset
		
/*Resetting op_array to remove the operator once it is used*/
op_array_reset:
	mov r7, #0
	ldr r3, [r8, r7]
	cmp r3, #0
	beq skip_op
	str r3, [r8, r7]
	add r7, r7, #1
	b op_array_reset

skip_op:
	add r7, r7, #1
	b num_array_reset
/*Restoring link register and printing to stdout*/
end:
	mov r7, #0
	ldr r1, [r6, r7]	
	push {r0-r12, lr}
	ldr r1, [r1]
	bl printf
	pop {r0-r12, lr}
	mov r7, #1
	swi 0

.global printf
.global atoi
