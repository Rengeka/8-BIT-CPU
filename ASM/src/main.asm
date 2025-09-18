section .data

fileName db "main.bin", 0

msg_file_opened db "File was opened", 10  
len_file_opened equ $ - msg_file_opened

msg_file_read db "File was read", 10  
len_file_read equ $ - msg_file_read

section .bss

buffer resb 100 

section .text

check_error:
    cmp rax, 0
    jge .ok
    neg rax         
    mov rdi, rax     
    jmp _error
.ok:
    ret

%include "src/lib.asm"

global _start

_start:

    open_file(fileName)  
    call check_error

    push rax
    print_string(msg_file_opened, len_file_opened)
    pop rax

    read_file(rax, buffer, 20)
    call check_error

    push rax
    print_string(msg_file_read, len_file_read)
    pop rdx

    print_string(buffer, rdx)

    call _exit

_error:
    mov rax, 60   ; waits error code in rdi      
    syscall

_exit:
    mov rax, 60     
    xor rdi, rdi   
    syscall