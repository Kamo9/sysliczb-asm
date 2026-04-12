.486
.model flat, stdcall
.stack 4096

include winapi.inc 
include macros.inc

.data
	txt1 db 'wartosc BIN: ',0
	txt2 db 13,10,'wartosc OCT: ',0
	txt3 db 13,10,'wartosc DEC: ',0
	txt4 db 13,10,'wartosc HEX: ',0
	zm1  dw 4098

	cursorPosition COORD <>
	evEvents DWORD ?
.code
plus proc
	mov [ConsoleChar],'+'
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	ret
plus endp

minus proc
	mov [ConsoleChar],'-'
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	ret
minus endp

main proc
		INVOKE GetStdHandle, STD_INPUT_HANDLE
		mov [consoleInHandle],eax
		INVOKE GetStdHandle, STD_OUTPUT_HANDLE
		mov [consoleOutHandle],eax
		INVOKE SetConsoleMode,[consoleInHandle], 0
		INVOKE FlushConsoleInputBuffer, [consoleInHandle]
	mov zm1,1ff3h
cos:
	ustaw_kursor 0,0
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt1, LENGTHOF txt1, 0, 0
	mov bx,[zm1]
	mov ecx,8
binh_1:
	push ecx
	rcl bh,1
	jc binh_2
	mov [ConsoleChar],'0'
	jmp binh_3
binh_2:
	mov [ConsoleChar],'1'
binh_3:
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0 
	pop ecx
	loop binh_1

mov ecx,8

binl_1:
	push ecx
	rcl bl,1
	jc binl_2
	mov [ConsoleChar],'0'
	jmp binl_3
binl_2:
	mov [ConsoleChar],'1'
binl_3:
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0 
	pop ecx
	loop binl_1
cos2:
	
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt2, LENGTHOF txt2, 0, 0
	mov bx,[zm1]

oct:
	shr bx,15 ; znak
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0 

	mov bx,[zm1] ; pierwsza cyfra
	shl bx,1
	shr bx,13
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

	mov bx,[zm1] ; druga cyfra
	shl bx,4
	shr bx,13
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

	mov bx,[zm1] ; trzecia cyfra
	shl bx,7
	shr bx,13
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

	mov bx,[zm1] ; czwarta cyfra
	shl bx,10
	shr bx,13
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

	mov bx,[zm1] ; pi¹ta cyfra
	shl bx,13
	shr bx,13
	add bl,30h
	mov [ConsoleChar],bl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0



cos3:
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt3, LENGTHOF txt3, 0, 0
	mov bx,[zm1] ; znak
	shr bx,15
	cmp bl,01h
	jne dplus
dminus:
	INVOKE minus
	jmp decy
dplus:
	INVOKE plus
	jmp decy

decy:
	mov ax,[zm1]
	mov bx,10
	div bx
	mov dl,ah
	add dl,30h
	mov [ConsoleChar],dl
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

ety7:
	INVOKE ReadConsole, [consoleInHandle], ADDR ConsoleChar, 1, ADDR evEvents, 0
	INVOKE ExitProcess, 0
main endp
	public main
END main