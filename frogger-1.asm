#
# CSC258H5S Fall 2021 Assembly Final Project
# University of Toronto, St. George
#
# Student: Mahathi Gandhamaneni, 1007008140
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# - Milestone 3
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#

.data # start of data values section
	displayAddress: .word 0x10008000

	# colors
	redColor: .word 0xff0000 	# stores the red color code
	brownColor: .word 0x964b00 	# stores the brown color code
	pinkColor: .word 0xfe019a 	# stores the brown color code
	greenColor: .word 0x0b4717 	# stores the green color code
	blueColor: .word 0x0000ff 	# stores the blue color code
	yellowColor: .word 0xffff00 	# stores the yellow color code
	greyColor: .word 0x312323 	# stores the grey color code
	
	# Frog Location
	frogPosition: .word 3640 	# stores the position of the frog
	
	# Vehicle Positions
	v1Position: .word 2560
	v2Position: .word 2624
	v3Position: .word 3088
	v4Position: .word 3168
	
	# Log Positions
	l1Position: .word 1040
	l2Position: .word 1104
	l3Position: .word 1568
	l4Position: .word 1632
	
.text # start of program instruction

lifeStorage:
	addi $a1, $zero, 2
main: # initial line to run when executing the program

Frog: 
	lw $t0, displayAddress	
	lw $t1, pinkColor
	la $t3, frogPosition	
	lw $t9, 0($t3)		
	add $t9, $t9, $t0

Vehicle1Setup: 
	lw $t0, displayAddress	
	la $t2, v1Position
	lw $s3, 0($t2)	
	add $s3, $s3, $t0
	
Vehicle2Setup: 
	lw $t0, displayAddress	
	la $t2, v2Position
	lw $s0, 0($t2)	
	add $s0, $s0, $t0
	
Vehicle3Setup: 
	lw $t0, displayAddress	
	la $t3, v3Position
	lw $s1, 0($t3)	
	add $s1, $s1, $t0
	
Vehicle4Setup: 
	lw $t0, displayAddress	
	la $t4, v4Position
	lw $s2, 0($t4)	
	add $s2, $s2, $t0
	
Log1Setup: 
	lw $t0, displayAddress	
	la $t4, l1Position
	lw $s6, 0($t4)	
	add $s6, $s6, $t0
	
Log2Setup: 
	lw $t0, displayAddress	
	la $t4, l2Position
	lw $s7, 0($t4)	
	add $s7, $s7, $t0
	
Log3Setup: 
	lw $t0, displayAddress	
	la $t4, l3Position
	lw $s4, 0($t4)	
	add $s4, $s4, $t0
	
Log4Setup: 
	lw $t0, displayAddress	
	la $t4, l4Position
	lw $s5, 0($t4)	
	add $s5, $s5, $t0
	
	
mainLoop:
	jal ResetScreen
	
	jal GoalArea
	jal WaterArea
	jal SafeArea
	jal RoadArea
	jal StartArea
	
	jal Vehicle1
	jal Vehicle2
	jal Vehicle3
	jal Vehicle4
	
	jal Log1 
	jal Log2
	jal Log3
	jal Log4
	jal Frogshape
	
	j mainLoop


ResetScreen:	
	li $v0, 32 			
	li $a0, 250			
	syscall
	

StartArea: 				
	lw $t0, displayAddress 		
	lw $t1, greenColor 		
	addi $t2, $zero, 128		
	la $t3, 3584($t0) 		
StartAreaLoop:	
	beq $t2, $zero, StartAreaLoopend
	sw $t1, ($t3) 			
	addi $t3, $t3, 4 		
	addi $t2, $t2, -1 		
	j StartAreaLoop 		
StartAreaLoopend:
	jr $ra 				
	
	
	
RoadArea: 				
	lw $t0, displayAddress 		
	lw $t1, greyColor 		
	addi $t2, $zero, 256		
	la $t3, 2560($t0) 		
RoadLoop:	
	beq $t2, $zero, RoadLoopend 	
	sw $t1, ($t3) 			
	addi $t3, $t3, 4 		
	addi $t2, $t2, -1 		
	j RoadLoop 			
RoadLoopend:
	jr $ra 				
	
	
	
