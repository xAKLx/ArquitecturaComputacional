projectFiles = main.c main.h student.c student.h makefiletemplate

all: projectA projectB

projectA: $(projectFiles)
	mkdir -p A
	cp main.c main.h student.c student.h ./A
	@echo "BINARY = 0" > A/makefile
	cat makefiletemplate >> A/makefile

projectB: $(projectFiles)
	mkdir -p B
	cp main.c main.h student.c student.h ./B
	@echo "BINARY = 1" > B/makefile
	cat makefiletemplate >> B/makefile

clean:
	rm -rf A B
