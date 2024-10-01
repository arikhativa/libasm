
; char	*ft_strdup(const char *s)
; {
; 	int		size;
; 	char	*ret;

; 	if (!s)
; 		return (NULL);
; 	size = ft_strlen(s);
; 	ret = (char *)malloc(sizeof(char) * (size + 1));
; 	if (!ret)
; 		return (NULL);
; 	ft_strlcpy(ret, s, size + 1);
; 	return (ret);
; }

global ft_strdup
extern ft_strlen
extern ft_strcpy
extern	malloc

ft_strdup:

validation:
    test rdi, rdi
    jz exit_null

call_ft_strlen:
    push rdi ; store the src
    call ft_strlen
call_malloc:
    add rax, 1
    push rax ; store the len
    mov rdi, rax
    call malloc
    test rax, rax ; check if null
    jz exit_error ; if null then exit
    
    pop rcx ; get the len
    mov BYTE[rax + rcx - 1], 0

copy_to_memory:
    pop rsi ; get the src
    mov rdi, rax
    push rax
    call ft_strcpy
    pop rax

exit:
    ret

exit_error:
    mov rax, 0
    leave
    ret
    
exit_null:
    mov rax, 0
    ret

