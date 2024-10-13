
section	.text
global ft_strlen

ft_strlen:
    xor rcx, rcx            ; int i = 0;

validation:
    test rdi, rdi
    jz exit                 ; if (!s) return (NULL);

loop:
    cmp BYTE[rdi + rcx], 0
    jz  exit                ; if (!s[i]) break;
    inc rcx                 ; ++i
    jmp loop

exit:
    mov rax, rcx            ; int ret = i;
    ret
