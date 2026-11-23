#include <stdio.h>

int main() {
    char buffer[256];
    *buffer = 0;
    printf("%s\n", buffer);
    buffer[0] = 0;
    printf("%s\n", buffer);
    int x = 3;
    int y = 4;
    int* pointer = &x;
    pointer[1] = 5;
    printf("y is %d\n", y);
    printf("%lu\n", sizeof (buffer));
    int integerList[256];
    printf("%lu\n", sizeof (integerList));
    printf("%lu\n", sizeof (integerList) / sizeof (integerList[0]));
    int* theArray = integerList;
    printf("%lu\n", sizeof (theArray));

    int myIntList[5];
    myIntList[0] = 34;
    myIntList[1] = 6756;
    myIntList[2] = 2;
    myIntList[3] = 234;
    myIntList[4] = 998;

    for (int i = 0; i < sizeof (myIntList) / sizeof (myIntList[0]); ++i) {
        printf("%d\n", myIntList[i]);
    }

    int thingTwo[] = {34, 6756, 2, 234, 998};
    int thingTwoo[5] = {34, 6756, 2};
    return 0;
}
