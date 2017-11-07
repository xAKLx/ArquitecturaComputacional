
        .global _start

        .text
_start:

        mov $55, %rdi
        mov $0, %rsi
        callq itoa

				mov $message, %rdi
				callq puts

				mov $0, %rax
				mov $0, %rdi
				mov %rsp, %rsi
				mov $1, %rdx
				syscall

				sub $48, (%rsp)
				cmp $1, (%rsp)
				jne .OPT2
        callq catchReturn
				callq fibonacciMenu
        jmp .OPT2

				mov     $1, %rax                # system call 1 is write
        mov     $1, %rdi                # file handle 1 is stdout
        mov     $message, %rsi          # address of string to output
        mov     $27, %rdx               # number of bytes
        syscall

.OPT2:
        # exit(0)
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall                         # invoke operating system to exit

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

fibonacciMenu:
	sub $4, %rsp
	movq $0, (%rsp)

  mov $fibonacciMenuStr, %rdi
  callq puts

	mov $0, %rax
	mov $0, %rdi
	mov %rsp, %rsi
	mov $3, %rdx
	syscall

  mov $fibonacciNumbersHeader, %rdi
  callq puts

	mov %rsp, %rdi
	callq getNumber
  mov %rax, %rdi

  mov $0, %rsi
.LC9:
  cmp %rdi, %rsi
  ja .LC8

  sub $16, %rsp
  mov %rdi, (%rsp)
  mov %rsi, %rdi
  mov %rsi, 8(%rsp)
  callq getFibonacci
  mov %rax, %rdi
  mov $0, %rsi
  callq itoa
  mov %rax, %rdi
  callq puts
  mov (%rsp), %rdi
  mov 8(%rsp), %rsi
  add $1, %rsi
  jmp .LC9

.LC8:
	add $4, %rsp
	retq

getFibonacci:
  sub $16, %rsp
  cmp $2, %rdi

  jb .F02
  mov %rdi, (%rsp)

  sub $1, %rdi
  callq getFibonacci

  mov %rax, 8(%rsp)
  mov (%rsp), %rdi
  sub $2, %rdi
  callq getFibonacci

  add 8(%rsp), %rax
  jmp .F01
.F02:
  mov %rdi, %rax
.F01:
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

message:
        .string  "1. Fibonacci\n2. Upper case"
fibonacciMenuStr:
				.string "Introduzca el número de elementos:"
fibonacciBuffer:
        .string "26863810024485359386146727202142923967616609318986952340123175997617981700247881689338369654483356564191827856161443356312976673642210350324634850410377680367334151172899169723197082763985615764450078474174626"
fibonacciNumbersHeader:
  .string "Los primeros elementos de la serie son:"
nl:
  .string "\n"