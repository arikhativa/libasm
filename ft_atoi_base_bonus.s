section	.text
global ft_atoi_base
extern ft_strlen

ft_atoi_base:
validation:
    test rdi, rdi
    jz exit_error   ; if (!s) return (NULL)
    test rsi, rsi
    jz exit_error   ; if (!base) return (NULL)

call_ft_strlen:
    push rdi            ; store s
    push rsi            ; store base
    call ft_strlen      ; len = ft_strlen(s)
    cmp rax, 1          
    jl exit_error_clear_stack       ; if (len < 1) exit
    pop rdi             ; get base
    push rdi            ; store base
    call ft_strlen      ; len = ft_strlen(base)
    cmp rax, 1          
    jle exit_error_clear_stack       ; if (len <= 1) exit



check_base_if_unique:
    pop r10             ; r10 = base
    mov r8, r10         ; r8 = base
    xor rcx, rcx        ; i = 0
    xor rdx, rdx        ; j = 0

    .loop:
        cmp BYTE[r8 + rcx], 0
        jz .exit_loop

    .check_if_char_is_valid:
        mov dil, BYTE[r8 + rcx]     ; ch = base[i]
        cmp dil, '+'
        je exit_bad_base
        cmp dil, '-'
        je exit_bad_base
        call is_whitespaces
        test rax, rax
        jnz exit_bad_base           ; if (is_whitespaces) exit
        
        mov rdx, rcx                ; j = i
        add rdx, 1
    
        .inner_loop:
            cmp BYTE[r8 + rdx], 0
            jz .exit_inner_loop

            mov bl, BYTE[r8 + rdx]  ; ch2 = base[j]
            cmp dil, bl
            je exit_bad_base        ; if (ch == ch2) exit

            inc rdx
            jmp .inner_loop
        
        .exit_inner_loop:

        inc rcx
        jmp .loop

    .exit_loop:

skip_whitespaces:
    pop r11             ; r11 = s
    mov r8, r11         ; r8 = s
    xor rcx, rcx        ; i = 0

    .loop
        mov dil, BYTE[r8 + rcx]
        call is_whitespaces
        test rax, rax
        jz exit_loop                ; if (!is_whitespaces(s[i])) break
        inc rcx
        jmp .loop

    .exit_loop:

    // Handle optional '+' and '-' signs TODO



        pop rdi
        mov rax, 66
        ret

exit:
    pop rdi
    mov rax, -2
    ret
    

exit_error_clear_stack:
    pop rdi
    pop rdi
    mov rax, -1
    ret

exit_error:
    mov rax, 0
    ret


exit_bad_base:
    pop rdi
    mov rax, -3
    ret

aaa:
    pop rdi
    mov rax, -33
    ret
bbb:
    pop rdi
    mov rax, -23
    ret


is_whitespaces:
    cmp dil, ' '
    je set_is_whitespaces
    cmp dil, '\n'
    je set_is_whitespaces
    cmp dil, '\t'
    je set_is_whitespaces
    cmp dil, '\r'
    je set_is_whitespaces
    cmp dil, '\v'
    je set_is_whitespaces
    cmp dil, '\f'
    je set_is_whitespaces

    xor rax, rax 
    ret

set_is_whitespaces:
    mov rax, 1
    ret
