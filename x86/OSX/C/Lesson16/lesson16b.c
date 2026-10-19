#include <stdio.h>

int main() {
   double doublePrecisionPi = 3.1415926;
   printf("%.8f\n", doublePrecisionPi);
   int myDenominator = 15;
   int myWholeNumber = 52 / myDenominator;
   int myRemainder = 52 % myDenominator;
   printf("%i %i/%i\n", myWholeNumber, myRemainder, myDenominator);
   float myFloat = 52.0f / 15.0f;
   printf("%f\n", myFloat);
}