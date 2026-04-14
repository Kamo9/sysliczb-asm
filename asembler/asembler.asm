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
	txt5 db 13,10,'podaj liczbe (oct,Znak-Modul): ',0
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
	mov zm1,0000h
binar:
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

oct:
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt2, LENGTHOF txt2, 0, 0
	mov bx,[zm1]
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



decym:
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
	shl ax,1 ;
	shr ax,1 ; pozbycie sie bitu znaku
	mov bx,10

		mov ecx,5
dziel:
		jecxz odcz_dziel
	mov dx,0
	div bx
	add dx,30h
	push edx
		loop dziel

		mov ecx,5
odcz_dziel:
		jecxz heks1
	pop edx
	mov [ConsoleChar],dl
	push ecx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop ecx
		loop odcz_dziel

heks1:
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt4, LENGTHOF txt4, 0, 0
	mov ax,[zm1]
	shr ax,12
	cmp al,10
	jb hekscyfra1
	add al,55
	jmp heks1_wys
hekscyfra1:
	add al,30h

heks1_wys:
	mov [ConsoleChar],al
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

heks2:
	push eax
	mov ax,[zm1]
	shl ax,4
	shr ax,12
	cmp al,10
	jb hekscyfra2
	add al,55
	jmp heks2_wys
hekscyfra2:
	add al,30h

heks2_wys:
	mov [ConsoleChar],al
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

heks3:
	push eax
	mov ax,[zm1]
	shl ax,8
	shr ax,12
	cmp al,10
	jb hekscyfra3
	add al,55
	jmp heks3_wys
hekscyfra3:
	add al,30h

heks3_wys:
	mov [ConsoleChar],al
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

heks4:
	push eax
	mov ax,[zm1]
	shl ax,12
	shr ax,12
	cmp al,10
	jb hekscyfra4
	add al,55
	jmp heks4_wys
hekscyfra4:
	add al,30h

heks4_wys:
	mov [ConsoleChar],al
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0

wejscie:
	ustaw_kursor 5,0
	INVOKE WriteConsole, [consoleOutHandle], ADDR txt5, LENGTHOF txt5, 0, 0
	mov [ConsoleChar],20h
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	ustaw_kursor 6,31
	jmp zakr_znak

usun1:
	ustaw_kursor 6,31
	shr edx,16
	shl edx,16
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,31
zakr_znak:
	pob_znak
	cmp al,'q'
	je koniec
	cmp al,'0'
	je wys_znak
	cmp al,'1'
	je wys_znak
	jmp zakr_znak
wys_znak:
	mov [ConsoleChar],al
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
daj_znak:
	mov dx,0
	sub al,'0'
	mov dl,al
	shl dx,15

usun2:
	ustaw_kursor 6,32
	shr edx,15
	shl edx,15
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,32

zakr1_1:
	pob_znak
	cmp al,0dh
	je enter_loop_part
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun1
	cmp al,'0'
	jae zakr2_1
	jmp zakr1_1
zakr2_1:
	cmp al,'7'
	ja zakr1_1
	jmp wys_modul_1

wys_modul_1:
	mov [ConsoleChar],al
	push edx
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
	pop edx
	sub al,'0'
	shl ax,13
	shr ax,1
	or dx,ax

usun3:
	ustaw_kursor 6,33
	shr edx,12
	shl edx,12
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,33

zakr1_2:
	pob_znak
	cmp al,0dh
	je enter_loop_part
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun2
	cmp al,'0'
	jae zakr2_2
	jmp zakr1_2
zakr2_2:
	cmp al,'7'
	ja zakr1_2
	jmp wys_modul_2

wys_modul_2:
	mov [ConsoleChar],al
	push edx
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
	pop edx
	sub al,'0'
	shl ax,13
	shr ax,4
	or dx,ax

usun4:
	ustaw_kursor 6,34
	shr edx,9
	shl edx,9
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,34

zakr1_3:
	pob_znak
	cmp al,0dh
	je enter_loop_part
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun3
	cmp al,'0'
	jae zakr2_3
	jmp zakr1_3
zakr2_3:
	cmp al,'7'
	ja zakr1_3
	jmp wys_modul_3

wys_modul_3:
	mov [ConsoleChar],al
	push edx
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
	pop edx
	sub al,'0'
	shl ax,13
	shr ax,7
	or dx,ax
	jmp zakr1_4

usun5:
	ustaw_kursor 6,35
	shr edx,6
	shl edx,6
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,35

zakr1_4:
	pob_znak
	cmp al,0dh
	je enter_loop_part
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun4
	cmp al,'0'
	jae zakr2_4
	jmp zakr1_4
zakr2_4:
	cmp al,'7'
	ja zakr1_4
	jmp wys_modul_4

wys_modul_4:
	mov [ConsoleChar],al
	push edx
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
	pop edx
	sub al,'0'
	shl ax,13
	shr ax,10
	or dx,ax

usun6:
	ustaw_kursor 6,36
	shr edx,3
	shl edx,3
	mov [ConsoleChar],20h
	push edx
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop edx
	ustaw_kursor 6,36

zakr1_5:
	pob_znak
	cmp al,0dh
	je enter_loop_part
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun5
	cmp al,'0'
	jae zakr2_5
	jmp zakr1_5
zakr2_5:
	cmp al,'7'
	ja zakr1_5
	jmp wys_modul_5

wys_modul_5:
	mov [ConsoleChar],al
	push edx
	push eax
	INVOKE WriteConsole, [consoleOutHandle], ADDR ConsoleChar, 1, 0, 0
	pop eax
	pop edx
	sub al,'0'
	shl ax,13
	shr ax,13
	or dx,ax
	jmp enter_loop_part


ety7:
	push edx
enter_loop:
	pob_znak
	cmp al,'q'
	je koniec
	cmp al,08h
	je usun6
	cmp al,0dh
	jne enter_loop
	pop edx
	mov zm1,dx
	jmp binar
enter_loop_part:
	mov zm1,dx
	jmp binar
koniec:
	INVOKE ExitProcess, 0
main endp
	public main
END main