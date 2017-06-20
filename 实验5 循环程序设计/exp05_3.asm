DATA SEGMENT
ARRAY DB 10,39,18,21,79,65,33,43,22,62
COUNT DW $-ARRAY
DATA ENDS

STACK SEGMENT STACK

STACK ENDS

CODE SEGMENT
	ASSUME DS:DATA,SS:STACK,CS:CODE 
START:
	MOV AX,DATA
	MOV DS,AX
	
	MOV AX,COUNT
	SUB AX,1
	MOV CX,AX				;n=COUNT-1
	MOV SI,1					;SI=1
	
i:	MOV	AL,[ARRAY+SI]		;while 1:temp=array[SI]
	MOV DX,CX
	MOV CX,SI				;k=SI
k:	MOV DI,CX				;for 2:DI=k
	MOV AH,[ARRAY+DI-1]		;
	SUB AH,AL				;array[k-1]>temp
	JS	bre					;if
	MOV	BL,[ARRAY+DI-1]		;array[k]=array[k-1]
	MOV [ARRAY+DI],BL		;end if
	JMP _in
bre:	JMP	_ou					;else break end else
_in:	LOOP k					;end for 2
_ou:	MOV BL,AL				
	MOV [ARRAY+DI],BL		;array[k]=temp
	MOV CX,DX
	INC SI
	LOOP i					;end for 1
	
	MOV AH,4CH
	INT 21H
	
CODE ENDS
	END START