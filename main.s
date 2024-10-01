section .data
	buff: db '0', 0  

	msg: db "ab", 0
	len: equ $ - msg - 1
	SYS_EXIT: equ 60
	SYS_WRITE: equ 1
	STDOUT: equ 1

section .text
	global _start
_start:
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, msg
	mov rdx, len
	syscall

print_ret:
	add rax, '0'
	mov [buff], rax

	mov rsi, buff
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rdx, 1
	syscall


_exit:
	mov rax, SYS_EXIT
	mov rdi, 0
	syscall

