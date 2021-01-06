INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096

.data
	number DWORD ?
	oddV SDWORD 300 DUP(?)
	evenV SDWORD 300 DUP(?)
	countOdd DWORD 0
	countEven DWORD 0
	maxOdd SDWORD 0
	minEven SDWORD 0
	totalOdd SDWORD 0
	totalEven SDWORD 0
	averageOdd REAL8 ?
	averageEven REAL8 ?
	spaceStr BYTE " ", 0
.code
main PROC
	mov esi, OFFSET oddV
	mov edi, OFFSET evenV
input:
	call ReadInt
	cmp eax, 0
	je stop
	mov number, eax
	and eax, 1
	jz evenValue
	add countOdd, 1
	mov eax, number
	add totalOdd, eax
	mov [esi], eax
	cmp eax, maxOdd
	jle nothing1
	mov maxOdd, eax
nothing1:
	add esi, 4
	jmp input
evenValue:
	add countEven, 1
	mov eax, number
	add totalEven, eax
	mov [edi], eax
	cmp eax, minEven
	jge nothing2
	mov minEven, eax
nothing2:
	add edi, 4
	jmp input
stop:
	call allOutPut
	ret
main ENDP

allOutPut PROC
	mov esi, OFFSET oddV
	mov ecx, countOdd
	mov eax, countOdd
	call WriteDec
oddOut:
	mov edx, OFFSET spaceStr
	call WriteString
	mov eax, [esi]
	cmp eax, 0
	jg oddDec
	call WriteInt
	jmp oddEnd
oddDec:
	call WriteDec
oddEnd:
	add esi, 4
	loop oddOut
	call Crlf
	
	mov edi, OFFSET evenV
	mov ecx, countEven
	mov eax, countEven
	call WriteDec
evenOut:
	mov edx, OFFSET spaceStr
	call WriteString
	mov eax, [edi]
	cmp eax, 0
	jg evenDec
	call WriteInt
	jmp evenEnd
evenDec:
	call WriteDec
evenEnd:
	add edi, 4
	loop evenOut
	call Crlf

	mov eax, maxOdd
	cmp eax, 0
	jg mDec
	call WriteInt
	jmp mStop
mDec:
	call WriteDec
mStop:
	mov edx, OFFSET spaceStr
	call WriteString
	mov eax, minEven
	cmp eax, 0
	jg mDec
	call WriteInt
	jmp toTotal

toTotal:
	call Crlf
	mov eax, totalOdd
	cmp eax, 0
	jg tOddDec
	call WriteInt
	jmp tOStop
tOddDec:
	call WriteDec
tOStop:
	mov edx, OFFSET spaceStr
	call WriteString
	mov edx, 0
	mov eax, totalEven
	cmp eax, 0
	jg tEvenDec
	call WriteInt
	jmp toAvg
tEvenDec:
	call WriteDec

toAvg:
	call Crlf
	finit
	fild totalOdd
	fidiv countOdd
	fstp averageOdd
	fld averageOdd
	call WriteFloat
	mov edx, OFFSET spaceStr
	call WriteString
	fild totalEven
	fidiv countEven
	fstp averageEven
	fld averageEven
	call WriteFloat
	ret
allOutPut ENDP
END main