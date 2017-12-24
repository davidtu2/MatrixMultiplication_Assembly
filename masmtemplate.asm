TITLE Homework 7              	(David Tu_Homework 7_Visual Studio 2013_ver2.asm)
; Matrix multiplication of a 3x3 and a 3x3. Stores the results in matrixC
; David Tu
; Creation Date: 4/21/2016
; Revisions: Version 2
; Date: 4/21/2016	
; Modified By: 4/22/2016

INCLUDE Irvine32.inc
rowCount = 3					;modify to update, if needed
colCount = 3

.data
matrixA DWORD 1, 3, 5
		DWORD 1, 1, -2
		DWORD 4, -3, 2
matrixB DWORD 3, 5, 7
		DWORD 4, -3, 9
		DWORD -1, 2, -6
matrixC DWORD 3 DUP(0)
		DWORD 3 DUP(0)
		DWORD 3 DUP(0)
rowSize = SIZEOF matrixA		;The number of bytes in each row

.code
main PROC
	mov esi, OFFSET matrixA
	mov edi, OFFSET matrixB
	mov ebx, OFFSET matrixC
	mov ecx, colCount
	mov eax, 0
L3:
	push ebx					;save the col that's worked on
	push esi					;save esi to the first element
	push edi					;save the col that's worked on
	push ecx
	mov ecx, rowCount			;within this col, work down the rows
L2:
	push ebx					;again, save the col that's worked on
	push edi
	push ecx					;save the row that's worked on
	mov ecx, colCount			;within this row, work across the columns
L1:								;calculates the vector col
	mov eax, [esi]
	imul DWORD PTR [edi]		;product = EDX:EAX
	add [ebx], eax
	add esi, TYPE matrixA		;inc esi
	add edi, rowSize			;go down the col
loop L1
	pop ecx						;restore the row that was worked on
	pop edi						;restore the col that was worked on
	pop ebx
	add ebx, rowSize			;go down the col
loop L2
	pop ecx						;restore the col that was worked on
	pop edi
	pop esi						;restores esi to the first element
	pop ebx						;restores the col that was worked on
	add ebx, TYPE matrixB		;go to the next col to work on
	add edi, TYPE matrixB
loop L3
	mov esi, OFFSET matrixC
	mov ecx, (LENGTHOF matrixC)*rowCount
	mov ebx, TYPE matrixC
	call DumpMem
	call DumpRegs
	call WaitMsg
	exit
main ENDP
END main
