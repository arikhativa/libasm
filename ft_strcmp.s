
global ft_strcmp

ft_strcmp:
validation:
    test rdi, rdi
    jz exit_null
    test rsi, rsi
    jz exit_null

loop:
    cmp BYTE[rdi], 0
    jz  exit
    mov dl, BYTE[rsi]
    cmp BYTE[rdi], dl
    jnz  exit
    inc rdi
    inc rsi
    jmp loop


exit:
    mov rax, 0
    mov cl, BYTE[rdi]
    mov dl, BYTE[rsi]
    sub  cl, dl 
    movsx rax, cl
    ret

exit_null:
    mov rax, 0
    ret
