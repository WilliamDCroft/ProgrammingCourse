#include <stdio.h>
#include <stdlib.h>

int main() {
    for (;;) {
        fputs("Welcome to the menu.\nPress 1 for the current weather.\nPress 2 for appointment"
                "reminders.\nPress 3 for a positive message.\nPress 4 to hear a fact about beetles.\n"
                "Type anything else to exit.\n$> ", stdout);

        char szUserChoice[256];
        fgets(szUserChoice, 256, stdin);

        int userChoice = atoi(szUserChoice);
        switch (userChoice) {
            case 1:{
                fputs("The weather is tornado levels of scary!\n\n", stdout);   
            } break;
            case 2: {
                fputs("You have a doctors appointment on the 17th.\n\n", stdout);
            } break;
            case 3: {
                fputs("You are a good person. Have a pleasent day.\n\n", stdout);
            } break;
            case 4: {
                fputs("And how many times would you like to hear this fact?\n$> ", stdout);
                fgets(szUserChoice, 256, stdin);
                userChoice = atoi(szUserChoice);
                for (int i = 0; i < userChoice; ++i) {
                    fputs("Beatles have wings!!!\n", stdout);
                }
                fputs("\n", stdout);
            } break;
            default: {
                return 0;
            }
        }
    }
}
