%define SYS_EXIT  1
%define SYS_READ  3
%define SYS_WRITE 4

%define STDIN  0
%define STDOUT 1

global _start

segment .data
    guessMessage db "Guess a number from 1 to 6: "
    guessMessageLength equ $ - guessMessage
    youWinMessage db "You win!", 10
    youWinMessageLength equ $ - youWinMessage
    tooLowMessage db "Too low. Try again: "
    tooLowMessageLength equ $ - tooLowMessage
    tooHighMessage db "Too high. Try again: "
    tooHighMessageLength equ $ - tooHighMessage
    loseMessage db "Sorry, you are out of guesses. The number was X.", 10
    loseMessageLength equ $ - loseMessage
   
segment .bss
    randomNumber resb 1
    randomNumberLength equ $ - randomNumber
    userGuess resb 10
    userGuessLength equ $ - userGuess
    guessCount resb 1

segment .code

_start:
    push ebp
    mov ebp, esp
    sub esp, 4
    ; randomNumber byte [ebp - 1]
    ; userGuess    word [ebp - 3]
    ; guessCount   byte [ebp - 4]

    ; To start with, get a random number from 1 to 6 and store it.
    rdrand eax
    jnc _start

    mov ebx, 6
    xor edx, edx
    div ebx

    add dl, '1'; combine adding 48 and 1
    mov byte [ebp - 1], dl

    mov byte [loseMessage+loseMessageLength-3], dl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, guessMessage
    mov edx, guessMessageLength
    int 80h

gameLoop:
    inc byte [ebp - 4]
    mov eax, SYS_READ
    mov ebx, STDIN
    lea ecx, [ebp - 3]
    mov edx, userGuessLength
    int 80h

    mov al, byte [ebp - 3]
    mov bl, byte [ebp - 1]
    cmp al, bl
    jl tooLow
    jg tooHigh

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, youWinMessage
    mov edx, youWinMessageLength
    int 80h

exit:
    mov eax, SYS_EXIT
    mov ebx, 0
    int 80h

tooLow:
    cmp byte [ebp - 4], 3
    je outOfGuesses
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tooLowMessage
    mov edx, tooLowMessageLength
    int 80h
    jmp gameLoop

tooHigh:
    cmp byte [ebp - 4], 3
    je outOfGuesses
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tooHighMessage
    mov edx, tooHighMessageLength
    int 80h
    jmp gameLoop

outOfGuesses:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, loseMessage
    mov edx, loseMessageLength
    int 80h
    jmp exit