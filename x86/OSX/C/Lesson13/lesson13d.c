extern void _syscall(int, int) __asm__("_syscall");
extern void puts(char*) __asm__("puts");

int main() {
   puts("Hello world!");
   _syscall(0x02000001, 0);
   return 0;
}