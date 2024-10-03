
section .text
global  ft_strdup
extern  ft_strlen
extern  ft_strcpy
extern  malloc

extern  __errno_location
%define EINVAL 22 ;TODO

ft_strdup:

validation:
    test rdi, rdi
    jz exit_null        ; if (!s) return (NULL);

call_ft_strlen:
    push rdi            ; store the src param
    call ft_strlen
    
call_malloc:
    add rax, 1          ; add 1 to len
    mov rdi, rax        ; set malloc param to len
    push rax            ; store the len

    call malloc

    test rax, rax
    jz exit_error       ; if (!ret) return (NULL);
    
    pop rcx             ; get the len
    mov BYTE[rax + rcx - 1], 0

copy_to_memory:
    pop rsi             ; get the src param
    mov rdi, rax        ; set ft_strcpy param to new mem address
    push rax            ; store the new mem address
    call ft_strcpy
    pop rax             ; get new mem addrees

exit:
    ret

exit_error:
    mov rax, 0
    ret
    
exit_null:
; TODO not sure if i should set errno here
    call __errno_location
    mov BYTE[rax], EINVAL
    mov rax, 0
    ret

