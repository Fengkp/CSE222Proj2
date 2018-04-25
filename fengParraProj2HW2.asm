

##############################################################
# Homework #2
# name: MY_NAME
# sbuid: MY_SBU_ID
##############################################################
.text

##############################
# PART 1 FUNCTIONS 
##############################
toUpper:
	#Define your code here
	li $v0, 0
	la $s1, ($ra)
	addi $s2, $a0, 0
	jal iterate
	addi $a0, $s2, 0
	addi $v0, $a0, 0
	
	# Clear and finish
	li $s2, 0
	li $t9, 0
	la $ra, ($s1)
	li $s1, 0
	jr $ra
	
	iterate:
		lbu $t9, 0($a0)
		beq $t9, 0, exit
		bltu $t9, 0x61, loop
		bgtu $t9, 0x7A, loop
		subi $t9, $t9, 0x20
		sb $t9, 0($a0)
		j iterate
	
	loop: 
		addi $a0, $a0, 1
		j iterate

length2Char:
	#Define your code here
	############################################
	move $t2, $a1
	lbu $t1, 0($a0)
	lbu $t3, 0($t2)
	addi $a0, $a0, 1				# Increment string
	addi $t5, $t5, 1				# Char count
	beq $t1, $t3, foundChar			# If char is equal to input char then exit
	beq $t1, 0, foundChar
	j length2Char
	############################################
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t5, 0
	jr $ra
	
	foundChar:
		subi $t5, $t5, 1				# Char count
		move $v0, $t5
		li $t1, 0
		li $t2, 0
		li $t3, 0
		li $t5, 0
		jr $ra

strcmp: 
	#Define your code here
	############################################
	
	move $s2, $a2
	la $t9, ($ra)					# Saves main.asm
	move $v1, $0
	jal strcmpSetLength
	jal strcmpOption
	jal checkStringMatch
	move $v0, $s3
	la $ra, ($t9)					# Loads main.asm
	############################################
	jr $ra							# Return to main.asm
	
	strcmpOption:
		beq $s2, 0, checkStrings0
		bltu $s2, 0, exit
		bgtu $s2, $s7, exit
		bgtu $s2, 0, checkStrings1
	
	checkStrings0:
		beq $t5, $s5, exit	# Exit on max string size
		addi $t5, $t5, 1
		lbu $t7, 0($a0)
		beq $t7, 0, exit
		lbu $t6, 0($a1)
		beq $t6, 0, exit
		addi $a0, $a0, 1
		addi $a1, $a1, 1
		beq $t7, $t6, charMatch0
		j checkStrings0
		
		charMatch0:
				addi $s3, $s3, 1			# Character count
				j checkStrings0 	
						
	checkStrings1:
		bgtu $a2, $s5, exit
		beq $t5, $s2, exit
		addi $t5, $t5, 1
		lbu $t7, 0($a0)
		lbu $t6, 0($a1)
		addi $a0, $a0, 1
		addi $a1, $a1, 1
		beq $t7, $t6, charMatch1
		j checkStrings1	
		
			charMatch1:
				addi $s3, $s3, 1			# Character count
				j checkStrings1 	
	
	strcmpSetLength:
		la $t8, ($ra)						# Saves strcmp
		jal str1Length
		sub $a0, $a0, $s7
		jal str2Length
		sub $a1, $a1, $s6
		bltu $s7, $s6, maxMin
		move $s5, $s7						# Max
		move $s4, $s6						# Min
		la $ra, ($t8)						# Loads strcmp
		jr $ra								# Return to strcmp
			
			str1Length:
				lbu $t7, 0($a0)
				beq $t7, 0, exit
				addi $a0, $a0, 1
				addi $s7, $s7, 1			# Str1Length
				j str1Length
			
			str2Length:
				lbu $t7, 0($a1)
				beq $t7, 0, exit
				addi $a1, $a1, 1
				addi $s6, $s6, 1			# Str2Length
				j str2Length
				
			maxMin:
				move $s5, $s6				# Max
				move $s4, $s7				# Min
				la $ra, ($t8)
				jr $ra
				
	
	checkStringMatch:
		beq $s3, $s2, stringMatch
		bltu $s3, $s6, exit
		bgtu $a2, $s5, exit
		bltu $s3, $s2, exit		
		beq $s3, $s7, stringMatch
		jr $ra
		
	stringMatch:
		li $v1, 1
		jr $ra
	
	exit:	
		jr $ra
	
	


