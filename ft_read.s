global ft_read

%define SYS_READ 0
ft_read:
    mov rax, SYS_READ
    syscall
    ret
