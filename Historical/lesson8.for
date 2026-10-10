       PROGRAM GuessingGame
           INTEGER :: target_num, guess_num
           REAL :: rand_val
   
           ! Generate a random number between 1 and 6
           CALL RANDOM_NUMBER(rand_val)
           target_num = INT(rand_val * 6.0) + 1
   
           PRINT *, "Guess a number between 1 and 6: "
   
           DO
               READ *, guess_num
   
               IF (guess_num < target_num) THEN
                   PRINT *, "Too low. Try again: "
               ELSE IF (guess_num > target_num) THEN
                   PRINT *, "Too high. Try again: "
               ELSE
                   PRINT *, "You got it!"
                   EXIT
               END IF
           END DO
   
       END PROGRAM GuessingGame