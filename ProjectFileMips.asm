.data
l: .space 40
x: .asciiz "\nEnter the number against the operation you desire to perform: "
m: .asciiz "Enter '0' to initialize array with your preferred values and print them."
d: .asciiz "\nEnter '1' to compute average."
e: .asciiz "\nEnter '2' to display maximum number in an array."
f: .asciiz "\nEnter '3' to find out if a string is a palindrome."
g: .asciiz "\nEnter '4' to compare 2 strings."
h: .asciiz "\nEnter '5' to display each word in a string on an individual line."
mess: .asciiz "\nEnter length of array: "
mess1: .asciiz "\nEnter value in array: "
mess2: .asciiz "\nThe entered values of array are: "
mess3: .asciiz "\n"
mess4: .asciiz "\nAverage of array is: "
mess5: .asciiz "\nThe maximum value in the array is: "
mess6: .asciiz "\nEnter your string: "
mess9: .asciiz "\nEnter your string for palindrome check: "
mess7: .asciiz "\nEntered string is a palindrome."
mess8: .asciiz "\nEntered string is not a palindrome."
i: .asciiz "\nEnter '1' if you want to make another operation otherwise '0': "
a: .space 512
c: .space 512
.text
li $v0,4
la $a0,m
syscall				# displays a message
li $v0,4
la $a0,d
syscall				# displays a message
li $v0,4
la $a0,e
syscall				# displays a message
li $v0,4
la $a0,f
syscall				# displays a message
li $v0,4
la $a0,g
syscall				# displays a message
li $v0,4
la $a0,h
syscall				# displays a message
start:
li $v0,4
la $a0,x
syscall				# displays a message
li $v0,5                        
syscall				# takes input from user
move $t0,$v0                    # t0 contains input
beq $t0,0,setandprint		# if $t0 equals to 0, branch to "setandprint"
beq $t0,1,avg			# if $t0 equals to 1, branch to "avg"
beq $t0,2,max			# if $t0 equals to 2, branch to "max"  
beq $t0,3,palindrome		# if $t0 equals to 3, branch to "palindrome"
beq $t0,4,stringcopy		# if $t0 equals to 4, branch to "stringcopy"
beq $t0,5,nextline		# if $t0 equals to 5, branch to "nextline"
#########################################
######## INITIALIZING SECTION ###########
######################################### 
setandprint:
li $v0,4
la $a0,mess
syscall				# displays a message
li $v0,5
syscall				# takes input from user
move $t1,$v0			# length of array
li $t2,0			# counter
la $t7,l
Initialization:		
beq $t1,$t2,done		# check whether the counter is equal to length of array
addi $t2,$t2,1			# increment of counter
li $v0,4
la $a0,mess1			# displays a message
syscall
li $v0,5			# takes input from user
syscall
move $t3,$v0			# sets the value in $v0 to $t3
sw $t3,0($t7)			# saving first value of array
addi $t7,$t7,4		
b Initialization		# branch to "Initialization"
done:				# array has been initialized
beq $t0,1,chr			# if $t0 equals to 1, branch to "chr"
beq $t0,2,mxn			# if $t0 equals to 2, branch to "mxn"
##########################################
########## PRINTING SECTION ##############
##########################################
la $t7,l			# printing of an array
move $a1,$t1			# move length of array to a1 register
move $a2,$t7			# address of first array value
jal print			# jump to "print" procedure
b end				# branch to "end"
########################################
########## AVERAGE SECTION #############
########################################
avg:
b setandprint			# branch to "setandprint"
chr:
move $a1,$t1			# move length of array to a1 register
la $t7,l			# address for first array value
move $a2,$t7			# moves contents of $t7 to $a2
jal average			# jump to "average" procedure
b end				# branch to "end"
########################################
######### MAX VALUE SECTION ############
########################################
max:
b setandprint			# branch to "setandprint"
mxn:
move $a1,$t1            	# a1 contains length of string
la $t7,l			# first address of space provided to save array value
move $a2,$t7			# moves the first address to $a2
jal maxnum			# jump to the procedure to find maximum value
move $t1,$v0			# moves the output to $t1 register
li $v0,4
la $a0,mess5
syscall				# displays a message
move $a0,$t1
li $v0,1 
syscall				# displays an integer
b end				# branch to "end"
#########################################
######### PALINDROME SECTION ############
#########################################
palindrome:
li $gp,0x10010000		# string part of the code begins
li $v0,4
la $a0,mess9
syscall				# displays a message
la $a0,a
li $a1,512
li $v0,8
syscall				# takes a string from user
la $t8,a			# loads first address of string in $t8
move $a2,$t8			# moves the first address of string to $a2
jal pal				# jump to "pal" procedure
b end				# branch to "end"
##########################################
######### COPY STRING SECTION ############
##########################################
stringcopy:
li $gp,0x10010000
li $v0,4
la $a0,mess6
syscall				# displays a message
la $a0,a
li $a1,512
li $v0,8
syscall				# takes a string from user
la $a2,a			# first address of first string
li $v0,4
la $a0,mess6
syscall				# displays a message
la $a0,c
li $a1,512
li $v0,8
syscall				# takes a string from user
la $a3,c			# first address of second string
jal strcopy			# jump to "strcopy" procedure
b end				# branch to "end"
##########################################
########## NEXT LINE SECTION #############
##########################################
nextline:
li $gp,0x10010000
li $v0,4
la $a0,mess6
syscall				# displays a message	
la $a0,a
li $a1,512
li $v0,8
syscall				# takes a string from user
move $a2,$a0			# moves address of string to $a2 as input for the procedure
jal nxt				# jump to "nxt" procedure
b end				# branch to "end"
#############################
###### print procedure ######
#############################
print:				# procedure to print
li $t2,0			# counter
li $t3,0			# register where the values of array will be loaded
function:
beq $t2,$a1,exit        	# a1 contains length of array
addi $t2,$t2,1
lw $t3,0($a2)			# loading values of array (a2 contains the 40 space)
li $v0,4
la $a0,mess2
syscall				# takes a string from user
move $a0,$t3			# sets $a0 to contents of $t3 (load from 40 space)
li $v0,1
syscall				# displays an integer
addi $a2,$a2,4
b function			# branch to "function"
exit:
jr $ra				# goes back to the next line from where the procedure was called
###############################
###### average procedure ######
###############################
average:			# procedure to find average
li $t2,0			# counter
li $t3,0                	# t3 contains element from array
li $t4,0                	# t4 contains the sum
begin: 
beq $t2,$a1,finish     		# a1 contains length of array
lw $t3,0($a2)          		# t3 contains element from array
addi $a2,$a2,4
add $t4,$t4,$t3
addi $t2,$t2,1
b begin				# branch to "begin"
finish: 
mtc1 $t4,$f1			# moving to Coproc 1 to get values in float
mtc1 $a1,$f3			# moving to Coproc 1 to get values in float
div.s  $f12,$f1,$f3		# dividing to single precision
li $v0,4
la $a0,mess4			
syscall				# displays a message
li $v0,2			# to print floating value
syscall				
jr $ra				# goes back to the next line from where the procedure was called
######################################
###### maximum number procedure ######
######################################
maxnum:				# procedure to find the maximum number
li $t2,2			#counter starts from 2 because we already loaded two values from array
lw $t3,0($a2)			# loading first array value
addi $a2,$a2,4          # address of "l'
lw $t4,0($a2)			# loading second array value
loop1:
bgt $t3,$t4,label		# branch to "label" if t3 is greater than t4
beq $t2,$a1,return		# branch to "return" if t2 is equal to a1
addi $a2,$a2,4
lw $t3,0($a2)			# next value of array gets loaded
addi $t2,$t2,1
b loop1				# branch to "loop1"
label:
beq $t2,$a1,return		# branch to "return" if t2 is equal to a1
addi $a2,$a2,4
lw $t4,0($a2)			# next value of array gets loaded
addi $t2,$t2,1
b loop1				# branch to "loop1"
return:
slt $t5,$t3,$t4
beq $t5,1,goto			# branch to "goto" if $t5 equal to 1
move $v0,$t3           		# t3 is max in this case
b over 				# branch to "over"
goto:
move $v0,$t4           		# t4 is max in this case
over:
jr $ra				# goes back to the next line from where the procedure was called
##################################
###### palindrome procedure ######
##################################
pal:
li $t2,0			# counter
go:
lb $t3,0($a2)			# loading the first character
beqz $t3,lit            	# branch to "lit" if $t3 equal to zero
addi $a2,$a2,1          	# to fetch next character
addi $t2,$t2,1
b go				# branch to go
lit:
addi $t2,$t2,-1         	# subtracting the \n part ,after -1 it contains the total length of string
div $t3,$t2,2		    	# middle value, code will run t3 times
li $t7,0
la $a2,a
add $t4,$a2,$t2  
addi $t4,$t4,-1			# end address will be in t4
to:
beq $t3,$t7,abc			# branch to "abc" if $t3 equal to $t7
lb $t5,0($a2)			# load first character
lb $t6,0($t4) 			# load last character
bne $t5,$t6,xyz			# branch to "xyz" if $t5 is not equal to $t6
addi $a2,$a2,1
addi $t4,$t4,-1			# decrement of last address
addi $t7,$t7,1
b to				# branch to "to"
xyz:
li $v0,4
la $a0,mess8
syscall				# display a message
jr $ra				# goes back to the next line from where the procedure was called
abc:
li $v0,4
la $a0,mess7
syscall				# display a message
jr $ra				# goes back to the next line from where the procedure was called
###################################
###### string copy procedure ######
###################################
strcopy:
string1:
li $t2,0			# counter
def:
lb $t3,0($a2)			# load first character and so on
beqz $t3,pqr			# branch to "pqr" if $t3 equal to zero
addi $a2,$a2,1
addi $t2,$t2,1
b def
pqr:
addi $t2,$t2,-1			# length of first string
string2:
li $t4,0			# counter
quit:
lb $t5,0($a3)			# load first character and so on
beqz $t5,still			# branch to "still" if $t5 equal to zero
addi $a3,$a3,1
addi $t4,$t4,1
b quit
still:
addi $t4,$t4,-1			# length of second string
pro:
bne $t2,$t4,lab			# branch to "lab" if $t2 is not equal to $t4
la $a2,a			# loads the first address of first string
la $a3,c			# loads the first address of second string
li $t9,0
fun:
beq $t9,$t4,jump		# branch to "jump" if $t9 equal to $t4
lb $t6,0($a2)			# loading first character of first string and so on
lb $t7,0($a3)			# loading first character of second string and so on
addi $a2,$a2,1
addi $a3,$a3,1
addi $t9,$t9,1
beq $t6,$t7,fun			# branch to "fun" if $t6 equal to $t7
lab:
move $a0,$zero
li $v0,1
syscall				# displays an integer
b core				# branch to "core"
jump:
li $t8,1
move $a0,$t8
li $v0,1
syscall				# displays an integer
core:				# branch to "core"
jr $ra				# goes back to the next line from where the procedure was called
################################
###### nextline procedure ######
################################
nxt:
li $t3,0			# empty register, code runs till we reach 0
jhg:				# loop through the string until we reach the null terminator \0
lb $t4,0($a2)			# loads the first character and so on
beq $t4,$t3,end_loop		# branch to "end_loop" if $t4 is equal to $t3
beq $t4,32,skip			# if the current word is not a space, print it
li $v0,11			
move $a0,$t4
syscall				# prints character
addi $a2,$a2,1
b jhg				# branch to "jhg"
skip:				# if the character is a space, print a newline
li $v0,4
la $a0,mess3
syscall				# displays a message
addi $a2,$a2,1
b jhg				# branch to "jhg"
end_loop:	
jr $ra				# goes back to the next line from where the procedure was called
end:
li $v0,4
la $a0,i
syscall				# displays a message		
li $v0,5
syscall				# takes input
move $t2,$v0			# moves $v0 contents to $t2
beq $t2,0,completed		# branch to "completed" if $t2 is equal to zero
beq $t2,1,start			# branch to "start" if $t2 is equal to 1
completed:
li $v0, 10
syscall				# terminates the program
