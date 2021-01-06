INCLUDE Irvine32.inc

.586
.model flat, stdcall
.stack 4096

.data
	number DWORD 0
	power DWORD ?
	star_str BYTE " * ",0
	pow_str BYTE "^",0

.code
main PROC					;main start
	call PrimeFactor		;call PrimeFactor procedure
	ret
main ENDP					;main end

PrimeFactor PROC			;PrimeFactor start
ReInput:					;do several times of input
	call ReadInt			;input a number
	mov number, eax			;save number in variable "number"
	mov ebx, 2				;set ebx is divisor, and start from 2
	mov power, 0			;make power counter start from 0, avoid when changing other number will count wrong
	cmp number, 1
	je DoLine				;if number == last quotient == 1, do from Doline label
	cmp number, 0
	je DoLine				;if number == 0, do from Doline label
	jl Finish				;if number < 0, do from Finish label

WhileCal:					;repeat to do calculation and factorize a number
	mov edx, 0				;always set edx 0, avoid being overflow
	div ebx					;eax div from ebx, and quotient save in eax
	cmp edx, 0
	jne DoNxt				;if edx != 0, do DoNxt label
	mov number, eax			;quotient save in number

DoAgn:						;if a prime factor can divide number several times, do again
	inc power				;power counter increase
	cmp number, 1
	je DoNxt				;if number == last quotient == 1, do from Donxt label
	jmp WhileCal			;jump back WhileCal and calculate again, until it can't be divided by the same prime factor

DoNxt:						;check and print prime factor, power counter of prime factor and symbol
	cmp power, 0
	je NextPrime			;if power counter == 0, do from NextPrime label
	mov eax, ebx
	call WriteDec			;move divisor to eax and print it
	cmp power, 2
	jge DoPow				;if power counter >= 2, do from DoPow label
	cmp number, 1
	je OnlyNum				;if number == last quotient == 1, do from OnlyNum label

DoPow:						;if condition is correct, print data about power counter
	cmp power, 1
	je OnlyNum				;if power counter == 1, do from OnlyNum
	mov edx, OFFSET pow_str
	call WriteString		;move "^" to edx and print it

	mov eax, power
	call WriteDec			;move power counter to eax and print it
	
OnlyNum:					;if power counter of a prime number is 1 or it is the last, do from this label
	cmp number, 1
	je DoLine				;if number == last quottient == 1, do from DoLine label

	mov edx, OFFSET star_str
	call WriteString		;move " * " to edx and print it
NextPrime:					;if a number have other prime factor, do from this label
	mov eax, number			;the previous quotient save back eax
	mov power, 0			;power counter set to 0, restart count the next power counter of prime factor
	inc ebx					;set next divisor
	jmp WhileCal			;jump back WhileCal, calculate, and do all again

DoLine:						;when a number == 1 or 0 or number finish factorizing, do from this label
	call Crlf
	call ReInput			;input next number
Finish:						;if number < 0, return and end program
	ret

PrimeFactor ENDP			;PrimeFactor end
END main