INCLUDE Irvine32.inc
includelib ucrt.lib
includelib legacy_stdio_definitions.lib

.586
.model flat, stdcall
.stack 4096

printf PROTO C,
	outputType: PTR BYTE,
	outputWord:vararg
scanf PROTO C,
	inputType: PTR BYTE,
	inputWord:vararg

Point2D STRUCT
	X DWORD ?
	Y DWORD ?
Point2D ENDS
	
Triangle STRUCT
	a_side REAL8 ?
	b_side REAL8 ?
	c_side REAL8 ?
	area REAL8 ?
Triangle ENDS

.data
	point1 Point2D <>
	point2 Point2D <>
	point3 Point2D <>
	tempX REAL8 ?
	tempY REAL8 ?
	trifig Triangle <>
	s REAL8 ?
	number REAL8 2.0
	inTypeStr BYTE "%d", 0
	outTypeStr BYTE "%.3f", 0

.code
main PROC
	INVOKE scanf, ADDR inTypeStr, ADDR point1.X
	INVOKE scanf, ADDR inTypeStr, ADDR point1.Y
	INVOKE scanf, ADDR inTypeStr, ADDR point2.X
	INVOKE scanf, ADDR inTypeStr, ADDR point2.Y
	INVOKE scanf, ADDR inTypeStr, ADDR point3.X
	INVOKE scanf, ADDR inTypeStr, ADDR point3.Y
	call distance
	call triangleArea
	call main
	ret
main ENDP

distance PROC
	finit
	fild point1.X
	fisub point2.X
	fstp tempX
	fld tempX
	fmul tempX
	fstp tempX
	fild point1.Y
	fisub point2.Y
	fstp tempY
	fld tempY
	fmul tempY
	fstp tempY
	fld tempX
	fadd tempY
	fstp trifig.a_side
	fld trifig.a_side
	fsqrt
	fstp trifig.a_side

	fild point2.X
	fisub point3.X
	fstp tempX
	fld tempX
	fmul tempX
	fstp tempX
	fild point2.Y
	fisub point3.Y
	fstp tempY
	fld tempY
	fmul tempY
	fstp tempY
	fld tempX
	fadd tempY
	fstp trifig.b_side
	fld trifig.b_side
	fsqrt
	fstp trifig.b_side

	fild point1.X
	fisub point3.X
	fstp tempX
	fld tempX
	fmul tempX
	fstp tempX
	fild point1.Y
	fisub point3.Y
	fstp tempY
	fld tempY
	fmul tempY
	fstp tempY
	fld tempX
	fadd tempY
	fstp trifig.c_side
	fld trifig.c_side
	fsqrt
	fstp trifig.c_side
	ret
distance ENDP

triangleArea PROC
	finit
	fld s
	fldz
	fmul 
	fadd trifig.a_side
	fadd trifig.b_side
	fadd trifig.c_side
	fdiv number
	fstp s
	fld s
	fsub trifig.a_side
	fstp trifig.a_side
	fld s
	fsub trifig.b_side
	fstp trifig.b_side
	fld s
	fsub trifig.c_side
	fstp trifig.c_side
	fld s
	fmul trifig.a_side
	fmul trifig.b_side
	fmul trifig.c_side
	fstp trifig.area
	fld trifig.area
	fsqrt
	fstp trifig.area
	fld trifig.area
	INVOKE printf, ADDR outTypeStr, trifig.area
	call Crlf
	ret
triangleArea ENDP
END main