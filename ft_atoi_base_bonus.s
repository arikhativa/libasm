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
    jle exit_error_clear_stack      ; if (len <= 1) exit
    mov r12, rax                    ; r12 = base.len


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

    .loop:
        mov dil, BYTE[r8]
        call is_whitespaces
        test rax, rax
        jz .exit_loop                ; if (!is_whitespaces(s[i])) break
        inc r8
        jmp .loop

    .exit_loop:
check_if_sign:
    mov r9, 1                   ; sign = r9 = 1
    mov dil, BYTE[r8]
    cmp dil, '+'
    je .handle_sign_done
    cmp dil, '-'
    je .handle_sign_minus
    jmp .skip_sign

    .handle_sign_minus:
        mov r9, -1                  ; sign = -1

    .handle_sign_done:
        inc r8

    .skip_sign:

loop_str:
    mov rdx, 0                  ; rdx = result
    .loop:
        mov dil, BYTE[r8]       ; ch = *s
        call get_value          ; rax = get_value(ch, base)
        cmp rax, -1
        je .exit_loop
        mov rcx, rax            ; rcx = value
        mov rax, r12            ; rax = base_len
        mul rdx                 ; rax = result * base_len
        add rax, rcx            ; result + value
        mov rdx, rax            ; rdx = result
        inc r8
        jmp .loop

    .exit_loop:

exit:
    mov rax, rdx
    mul r9
    ret

exit_error_clear_stack:
    pop rdi
    pop rdi
    mov rax, -1
    ret

exit_error:
    mov rax, -22
    ret


exit_bad_base:
    pop rdi
    mov rax, -3
    ret


; Functions

get_value:
    mov rsi, 0                      ; i = 0
    .loop:
        cmp BYTE[r10 + rsi], 0      ; if (!base[i]) break
        je .exit_loop
        mov al, BYTE[r10 + rsi]     ; tmp = base[i] 
        cmp al, dil                 ; if (tmp == ch) -> exit_loop
        je .exit_success
        inc rsi                     ; ++i
        jmp .loop

    .exit_loop:
        mov rax, -1                 ; return -1
        ret

    .exit_success:
        mov rax, rsi                ; return i
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

is_number:
    cmp dil, '0'
    je .set_is_digit
    cmp dil, '1'
    je .set_is_digit
    cmp dil, '2'
    je .set_is_digit
    cmp dil, '3'
    je .set_is_digit
    cmp dil, '4'
    je .set_is_digit
    cmp dil, '5'
    je .set_is_digit
    cmp dil, '6'
    je .set_is_digit
    cmp dil, '7'
    je .set_is_digit
    cmp dil, '8'
    je .set_is_digit
    cmp dil, '9'
    je .set_is_digit

    mov rax, 0
    ret

    .set_is_digit:
        mov rax, 1
        ret