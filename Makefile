qemu = qemu-system-x86_64
all:
	nasm boot.asm -o boot.img
clean:
	rm boot.img
run:
	$(qemu) boot.img
