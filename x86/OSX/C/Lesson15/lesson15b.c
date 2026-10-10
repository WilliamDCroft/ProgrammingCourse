#include <stdio.h>

int main() {
   char buffer[3]; // array (but it's really just another glorified pointer)
   fputs("Type a character: ", stdout);
   fgets(buffer, 3, stdin);
   buffer[0]++;
   fputs(buffer, stdout);
   return 0;
}

// x = y + z
// x = y - z
// x = y * z
// x = y / z

// x = x + y
// x += y

// x = x - y
// x -= y

// *=
// /=