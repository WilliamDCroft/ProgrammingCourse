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
    ; To start with, get a random number from 1 to 6 and store it.
    rdrand eax
    jnc _start

    mov ebx, 6
    xor edx, edx
    div ebx

    add dl, '1'; combine adding 48 and 1
    mov byte [randomNumber], dl

    mov byte [loseMessage+loseMessageLength-3], dl

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, guessMessage
    mov edx, guessMessageLength
    int 80h

gameLoop:
    inc byte [guessCount]
    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, userGuess
    mov edx, userGuessLength
    int 80h

    mov al, byte [userGuess]
    mov bl, byte [randomNumber]
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
    cmp byte [guessCount], 3
    je outOfGuesses
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, tooLowMessage
    mov edx, tooLowMessageLength
    int 80h
    jmp gameLoop

tooHigh:
    cmp byte [guessCount], 3
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