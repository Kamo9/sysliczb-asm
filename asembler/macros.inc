
.data
ConsoleChar db 0		; macros
ConsoleTmp  dd 0
consoleInHandle DD 0 ; uchwyt okna konsoli in
consoleOutHandle DD 0; uchwyt okna konsoli out


pob_znak macro
; out:	AL - kod ASCII
		pushad
		INVOKE GetStdHandle, STD_INPUT_HANDLE
		mov [consoleInHandle],eax
		INVOKE SetConsoleMode,[consoleInHandle], 0
		INVOKE FlushConsoleInputBuffer, [consoleInHandle]
		INVOKE ReadConsole, [consoleInHandle], ADDR ConsoleChar, 1, ADDR ConsoleTmp, 0
		popad
		mov al, [ConsoleChar]
endm

pob_znak_ECHO macro
; out:	AL - kod ASCII
		pushad
		INVOKE GetStdHandle, STD_INPUT_HANDLE
		mov [consoleInHandle],eax
		INVOKE SetConsoleMode,[consoleInHandle], 0
		INVOKE FlushConsoleInputBuffer, [consoleInHandle]
		INVOKE ReadConsole, [consoleInHandle], ADDR ConsoleChar, 1, ADDR ConsoleTmp, 0
		popad
		mov al, [ConsoleChar]
		INVOKE putchar, eax
		mov al, [ConsoleChar]
endm

ustaw_kursor macro wiersz, kolumna
		pushad
		INVOKE GetStdHandle, STD_OUTPUT_HANDLE
		mov [consoleOutHandle],eax
		mov ax, wiersz
		shl eax,16
		mov ax, kolumna
		push eax
		push [consoleOutHandle]
		call SetConsoleCursorPosition
	;	INVOKE SetConsoleCursorPosition, [consoleOutHandle], [cursorPosition]
		popad
endm

wysw_znak macro znak_ASCII
		pushad
		mov	[ConsoleChar], znak_ASCII
		INVOKE GetStdHandle, STD_OUTPUT_HANDLE
		mov [consoleOutHandle],eax
		INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
		popad
endm

wyswietl macro txt
		pushad
		INVOKE GetStdHandle, STD_OUTPUT_HANDLE
		mov [consoleOutHandle],eax
		INVOKE WriteConsole, [consoleOutHandle], ADDR txt, LENGTHOF txt, 0, 0 
		popad
endm

end_prog macro
		INVOKE	ExitProcess, 0
endm
