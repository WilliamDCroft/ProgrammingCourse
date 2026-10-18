#include <stdio.h>

main() {
    double theNumberPi = 3.1415926;
    printf("%.7f\n", theNumberPi);
    int myWholeNumber;
    int myDenomniator = 15;
    myWholeNumber = 52 / myDenomniator;
    int myRemainder = 52 % myDenomniator;
    printf("%i %i/%i\n", myWholeNumber, myRemainder, myDenomniator);
    float myFloat = 52.0f / 15.0f;
    printf("%f\n", myFloat);
    return 0;
}