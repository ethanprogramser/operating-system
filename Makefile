all:
	nasm a.asm
	qemu-system-i386 -fda a

