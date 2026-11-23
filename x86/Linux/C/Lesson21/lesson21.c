#include <stdio.h>
#include <stdint.h>

int main() {
    int x = 3;
    int y = 4;
    printf("%p\n", &x);
    int *pointer = &x;
    printf("%p\n", pointer);
    int** myOtherPointer =  &pointer;
    printf("%p\n", myOtherPointer);
    printf("x is %d\n", x);
    *pointer = 5;
    printf("x is %d\n", x);
    printf("y is %d\n", y);
    pointer++;
    printf("%lu\n", sizeof (int32_t));
    *pointer = 7;
    printf("y is %d\n", y);
    return 0;
}
