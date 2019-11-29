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
	
	kip:
	addi $t0,$t0,1 #move the $t0 to the next element of the array
	j start 
loop:
	
	
	lb $s0, ($t0)    # loads the bit that $t0 is pointing to
	beq $s0, 0,next  # check if the bit is null
	beq $s0, 10, next # checks if the bit is a new line 	
	addi $t0,$t0,1   #move the $t0 to the next element of the array	
	beq $s0, 44, substring #check if bit is a comma
	

check:
	bgt $t6,0,invalidloop    # checks to see if there were any spaces or tabs in between valid characters
	beq $s0, 9,  gap         # checks to see if there is a tab characters
	beq $s0, 32, gap         # checks to see if there is a space character
	ble $s0, 47, invalidloop # checks to see if the ascii less than 43
“””””
	ble $s0, 64, invalidloop # checks to see if the ascii less than 64
	ble $s0, 84, vaild	 # checks to see if the ascii less than 84( CAP )
	ble $s0, 96, invalidloop # checks to see if the ascii less than 96
	ble $s0, 116, vaild 	 # checks to see if the ascii less than 116(lowercase letter)
	bge $s0, 117, invalidloop # checks to see if the ascii greater than 116



gap:
	addi $t6,$t6,-1 #keeps track of spaces
	j loop
vaild:
	addi $t3, $t3,1   #keeps track of the amount of valid characters in substring
	mul $t6,$t6,$t7  #if there was a space before a this valid character it will change $t6 to a positive num
	j loop #jumps to the beginning of loop	

invalidloop:
	
	lb $s0, ($t0) # loads the bit that $t0 is pointing to
	beq $s0, 0, insubstring# check if the bit is null
	beq $s0, 10, insubstring #checks if the bit is a new line 	
	addi $t0,$t0,1 #move the $t0 to the next element of the array	
	beq $s0, 44, insubstring #check if bit is a comma
	
	
	j invalidloop #jumps to the beginning of loop




