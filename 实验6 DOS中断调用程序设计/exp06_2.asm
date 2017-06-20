DATA SEGMENT
Message 		DB 0AH,'please input a capital letter:',0AH,'$'
errorMess 	DB 0AH,'Not a capital letter,please try again!',0AH,'$'
successMess DB 0AH,'OK, output: ','$'
exitMess		DB 0AH,'Bye~','$'
letter		DB 0
DATA ENDS

STACK SEGMENT STACK
DB 100 DUP(0)
STACK ENDS

CODE SEGMENT
	ASSUME DS:DATA,SS:STACK,CS:CODE 
START:
	MOV AX,DATA
	MOV DS,AX
	
sta:	LEA DX,Message
	MOV AH,9
	INT 21H
	
	MOV AH,1
	INT 21H
	
	MOV AH,9
	CMP AL,'A'
	JS err
	CMP AL,'Z'
	JNS err
	CMP	AL,'Q'
	JZ ext
	
	MOV letter,AL
	LEA DX,successMess
	INT 21H
	MOV AH,2
	MOV DL,letter
	INT 21H
	JMP suc
	
err:LEA DX,errorMess
	INT 21H
suc:JMP sta
	
ext:LEA DX,exitMess
	MOV AH,9
	INT 21H
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START