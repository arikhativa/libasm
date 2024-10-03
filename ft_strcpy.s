
section	.text
global ft_strcpy

ft_strcpy:
    mov rax, rdi

validation:
    test rdi, rdi
    jz exit_null
    test rsi, rsi
    jz exit_null

loop:
    cmp BYTE[rsi], 0
    jz  exit_loop
    mov rdx, [rsi]
    mov [rdi], rdx
    inc rsi
    inc rdi
    jmp loop

exit_loop:
    mov BYTE[rdi], 0

exit:
    ret

exit_null:
    mov rax, 0
    ret
