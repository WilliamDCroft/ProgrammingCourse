#include <stdio.h>
#include <stdlib.h>

int main() {
    fputs("Welcome to the menu.\nPress 1 for the current weather.\nPress 2 for appointment"
            "reminders.\nPress 3 for a positive message.\n$> ", stdout);
    char szUserChoice[256];
    fgets(szUserChoice, 256, stdin);
    int userChoice = atoi(szUserChoice);
    if (userChoice == 1) {
        fputs("The weather is currenly tornado levels of scary!\n", stdout);
    }
    if (userChoice == 2) {
        fputs("You have a doctors apppointment on the 17th.\n", stdout);
    }
    if (userChoice == 3) {
        fputs("You are a good person. Have a pleasent day.\n", stdout);
    }
    return 0;
}