SafeArea: 				
	lw $t0, displayAddress 		
	lw $t1, yellowColor 		
	addi $t2, $zero, 128		
	la $t3, 2048($t0) 		
SafeLoop:	
	beq $t2, $zero, SafeLoopend 	
	sw $t1, ($t3) 			
	addi $t3, $t3, 4 		
	addi $t2, $t2, -1 		
	j SafeLoop 			
SafeLoopend: 
	jr $ra 				
	
	
	
WaterArea: 				
	lw $t0, displayAddress 		
	lw $t1, blueColor 		
	addi $t2, $zero, 256		
	la $t3, 1024($t0) 		
WaterLoop:	
	beq $t2, $zero, WaterLoopend	
	sw $t1, ($t3)
	beq $t3, $t9, LifeCounter			
	addi $t3, $t3, 4 		
	addi $t2, $t2, -1 		
	j WaterLoop 			
WaterLoopend:
	jr $ra 				
	
	
	
GoalArea: 				
	lw $t0, displayAddress 		
	lw $t1, greenColor 		
	addi $t2, $zero, 256		
	la $t3, 0($t0) 			
GoalLoop:	
	beq $t2, $zero, GoalLoopend    
	sw $t1, ($t3) 			
	addi $t3, $t3, 4 		
	addi $t2, $t2, -1               
	j GoalLoop 			
GoalLoopend:
	jr $ra                      	


Frogshape:	
	lw $t1, pinkColor

	lw $t8, 0xffff0000
	beq $t8, 1, keyboard_input
	
	sw $t1, ($t9)		
	sw $t1, 12($t9)
	sw $t1, 128($t9)
	sw $t1, 132($t9)
	sw $t1, 136($t9)
	sw $t1, 140($t9)
	sw $t1, 260($t9)
	sw $t1, 264($t9)
	sw $t1, 384($t9)
	sw $t1, 388($t9)
	sw $t1, 392($t9)
	sw $t1, 396($t9)
	jr $ra


Vehicle1: 
	lw $t1, redColor
	addi $t7, $zero, 8
Vehicle1Loop:
	beq $t7, $zero, Vehicle1Loopend
	sw $t1, 0($s3)
	sw $t1, 128($s3)
	sw $t1, 256($s3)
	sw $t1, 384($s3)
	beq $s3, $t9, LifeCounter
	addi $s3, $s3, 4
	addi $t7, $t7, -1
	j Vehicle1Loop
Vehicle1Loopend:
	addi $t5, $zero, 128
	lw $t8, 1408($s3)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF1
	j ELSE1
	IF1: 
		addi $s3, $s3, -128
	ELSE1:
		addi $s3, $s3, 4
	jr $ra
			
Vehicle2: 
	lw $t1, redColor
	addi $t7, $zero, 8
Vehicle2Loop:
	beq $t7, $zero, Vehicle2Loopend
	sw $t1, 0($s0)
	sw $t1, 128($s0)		
	sw $t1, 256($s0)
	sw $t1, 384($s0)
	beq $s0, $t9, LifeCounter
	addi $s0, $s0, 4
	addi $t7, $t7, -1
	j Vehicle2Loop
Vehicle2Loopend:
	addi $t5, $zero, 64
	lw $t8, 1344($s0)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF2
	j ELSE2
	IF2: 
		addi $s0, $s0, -128
	ELSE2:
		addi $s0, $s0, 4
	jr $ra
		
Vehicle3: 
	lw $t1, redColor
	addi $t7, $zero, 8
Vehicle3Loop:
	beq $t7, $zero, Vehicle3Loopend
	sw $t1, 0($s1)
	sw $t1, 128($s1)		
	sw $t1, 256($s1)
	sw $t1, 384($s1)
	beq $s1, $t9, LifeCounter
	addi $s1, $s1, 4
	addi $t7, $t7, -1
	j Vehicle3Loop
Vehicle3Loopend:
	addi $t5, $zero, 64
	lw $t8, 896($s1)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF3
	j ELSE3
	IF3: 
		addi $s1, $s1, -128
	ELSE3:
		addi $s1, $s1, -4
	jr $ra

Vehicle4:
	lw $t1, redColor
	addi $t7, $zero, 8
