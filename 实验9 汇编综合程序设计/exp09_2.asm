DATA SEGMENT

DATA ENDS

STACK SEGMENT STACK

STACK ENDS

CODE SEGMENT
	ASSUME DS:DATA,SS:STACK,CS:CODE 
	
	;子程序功能：输出一位十六进制数字
	;入口参数：DL=数字
	PrintHexNumber PROC
		PUSH BX
		PUSH SI
		PUSH AX					;保存寄存器值
		AND DX,000FH				;取最低四位
		LEA BX,NUMBERS			;装载数字
		MOV SI,DX;				;将数字设置为偏移量
		MOV DL,[BX+SI]			;根据偏移量可以在数字中输出对应的
		MOV AH,2
		INT 21H					;输出数字
		POP AX
		POP SI					
		POP BX					;还原寄存器值
		RET						;函数返回
	PrintHexNumber ENDP 
	
START:
	MOV AX,DATA
	MOV DS,AX
	
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START