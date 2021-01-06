INCLUDE Irvine32.inc
includelib legacy_stdio_definitions.lib

.386
.model flat, stdcall
.stack 4096


AllPrimeFactors PROTO C,	;build function AllPrimeFactors
N: DWORD


.data
formatStr BYTE "%d", 0		;print %d
num DWORD ?					;input num
Cnt DWORD 0					;counter

.code
asmMain PROC C
	INVOKE scanf, ADDR formatStr, ADDR num		;input a num by using scanf
    INVOKE AllPrimeFactors, num					;num throw in AllPrimeFactor execute

	mov Cnt, eax								;get the counter and save in Cnt
	INVOKE printf, ADDR formatStr, Cnt			;print Cnt
	ret
asmMain ENDP
END