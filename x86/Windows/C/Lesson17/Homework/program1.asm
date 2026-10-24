extern __acrt_iob_func: proc
extern fputs          : proc
extern fgets          : proc
extern atoi           : proc

.data
    welcomeMessage     db "Welcome to the menu.", 10
                       db "Press 1 for the current weather.", 10
                       db "Press 2 for appointment reminders", 10
                       db "Press 3 for a positive message.", 10
                       db "$> ", 0
    weatherMessage     db "The weather is currenly tornado levels of scary!", 10, 0
    appointmentMessage db "You have a doctors appointment on the 17th.", 10, 0
    positiveMessage    db "You are a good person. Have a pleasent day.", 10, 0

.code

main proc
    push rbp
    mov rbp, rsp
    sub rsp, 130h
    ; szUserChoice byte ptr [rbp - 256]
    ; userChoice   dword ptr [rbp - 260]

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, welcomeMessage
    call fputs

    mov rcx, 0
    call __acrt_iob_func
    mov r8, rax
    lea rcx, [rbp - 256]; szUserChoice
    mov rdx, 256
    call fgets

    lea rcx, [rbp - 256]; szUserChoice
    call atoi

    mov dword ptr [rbp - 260], eax; userChoice

    mov ebx, 1
    cmp eax, ebx
    jne oneSkip

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, weatherMessage
    call fputs
oneSkip:
    mov eax, dword ptr [rbp - 260]; userChoice
    mov ebx, 2
    cmp eax, ebx
    jne twoSkip

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, appointmentMessage
    call fputs

twoSkip:
    mov eax, dword ptr [rbp - 260]; userChoice
    mov ebx, 3
    cmp eax, ebx
    jne threeSkip

    mov rcx, 1
    call __acrt_iob_func
    mov rdx, rax
    lea rcx, positiveMessage
    call fputs

threeSkip:
    xor eax, eax
    mov rsp, rbp
    pop rbp
    ret 
main endp

end