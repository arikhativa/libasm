
section	.text
global ft_strcmp

ft_strcmp:
validation:
    test rdi, rdi
    jz exit_null        ; if (!s1) return (NULL);
    test rsi, rsi
    jz exit_null        ; if (!s2) return (NULL);

loop:
    cmp BYTE[rdi], 0
    jz  exit            ; if (!*s1) break;
    mov dl, BYTE[rsi]
    cmp BYTE[rdi], dl   ; if (*s1 != *s2) break;
    jnz  exit
    inc rdi             ; ++s1
    inc rsi             ; ++s2
    jmp loop

exit:
    mov rax, 0          ; int ret = 0
    mov cl, BYTE[rdi]
    mov dl, BYTE[rsi]
    sub  cl, dl 
    movsx rax, cl       ; ret = *s1 - *s2
    ret

exit_null:
    mov rax, 0
    ret
