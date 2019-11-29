.data
	data: .space 1001
	comma: .asciiz ","
notvalid: .asciiz "NaN"
	output: .asciiz "\n"
.text


main :
	li $v0,8	
	la $a0,data	#reads userinput 
	li $a1, 1001	
	syscall


con1:
	j print #jumps to print function


SubgramA:
	sub $sp, $sp,4 #creates spaces in the stack
	sw $a0, 0($sp) #stores input into the stack
	lw $t0, 0($sp) # stores the input into $t0
	addi $sp,$sp,4 # moves the stack pointer up
	move $t5, $t0 # stores the beginning of the input into $t5
start:
	li $t6,0 #used to check for space or tabs within the input
	li $t7, -1 #used for invaild input
	lb $s0, ($t0) # loads the bit that $t0 is pointing to
	beq $s0, 0, insubstring# check if the bit is null
	beq $s0, 10, insubstring #checks if the bit is a new line 
	beq $s0, 44, invalidloop #check if bit is a comma

	beq $s0, 9, skip # checks if the bit is a tabs character 
	beq $s0, 32, skip #checks if the bit is a space character
	move $t5, $t0 #store the first non-space/tab character
	j loop # jumps to the beginning of the loop function

