       IDENTIFICATION DIVISION.
       PROGRAM-ID. GuessingGame.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-TARGET-NUM     PIC 9 VALUE 0.
       01 WS-GUESS-NUM      PIC 9 VALUE 0.
       01 WS-RANDOM-RAW     PIC V9999999.
       01 WS-SEED           PIC 9(8) VALUE 12345.
       
       PROCEDURE DIVISION.
           *> Seed and generate a random number from 1 to 6
           COMPUTE WS-RANDOM-RAW = FUNCTION RANDOM(WS-SEED)
           COMPUTE WS-TARGET-NUM = FUNCTION INTEGER(WS-RANDOM-RAW * 6) + 1
       
           DISPLAY "Guess a number between 1 and 6: "
       
           PERFORM UNTIL WS-GUESS-NUM = WS-TARGET-NUM
               ACCEPT WS-GUESS-NUM
       
               IF WS-GUESS-NUM < WS-TARGET-NUM
                   DISPLAY "Too low. Try again: "
               ELSE IF WS-GUESS-NUM > WS-TARGET-NUM
                   DISPLAY "Too high. Try again: "
               ELSE
                   DISPLAY "You got it!"
               END IF
           END-PERFORM
       
           STOP RUN.