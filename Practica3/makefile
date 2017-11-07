all: cmix amix

cmix: cmix.c func.S
	gcc -o cmix func.S cmix.c

amix: amix.s
	gcc -nostdlib amix.s -o amix

clean:
	rm -f cmix amix
