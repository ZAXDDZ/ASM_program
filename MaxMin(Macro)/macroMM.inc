INCLUDE Irvine32.inc

ProductTwo MACRO max, min
	mov eax, max
	mov ebx, min
	imul ebx
ENDM

DivideTwo MACRO max, min
	mov edx, 0
	mov eax, max
	mov ebx, min
	idiv ebx
ENDM

MaxinArr Macro address, size
	LOCAL findMax
	LOCAL notDO1
	LOCAL max
	.data
		max DWORD ?
	.code
	mov ecx, size
	mov esi, OFFSET address
	mov eax, [esi]
findMax:
	cmp eax, [esi]
	jg notDO1
	mov eax, [esi]
	mov max, eax
notDO1:
	add esi, 4
	loop findMax
ENDM

MininArr MACRO address, size
	LOCAL findMin
	LOCAL notDO2
	LOCAL min
	.data
		min DWORD ?
	.code
		mov ecx, size
		mov esi, OFFSET address
		mov eax, [esi]
findMin:
	cmp eax, [esi]
	jl notDO2
	mov eax, [esi]
	mov min, eax
notDO2:
	add esi, 4
	loop findMin
ENDM

PrintInt MACRO intValue
	LOCAL outDec
	LOCAL toEnd
	push eax
	mov eax, intValue
	cmp eax, 0
	jge outDec
	call WriteInt
	jmp toEnd
outDec:
	call WriteDec
toEnd:
	pop eax
ENDM