DATA SEGMENT
message DB 'please input a string:$'
buf     DB 20,?,20 DUP(0)
DATA ENDS

STACK SEGMENT STACK

STACK ENDS

CODE SEGMENT
	ASSUME DS:DATA,SS:STACK,CS:CODE 
START:
	MOV AX,DATA
	MOV DS,AX
	
	mov dx,offset message
	mov ah,9
	int 21h
	
	mov dx,offset buf
	mov ah,10
	int 21h
	
	mov ah,2
	mov dl,0ah
	int 21h
	mov dl,0dh
	int 21h
	
	mov bl,buf+1
	mov bh,0
	mov byte ptr buf+2[bx],'$'
	mov dx,offset buf+2
	mov ah,9
	int 21h
	
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START