# ASM-Guessing-Game
A simple number guessing game written in 64-bit NASM for Windows.

## Compilation

Compilation requires NASM and GCC to be installed.
```ps1
nasm -f win64 num64.asm
gcc -o num64 num64.obj -s
```
