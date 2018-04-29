

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
	la $ra, ($s1)
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
	li $v0, 0
	la $s1, ($ra)
	lbu $t8, 0($a1)
	addi $s2, $a0, 0
	jal findChar
	addi $a0, $s2, 0
	move $v0, $t3
	la $ra, ($s1)
	li $t9, 0
	li $t8, 0
	li $t3, 0
	jr $ra
	
	findChar:	
		lbu $t9, 0($a0)
		beq $t9, 0x00, exit
		beq $t9, $t8, exit
		addi $t3, $t3, 1
		addi $a0, $a0, 1
		j findChar
	
strcmp: 
	li $v0, 0
	la $s1, ($ra)
	blt $a2, 0, exit
	addi $s7, $a0, 0
	addi $s6, $a1, 0
	jal findMinMax
	la $ra, ($s1)
	bgtu $a2, $t9, exit
	bgtu $a2, $t8, exit
	jal setCount
	jal whichString
	addi $a1, $s6, 0
	addi $a0, $s7, 0
	jal checkMatch
	move $v0, $t4
	la $ra, ($s1)
	jr $ra
	
	setCount:
		bgt $a2, 0, countIsInput
		jr $ra
		
		countIsInput:
			move $s3, $a2
			jr $ra
			
	checkMatch:
		beq $t4, $s3, match
		li $v1, 0
		jr $ra
		
		match:
			li $v1, 1
			jr $ra
	
	whichString:
		beq $t7, 0, a0MaxCheck
		beq $t7, 1, a1MaxCheck
		
		a0MaxCheck:
			addi $t3, $t3, 1		# Loop Count	
			bgtu $t3, $s3, exit
			lbu $t6, 0($a0)
			lbu $t5, 0($a1)
			addi $a0, $a0, 1
			addi $a1, $a1, 1
			beq $t6, $t5, charMatcha0
			beq $t3, $t9, exit
			addi $a1, $s6, 0		# Resetting to check a1 sequence at new character in a0
			j a0MaxCheck
			
			charMatcha0:
				addi $t4, $t4, 1
				j a0MaxCheck
				
		a1MaxCheck:
			addi $t3, $t3, 1		# Loop Count	
			bgtu $t3, $s3, exit
			lbu $t5, 0($a1)
			lbu $t6, 0($a0)
			addi $a1, $a1, 1
			addi $a0, $a0, 1
			beq $t6, $t5, charMatcha1
			beq $t3, $t8, exit
			addi $a0, $s7, 0		# Resetting to check a0 sequence at new character in a1
			j a1MaxCheck
			
			charMatcha1:
				addi $t4, $t4, 1
				j a1MaxCheck	
	
	findMinMax:
		la $s2, ($ra)
		jal a0Length
		jal a1Length
		addi $a0, $s7, 0
		addi $a1, $s6, 0
		bgtu $t8, $t9, a1IsMax
		move $s3, $t9
		la $ra, ($s2)
		jr $ra
		
		a0Length:
			lbu $t1, 0($a0)
			addi $a0, $a0, 1
			beq $t1, 0, exit
			addi $t9, $t9, 1			# t9 = a0 length
			j a0Length
		
		a1Length:
			lbu $t1, 0($a1)
			addi $a1, $a1, 1
			beq $t1, 0, exit
			addi $t8, $t8, 1			# t8 = a1 length
			j a1Length	
			
		a1IsMax:
			addi $t7, $t7, 1
			move $s3, $t8
			la $ra, ($s2)
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
	li $v0, -1
	la $t3, 0
	la $s1, ($ra)
	addi $s7, $a0, 0
	la $a1, Alphabet
	addi $s6, $a1, 0
	jal splitUpper:
	

	jr $ra
	
	deleteDup:
		lbu $t9, 0($a0)
		addi $a0, $a0, 1
		j 
		
	
	splitUpper:
		beq $a0, 0, exit
		lbu $t9, 0($a0)
		bltu $t9, 'A', deleteChar
		bgtu $t9, 'Z', deleteChar
		addi $a0, $a0, 1
		j splitUpper
		
		deleteChar:
			addi $a0, $a0, 1
			sb $t9, 0($a0)
			subi $a0, $a0, 1
			j splitUpper

keyIndex:
	li $v0, -1
	la $t3, 0
	la $s1, ($ra)
	addi $s7, $a0, 0
	la $a1, FMorseCipherArray
	jal checkKey
	jal getKey
	addi $a0, $s7, 0
	la $ra, ($s1)
	jr $ra
	
	checkKey:
		addi $t3, $t3, 1
		bgtu $t3, 78, exit
		lbu $t9, 0($a0)
		lbu $t8, 0($a1)
		addi $a0, $a0, 1
		addi $a1, $a1, 1
		beq $t9, $t8, matchKey
		li $t4, 0
		addi $a0, $s7, 0
		j checkKey
		
		matchKey:
			addi $t4, $t4, 1
			beq $t4, 3, verifyMatch
			j checkKey
			
			verifyMatch:
				li $t5, 3
				div $t3, $t5
				mfhi $t6
				beq $t6, 0, exit
				j checkKey		
			
	getKey:
		bltu $t4, 3, exit
		mflo $v0
		subi $v0, $v0, 1
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

Alphabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
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



