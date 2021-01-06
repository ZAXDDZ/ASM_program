INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD


.data
Min SDWORD 0					;save minimum in global
Max SDWORD 0					;save maximum in global
N DWORD ?						;save the number of input number
intarr SDWORD 200 dup(?)		;array of input number
maxstr BYTE "Max= ",0
minstr BYTE "Min= ",0


.code
main PROC
		call ReadDec
		mov N, eax				;input the number of input number and save

		mov ecx, N				;counter = N
		mov esi, 0				;array esi is at first element
L1:
		call ReadInt
		mov intarr[esi], eax
		add esi, TYPE SDWORD
		loop L1					;input number do N times

		mov ecx, N				;ecx == 0 and let ecx == N

		call Crlf
		call FindMax			;call FindMax process
		call FindMini			;call FindMini process
		
		;call DumpRegs

	INVOKE ExitProcess, 0
main ENDP

FindMini PROC
		push esi
		mov esi, 0				;let esi count at array first element
		push ecx
		mov Min, eax			;Min is the last element intarr set it is the smallest
Lmini:
		mov eax, intarr[esi]
		cmp eax, Min
		jge NotMin
		mov Min, eax
NotMin:	
		add esi, TYPE SDWORD
		loop Lmini				;compare every element in intarr and find the smallest

		mov edx,OFFSET minstr
		call WriteString
		mov eax, Min
		cmp eax, 0
		jge UnsignedOut
		call WriteInt			;if Min < 0 need to print "-"
		jmp LastStep			;when has printed, doesn't need to do WriteDec
UnsignedOut:
		call WriteDec			;if Min >= 0 doesn't need to print "+"
LastStep:
		call Crlf

		pop ecx
		pop esi
		ret
FindMini ENDP

FindMax PROC
		push esi
		mov esi, 0				;let esi count at array first element
		push ecx
		mov Max, eax			;Max is the last element intarr set it is the largest
Lmax:
		mov eax, intarr[esi]
		cmp eax, Max
		jl NotMax
		mov Max, eax
NotMax:
		add esi, 4
		loop Lmax				;compare every element in intarr and find the largest

		mov edx,OFFSET maxstr
		call WriteString
		mov eax, Max
		cmp eax, 0
		jge UnsignedOut
		call WriteInt			;if Min < 0 need to print "-"
		jmp LastStep			;when has printed, doesn't need to do WriteDec
UnsignedOut:
		call WriteDec			;if Min >= 0 doesn't need to print "+"
LastStep:
		call Crlf

		pop ecx
		pop esi
		ret
FindMax ENDP

END main