all: sinkServer sinkClient

sinkServer: sinkServer.c event.c socketUtils.c
	gcc event.c socketUtils.c sinkServer.c -lpthread -lrt -lm -o sinkServer 

sinkClient: sinkClient.c socketUtils.c
	gcc -o sinkClient socketUtils.c sinkClient.c

clean:
	rm -f sinkServer sinkClient
