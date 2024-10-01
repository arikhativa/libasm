global ft_write

%define SYS_WRITE 1
ft_write:
    mov rax, SYS_WRITE
    syscall
    ret
