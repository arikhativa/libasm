
global ft_strlen

ft_strlen:
    xor rcx, rcx ; clear counter

loop:
    cmp BYTE[rdi + rcx], 0
    jz  exit
    inc rcx
    jmp loop

exit:
    mov rax, rcx
    ret