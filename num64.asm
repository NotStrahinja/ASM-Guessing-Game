extern printf
extern scanf
extern system
extern exit
extern rand
extern srand
extern time
extern Sleep

section .data
    prompt db "Enter your guess: ", 0
    int_fmt db "%lld", 0
    guess dq 0
    num dq 0
    attempt dq 0
    cls db 0x1b, "[H", 0x1b, "[2J", 0
    wmsg db 0x1b, "[32mYou Win!", 0x1b, "[0m", 0
    lmsg db 0x1b, "[31mYou Lose!", 0x1b, "[0m", 0
    gt db "Higher", 0
    lt db "Lower", 0
    lmsg2 db 0x0a, "The number was %lld!", 0

section .bss
    seed resq 1

section .text
global main

main:
    push rbp
    mov rbp, rsp
    sub rsp, 40

    xor rcx, rcx
    call time
    mov [rel seed], rax

    mov rcx, [rel seed]
    call srand

    call rand
    mov r8, rax

    xor rdx, rdx
    mov rax, r8
    mov rcx, 100
    div rcx
    inc rdx
    mov [rel num], rdx

    jmp loop

loop:
    mov rcx, [rel attempt]
    cmp rcx, 11
    je loss

    lea rcx, [rel cls]
    call printf
    
    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel int_fmt]
    lea rdx, [rel guess]
    call scanf

    mov rcx, [rel attempt]
    inc rcx
    mov [rel attempt], rcx

    mov rcx, [rel guess]
    cmp rcx, [rel num]
    je win
    mov rcx, [rel guess]
    cmp rcx, [rel num]
    jg lower
    mov rcx, [rel guess]
    cmp rcx, [rel num]
    jl greater

win:
    lea rcx, [rel cls]
    call printf

    lea rcx, [rel wmsg]
    call printf

    jmp done

loss:
    lea rcx, [rel cls]
    call printf

    lea rcx, [rel lmsg]
    call printf

    lea rcx, [rel lmsg2]
    mov rdx, [rel num]
    call printf

    jmp done

greater:
    lea rcx, [rel gt]
    call printf

    mov rcx, 1000
    call Sleep

    jmp loop

lower:
    lea rcx, [rel lt]
    call printf

    mov rcx, 1000
    call Sleep

    jmp loop

done:
    xor rcx, rcx
    call exit
