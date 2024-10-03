section	.text
global ft_read
extern  __errno_location

%define SYS_READ 0

ft_read:
    mov rax, SYS_READ
    syscall
    test rax, rax
    js on_error
    ret

on_error:
    neg rax
    push rax
    call __errno_location
    pop r8
    mov [rax], r8
    mov rax, -1
    ret