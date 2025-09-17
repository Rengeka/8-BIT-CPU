section .data

fileName db "../main.bin", 0
msg db "File opened", 10  
len equ $ - msg

section .text

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
; 1   rdi
; 2	rsi
; 3	rdx
; 4	rcx
; 5	r8
; 6	r9
; 7.. stack

%macro SYSCALL 7

    mov rax, %1
    mov rdi, %2
    mov rsi, %3     ;   lea rsi, [rel fileName]
    mov rdx, %4
    mov r10, %5
    mov r8, %6
    mov r9, %7

    syscall

%endmacro

; openat(AT_FDCWD, path, O_RDONLY)
openat:
    SYSCALL 257, rdi, rsi, 0, 0, 0, 0
    ret

%macro OPEN_FILE 2
    mov rdi, %2         ; fdcwd
    lea rsi, [rel %1]   ; path
    call openat
%endmacro

%define open_file(path) OPEN_FILE path, -100
;%define open_file(path, fdcwd) OPEN_FILE path, fdcwd

global _start

_start:

    open_file(fileName)   

    ; вывести "File opened\n" на stdout
    mov rdi, 1         ; stdout
    lea rsi, [rel msg]
    mov rdx, len
    mov rax, 1         ; syscall write
    syscall

    mov rax, 60    
    xor rdi, rdi
    syscall