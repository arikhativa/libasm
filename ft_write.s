section	.text
global ft_write
extern  __errno_location

%define SYS_WRITE 1

ft_write:
    mov rax, SYS_WRITE
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