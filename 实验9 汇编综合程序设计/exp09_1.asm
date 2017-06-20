DATA SEGMENT
NUMBERS DB '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
MESSAGE DB 'ASCII Shower',0AH,'$'
EXITMESSAGE DB 'BYE~	$'
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

	;子程序功能：输出一位二进制数字
	;入口参数：DL=数字
	PrintBinNumber PROC
		PUSH BX
		PUSH SI					
		PUSH AX					;保存寄存器值
		AND DX,0001H				;取最低一位
		LEA BX,NUMBERS			;装载数字
		MOV SI,DX;				;将数字设置为偏移量
		MOV DL,[BX+SI]			;根据偏移量可以在数字中输出对应的
		MOV AH,2
		INT 21H					;输出数字
		POP AX
		POP SI					
		POP BX					;还原寄存器值
		RET						;函数返回
	PrintBinNumber ENDP	
	
START:
	MOV AX,DATA					;设置数据段
	MOV DS,AX
	LEA DX,MESSAGE
	MOV AH,9
	INT 21H
for:
	MOV CX,1						;循环内设置CX循环次数，循环不停止
	MOV AH,1	
	INT 21H						;输入一个字母，对应ASCII码值存入AL
	PUSH DX
	PUSH AX
	MOV AH,2
	MOV DL,0AH
	INT 21H
	POP AX
	POP DX
	
	PUSH CX						;保存CX寄存器
	MOV CX,8	
	ROL AX,CL					;循环左移8位，将低8位的内容移入高8位
	POP CX
	MOV CX,2						;十六进制，需要取两位数
s16:
	PUSH CX
	MOV CX,4	
	ROL AX,CL					;循环左移4位，将最高位数字送入最低位
	POP CX
	MOV DX,AX					;数字转移
	CALL PrintHexNumber			;调用子程序输出
	LOOP s16
	
	PUSH DX
	PUSH AX
	MOV DL,0AH
	MOV AH,2
	INT 21H
	POP AX
	POP DX
	
	MOV CX,8
	ROL AX,CL					;循环左移8位，准备输出二进制
s2:	
	ROL AX,1
	MOV DX,AX
	CALL PrintBinNumber			;二进制输出
	LOOP s2
	
	PUSH DX
	PUSH AX
	MOV DL,0AH
	MOV AH,2
	INT 21H
	POP AX
	POP DX
	
	CMP AL,'Q'					;输入字母Q或者q来退出
	JZ exit
	CMP AL,'q'
	JZ exit
	LOOP for
	
exit:
	LEA DX,EXITMESSAGE
	MOV AH,9
	INT 21H
	MOV AH,4CH
	INT 21H
CODE ENDS
	END START