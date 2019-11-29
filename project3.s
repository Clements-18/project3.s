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
