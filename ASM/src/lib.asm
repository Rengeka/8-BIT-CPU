; section .text

; syscall rules (Move to .md)
; syscall number rax
; 1   rdi 
; 2   rsi
; 3   rdx
; 4   r10
; 5   r8
; 6   r9

; Caller-saved (volatile)
; rax, rdi, rsi, rdx, r10, r8, r9, rcx, r11

; Callee-saved (non-volatile)
; rbx, rbp, r12, r13, r14, r15

; system V AMD64 ABI.
; 1 rdi
; 2	rsi
; 3	rdx
; 4	rcx
; 5	r8
; 6	r9
; 7.. stack

%macro SYSCALL 7
    mov rax, %1
    mov rdi, %2
    mov rsi, %3    
    mov rdx, %4
    mov r10, %5
    mov r8, %6
    mov r9, %7

    syscall
%endmacro 

openat:
    SYSCALL 257, rdi, rsi, 0, 0, 0, 0
    ret

print:
    SYSCALL 1, rdi, rsi, rdx, 0, 0, 0
    ret

read:
    SYSCALL 0, rdi, rsi, 0, 0, 0, 0
    ret

%macro OPEN_FILE 2
    mov rdi, %2         ; fdcwd
    lea rsi, [rel %1]   ; path
    call openat
%endmacro

%macro PRINT_STRING 2
    lea rsi, [rel %1]   ; str address rsi
    mov rdx, %2         ; length
    mov rdi, 1          ; stdout
    call print
%endmacro

%macro READ_FILE 3
    mov rdi, %1       
    lea rsi, [rel %2] 
    mov rdx, %3       
    call read
%endmacro

%define open_file(path) OPEN_FILE path, -100
%define read_file(fd, buffer, count) READ_FILE fd, buffer, count
; %define close_file()
%define print_string(string, length) PRINT_STRING string, length