##############################
# PART 2 FUNCTIONS
##############################

toMorse:
	#Define your code here
	jr $ra

createKey:
	#Define your code here
	jr $ra

keyIndex:
	#Define your code here
	jr $ra

FMCEncrypt:
	#Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	la $v0, FMorseCipherArray
	############################################
	jr $ra

##############################
# EXTRA CREDIT FUNCTIONS
##############################

FMCDecrypt:
	#Define your code here
	############################################
	# DELETE THIS CODE. Only here to allow main program to run without fully implementing the function
	la $v0, FMorseCipherArray
	############################################
	jr $ra

fromMorse:
	#Define your code here
	jr $ra



.data

#finalStr: .space 100000
finalStr: .word 0

MorseCode: .word MorseExclamation, MorseDblQoute, MorseHashtag, Morse$, MorsePercent, MorseAmp, MorseSglQoute, MorseOParen, MorseCParen, MorseStar, MorsePlus, MorseComma, MorseDash, MorsePeriod, MorseFSlash, Morse0, Morse1,  Morse2, Morse3, Morse4, Morse5, Morse6, Morse7, Morse8, Morse9, MorseColon, MorseSemiColon, MorseLT, MorseEQ, MorseGT, MorseQuestion, MorseAt, MorseA, MorseB, MorseC, MorseD, MorseE, MorseF, MorseG, MorseH, MorseI, MorseJ, MorseK, MorseL, MorseM, MorseN, MorseO, MorseP, MorseQ, MorseR, MorseS, MorseT, MorseU, MorseV, MorseW, MorseX, MorseY, MorseZ 

MorseExclamation: .asciiz "-.-.--"
MorseDblQoute: .asciiz ".-..-."
MorseHashtag: .ascii ""
Morse$: .ascii ""
MorsePercent: .ascii ""
MorseAmp: .ascii ""
MorseSglQoute: .asciiz ".----."
MorseOParen: .asciiz "-.--."
MorseCParen: .asciiz "-.--.-"
MorseStar: .ascii ""
MorsePlus: .ascii ""
MorseComma: .asciiz "--..--"
MorseDash: .asciiz "-....-"
MorsePeriod: .asciiz ".-.-.-"
MorseFSlash: .ascii ""
Morse0: .asciiz "-----"
Morse1: .asciiz ".----"
Morse2: .asciiz "..---"
Morse3: .asciiz "...--"
Morse4: .asciiz "....-"
Morse5: .asciiz "....."
Morse6: .asciiz "-...."
Morse7: .asciiz "--..."
Morse8: .asciiz "---.."
Morse9: .asciiz "----."
MorseColon: .asciiz "---..."
MorseSemiColon: .asciiz "-.-.-."
MorseLT: .ascii ""
MorseEQ: .asciiz "-...-"
MorseGT: .ascii ""
MorseQuestion: .asciiz "..--.."
MorseAt: .asciiz ".--.-."
MorseA: .asciiz ".-"
MorseB:	.asciiz "-..."
MorseC:	.asciiz "-.-."
MorseD:	.asciiz "-.."
MorseE:	.asciiz "."
MorseF:	.asciiz "..-."
MorseG:	.asciiz "--."
MorseH:	.asciiz "...."
MorseI:	.asciiz ".."
MorseJ:	.asciiz ".---"
MorseK:	.asciiz "-.-"
MorseL:	.asciiz ".-.."
MorseM:	.asciiz "--"
MorseN: .asciiz "-."
MorseO: .asciiz "---"
MorseP: .asciiz ".--."
MorseQ: .asciiz "--.-"
MorseR: .asciiz ".-."
MorseS: .asciiz "..."
MorseT: .asciiz "-"
MorseU: .asciiz "..-"
MorseV: .asciiz "...-"
MorseW: .asciiz ".--"
MorseX: .asciiz "-..-"
MorseY: .asciiz "-.--"
MorseZ: .asciiz "--.."

FMorseCipherArray: .asciiz ".....-..x.-..--.-x.x..x-.xx-..-.--.x--.-----x-x.-x--xxx..x.-x.xx-.x--x-xxx.xx-"



