
        .global _start

        .text
_start:
.LC14:
				mov $message, %rdi
				callq puts

				mov $0, %rax
				mov $0, %rdi
				mov %rsp, %rsi
				mov $1, %rdx
				syscall
        callq catchReturn

				sub $48, (%rsp)
				cmp $1, (%rsp)
				jne .LC15

				callq fibonacciMenu
        jmp .LC13


				mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message, %rsi          # address of string to output
        mov     $27, %rdx               # number of bytes
        syscall

.LC15:
        callq upperCaseMenu
.LC13:
        jmp .LC14

catchReturn:
  sub $1, %rsp

  mov $0, %rax
  mov $0, %rdi
  mov %rsp, %rsi
  mov $1, %rdx
  syscall

  add $1, %rsp
  retq

strLength:
	mov $0, %rax

.LC2:
	cmpb $0, (%rdi,%rax,1)
	je .LC1
	add $1, %rax
	jmp .LC2

.LC1:
	retq

putc:
  sub $1, %rsp
  movb %dil, (%rsp)

	mov $1, %rdx
	mov $1, %rax
	mov %rsp, %rsi          # address of string to output
	mov $1, %rdi                # file handle 1 is stdout
	syscall

  add $1, %rsp
  retq

puts:
	call strLength
	mov %rax, %rdx
	mov $1, %rax
	mov %rdi, %rsi          # address of string to output
	mov $1, %rdi                # file handle 1 is stdout
	syscall
                           # invoke operating system to do the write
	mov $1, %rdx
	mov $1, %rax
	mov $nl, %rsi          # address of string to output
	mov $1, %rdi                # file handle 1 is stdout
	syscall
	retq

getNumber:
	mov $0, %rcx
	mov $0, %rax

	movb (%rdi), %al
	sub $48, %rax
	mov $100, %r9
	mulq %r9
	add %rax, %rcx

	movb 1(%rdi), %al
	sub $48, %rax
	mov $10, %r9
	mulq %r9
	add %rax, %rcx

	mov 2(%rdi), %al
	sub $48, %rax
	add %rax, %rcx

	mov %rcx, %rax
	retq

removeNewLine:
  callq strLength
  movb $0, -1(%rdi,%rax,1)
  retq

upperCaseMenu:
  sub $512, %rsp
  mov $uppercaseHeader, %rdi
  callq puts

  mov $0, %rax
  mov $0, %rdi
  lea 9(%rsp), %rsi
  mov $500, %rdx
  syscall

  lea 9(%rsp), %rdi
  callq removeNewLine

  mov $2, %rax
  mov $0, %rsi
  mov $0, %rdx
  lea 9(%rsp), %rdi
  syscall
  push %rax

.LC12:
  movb $-1, 8(%rsp)
  movb $0, 9(%rsp)

  movq (%rsp), %rdi
  mov $0, %rax
  lea 8(%rsp), %rsi
  mov $1, %rdx
  syscall
  cmpb $-1, 8(%rsp)
  je .LC10

  cmpb $0x61, 8(%rsp)
  jb .LC11
  cmpb $0x7a, 8(%rsp)
  ja .LC11
  sub $0x20, 8(%rsp)

.LC11:
  movb 8(%rsp), %dil
  callq putc
  jmp .LC12

.LC10:
  pop %rdi
  mov $3, %rax
  syscall
  add $512, %rsp
  retq

fibonacciMenu:
	sub $20, %rsp
	movq $0, (%rsp)

  mov $fibonacciMenuStr, %rdi
  callq puts

	mov $0, %rax
	mov $0, %rdi
	mov %rsp, %rsi
	mov $3, %rdx
	syscall
  callq catchReturn

  mov $fibonacciNumbersHeader, %rdi
  callq puts

	mov %rsp, %rdi
	callq getNumber
  mov %rax, %rdi

  mov $0, %rsi
.LC9:
  cmp %rdi, %rsi
  ja .LC8
  mov %rdi, 4(%rsp)
  mov %rsi, %rdi
  mov %rsi, 12(%rsp)
  callq getFibonacci
  mov %rax, %rdi
  mov $0, %rsi
  callq itoa
  mov %rax, %rdi
  callq puts
  mov 4(%rsp), %rdi
  mov 12(%rsp), %rsi
  add $1, %rsi
  jmp .LC9

.LC8:
	add $20, %rsp
	retq

getFibonacci:
  sub $16, %rsp
  cmp $2, %rdi

  jb .LC17
  mov $oldFibonacciBuffer, %r9
  cmp $0, (%r9, %rdi, 8)
  je .LC16
  movq (%r9, %rdi, 8), %rax
  jmp .LC18

.LC16:
  mov %rdi, (%rsp)

  sub $1, %rdi
  callq getFibonacci

  mov %rax, 8(%rsp)
  mov (%rsp), %rdi
  sub $2, %rdi
  callq getFibonacci

  add 8(%rsp), %rax
  mov (%rsp), %rdi
  mov $oldFibonacciBuffer, %r9
  movq %rax, (%r9, %rdi, 8)
  jmp .LC18
.LC17:
  mov %rdi, %rax
.LC18:
  add $16, %rsp
  retq

itoa:
  sub $10, %rsp
  mov $0, %rax
  cmp $0, %rsi
  je .LC3

  mov %rdi, %r8
  mov %rsi, %rdi
  callq strLength
  sub %rax, %rsp
  push %r8

  lea 9(%rsp), %rdi
  mov %rax, %rdx
  callq memcpy
  pop %rdi

.LC3:
  mov %rax, %r9
  push %r9
  movb $0, 9(%rsp, %rax, 1)

  mov $0, %rdx
  mov %rdi, %rax
  mov $10, %rcx
  div %rcx
  add $48, %dl
  movb %dl, 8(%rsp)
  cmp $0, %rax
  je .LC6

  mov %rax, %rdi
  lea 8(%rsp), %rsi
  callq itoa
  jmp .LC7

.LC6:
  lea 8(%rsp), %rax
.LC7:
  pop %r9
  add $10, %rsp
  add %r9, %rsp
  retq

memcpy:
  mov $0, %rcx

.LC4:
  cmp %rcx, %rdx
  je .LC5
  mov (%rsi, %rcx,1), %r9
  mov %r9, (%rdi, %rcx,1)
  add $1, %rcx
  jmp .LC4

.LC5:
  retq

  .data
message:
        .string  "1. Fibonacci\n2. Upper case"
fibonacciMenuStr:
				.string "Introduzca el número de elementos:"
fibonacciBuffer:
        .string "26863810024485359386146727202142923967616609318986952340123175997617981700247881689338369654483356564191827856161443356312976673642210350324634850410377680367334151172899169723197082763985615764450078474174626"
fibonacciNumbersHeader:
  .string "Los primeros elementos de la serie son:"
uppercaseHeader:
  .string "Introduzca el nombre del archivo:"
nl:
  .string "\n"
file:
  .string "x.txt"
filenameBuffer:
  .string "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
oldFibonacciBuffer:
  .zero 8000
