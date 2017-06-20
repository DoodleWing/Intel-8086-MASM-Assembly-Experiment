DATA SEGMENT

mess1 DB 0AH,'Please input string:',0AH,'$'
mess2 DB 0AH,'Please input another string:',0AH,'$'
alert1 DB 0AH,'Equal',0AH,'$'
alert2 DB 0AH,'Not equal',0AH,'$'
result DB 0
buff1 DB 80,?,80 DUP(0)
buff2 DB 80,?,80 DUP(0)

DATA ENDS

STACK SEGMENT STACK

STACK ENDS

CODE SEGMENT
	ASSUME DS:DATA,SS:STACK,CS:CODE 
START:
	MOV AX,DATA
	MOV DS,AX
	
	LEA DX,mess1
	MOV AH,9
	INT 21H
	
	LEA DX,buff1
	MOV AH,10
	INT 21H
	
	MOV DL,0AH
	MOV AH,2
	INT 21H
	
	MOV BL,buff1+1
	MOV BH,0
	MOV BYTE PTR [buff1+BX+2],'$'
	
	LEA DX,mess2
	MOV AH,9
	INT 21H
		
	LEA DX,buff2
	MOV AH,10
	INT 21H
	
	MOV DL,0AH
	MOV AH,2
	INT 21H
	
	MOV BL,buff2+1
	MOV BH,0
	MOV BYTE PTR [buff2+BX+2],'$'
	
	MOV CL,buff1+1
	MOV CH,buff2+1
	CMP CL,CH
	JNZ NEQ
	
	MOV BX,DS
	MOV ES,BX
	LEA SI,buff1
	LEA DI,buff2
	CLD
	MOV CH,0
	REPZ CMPSB
	JNZ NEQ
IEQ:	MOV AL,1
	MOV result,AL
	LEA DX,alert1
	MOV AH,9
	INT 21H
	JMP EXT

NEQ:	MOV AL,-1
	MOV result,AL
	LEA DX,alert2
	MOV AH,9
	INT 21H
	JMP EXT

EXT:	MOV AH,4CH
	INT 21H
CODE ENDS
	END START
;编程实现:对 str1 和 str2 两个字符串进行比较，若两串相同，在 result 单元中置 1，否 则置-1