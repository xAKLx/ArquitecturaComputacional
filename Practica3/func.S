.data
.LC0:
    .string	"%u\n"
.STR1:
    .string "%s\n"
.STR2:
    .string "%x\n"
.STR3:
    .string "%d\n"

.section .text
.globl getOne, switchBytes, printHigher, lowerToUpper, countOnes
.type getOne, @function
.type switchBytes, @function
.type printHigher, @function
.type lowerToUpper, @function
.type countOnes, @function

getOne:
    movl $2, %eax
    ret
switchBytes:
    sub $0x4, %rsp
    movl %edi, (%rsp)
    
    movb (%rsp, %rsi, 1), %bl
    movb (%rsp, %rdx, 1), %cl
    
    movb %cl, (%rsp, %rsi, 1)
    movb %bl, (%rsp, %rdx, 1)
    
    movl $.LC0, %edi
    movl (%rsp), %esi
    
    mov $0x0,%eax
    callq printf@plt
    
    add $0x4, %rsp
    ret
    
printHigher:
    movl -4(%rdi, %rsi, 4), %eax
    jmp .LC1
    
.LC2:
    cmpl -4(%rdi, %rsi, 4), %eax
    ja .LC1
    movl -4(%rdi, %rsi, 4), %eax
    
.LC1:
    sub $0x1, %rsi
    test %rsi, %rsi
    jne .LC2
    
    movl $.LC0, %edi
    movl %eax, %esi
    
    mov $0x0,%eax
    callq printf@plt
    ret
    
lowerToUpper:
    mov %rdi, %rcx
.LC4:
    cmpb $0x0, (%rcx)
    je .LC3
    
    cmpb $0x61, (%rcx)
    jb .LC5
    cmpb $0x7a, (%rcx)
    ja .LC5
    
    sub $0x20, (%rcx)
.LC5:
    add $0x1, %rcx
    jmp .LC4
    

.LC3:
    mov %rdi, %rsi
    mov $.STR1, %rdi
    
    movl $0x0,%eax
    callq printf@plt
    ret

countOnes:
    sub $0x4, %rsp
    movl %edi, (%rsp)
    
    mov $0x0, %rax
    mov $0x0, %rdi
    mov $0x0, %rdx
    
.LC6:
    movb (%rsp,%rdi), %dl
    mov $0x0, %rcx
    
.LC7:
    shr %cl, %dl
    andb $0x1, %dl
    add %rdx, %rax
    
    add $0x1, %rcx
    cmp $0x4, %rcx
    jne .LC7
    
    add $0x1, %rdi
    cmp $0x4, %rdi
    jne .LC6
    
    mov $.STR3, %rdi
    mov %rax, %rsi
    
    movl $0x0,%eax
    callq printf@plt
    
    add $0x4, %rsp
    ret