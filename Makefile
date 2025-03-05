qemu = qemu-system-x86_64
all:
	nasm boot.asm -o boot.img
clean:
	rm *.img *.out
run:
	$(qemu) -m 64 -fda boot.img
