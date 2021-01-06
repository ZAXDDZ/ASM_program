INCLUDE macroMM.inc

.586
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD



.data
	numarr DWORD 300 DUP(?)
	max DWORD 0
	min DWORD 0
	count DWORD ?
	total DWORD 0
	productt DWORD 0
	quotient DWORD 0
	remainder DWORD 0
	space BYTE " ", 0
.code
main PROC
	call ReadDec
	mov count, eax
	mov ecx, eax
	mov esi, OFFSET numarr
input:
	call ReadInt
	mov [esi], eax
	add esi, 4
	loop input
	
	MininArr numarr, count
	mov min, eax
	PrintInt min
	mov edx, OFFSET space
	call WriteString
	MaxinArr numarr, count
	mov max, eax
	PrintInt max
	call Crlf

	mov eax, total
	mov esi, 0
	mov ecx, count
calculTotal:
	add eax, numarr[esi]
	add esi, 4
	mov total, eax
	loop calculTotal
	PrintInt total
	call Crlf

	ProductTwo max, min
	mov productt, eax
	PrintInt productt
	call Crlf
	
	DivideTwo max, min
	mov quotient, eax
	mov remainder, edx
	PrintInt quotient
	mov edx, OFFSET space
	call WriteString
	PrintInt remainder
	call Crlf
	
	INVOKE ExitProcess, 0
main ENDP
END main