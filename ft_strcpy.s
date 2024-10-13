
section	.text
global ft_strcpy

ft_strcpy:
    mov rax, rdi

validation:
    test rdi, rdi
    jz exit_null        ; if (!dest) return (NULL);
    test rsi, rsi
    jz exit_null        ; if (!src) return (NULL);

loop:
    cmp BYTE[rsi], 0
    jz  exit            ; if (!*src) break;
    mov rdx, [rsi]
    mov [rdi], rdx      ; *dest = *src
    inc rsi             ; ++src
    inc rdi             ; ++dest
    jmp loop

exit:
    mov BYTE[rdi], 0    ; *dest = 0
    ret

exit_null:
    mov rax, 0
    ret
