#include <stdio.h>

int main() {
    double doublePrecisionPi = 3.14159265;
    printf("%.8f\n", doublePrecisionPi);
    int myWholeNumber;
    int myDenominator = 15;
    myWholeNumber = 52 / myDenominator;
    int myRemainder = 52 % myDenominator;
    printf("%i %i/%i\n", myWholeNumber, myRemainder, myDenominator);
    float myFloat = 52.0f / 15.0f;
    printf("%f\n", myFloat);
    return 0;
}