Vehicle4Loop:
	beq $t7, $zero, Vehicle4Loopend
	sw $t1, 0($s2)
	sw $t1, 128($s2)		
	sw $t1, 256($s2)
	sw $t1, 384($s2)
	beq $s2, $t9, LifeCounter
	addi $s2, $s2, 4
	addi $t7, $t7, -1
	j Vehicle4Loop
Vehicle4Loopend:
	addi $t5, $zero, 128
	lw $t8, 896($s2)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF4
	j ELSE4
	IF4: 
		addi $s2, $s2, -128
	ELSE4:
		addi $s2, $s2, -4
	jr $ra


Log1:
	lw $t1, brownColor
	addi $t7, $zero, 8
Log1Loop:
	beq $t7, $zero, Log1Loopend
	sw $t1, 0($s6)
	sw $t1, 128($s6)		
	sw $t1, 256($s6)
	sw $t1, 384($s6)
	addi $s6, $s6, 4
	addi $t7, $t7, -1
	j Log1Loop
Log1Loopend:
	addi $t5, $zero, 64
	lw $t8, 896($s6)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF5
	j ELSE5
	IF5: 
		addi $s6, $s6, -128
	ELSE5:
		addi $s6, $s6, 4
	jr $ra
	
Log2:
	lw $t1, brownColor
	addi $t7, $zero, 8
Log2Loop:
	beq $t7, $zero, Log2Loopend
	sw $t1, 0($s7)
	sw $t1, 128($s7)		
	sw $t1, 256($s7)
	sw $t1, 384($s7)
	addi $s7, $s7, 4
	addi $t7, $t7, -1
	j Log2Loop
Log2Loopend:
	addi $t5, $zero, 64
	lw $t8, 896($s7)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF6
	j ELSE6
	IF6: 
		addi $s7, $s7, -128
	ELSE6:
		addi $s7, $s7, 4
	jr $ra
	
Log3: 
	lw $t1, brownColor
	addi $t7, $zero, 8
Log3Loop:
	beq $t7, $zero, Log3Loopend
	sw $t1, 0($s4)
	sw $t1, 128($s4)		
	sw $t1, 256($s4)
	sw $t1, 384($s4)
	addi $s4, $s4, 4
	addi $t7, $t7, -1
	j Log3Loop
Log3Loopend:
	addi $t5, $zero, 64
	lw $t8, 384($s4)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF7
	j ELSE7
	IF7: 
		addi $s4, $s4, -128
	ELSE7:
		addi $s4, $s4, -4
	jr $ra
	
Log4:
	lw $t1, brownColor
	addi $t7, $zero, 8
Log4Loop:
	beq $t7, $zero, Log4Loopend
	sw $t1, 0($s5)
	sw $t1, 128($s5)		
	sw $t1, 256($s5)
	sw $t1, 384($s5)
	addi $s5, $s5, 4
	addi $t7, $t7, -1
	j Log4Loop
Log4Loopend:
	addi $t5, $zero, 64
	lw $t8, 384($s5)
	div $t8, $t5
	mfhi $t5
	beq $t5, $zero, IF8
	j ELSE8
	IF8: 
		addi $s5, $s5, -128
	ELSE8:
		addi $s5, $s5, -4
	jr $ra


keyboard_input:
	lw $t2, 0xffff0004
	beq $t2, 0x61, respond_to_A 
	beq $t2, 0x77, respond_to_W 
 	beq $t2, 0x73, respond_to_S 
 	beq $t2, 0x64, respond_to_D 
 	beq $t2, 0x41, respond_to_A
	beq $t2, 0x57, respond_to_W	
 	beq $t2, 0x53, respond_to_S
 	beq $t2, 0x44, respond_to_D	
 	j Frogshape

respond_to_A:
	addi $t9, $t9, -16
	j Frogshape
respond_to_W:
	addi $t9, $t9, -512
	j Frogshape
respond_to_S:
	addi $t9, $t9, 512
	j Frogshape
respond_to_D:
	addi $t9, $t9, 16
	j Frogshape

LifeCounter:
	 beq $a1, $zero, IF9
	 j ELSE9
	 IF9:
	 	addi $a0, $a0, -3
	 	j Exit
	 ELSE9:
	 	addi $a1, $a1, -1
	 	j main
	 
Exit:
	li $v0, 10 	# terminate the program gracefully
	syscall
