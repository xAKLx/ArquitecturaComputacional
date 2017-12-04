all: sinkServer sinkClient

sinkServer: sinkServer.c event.c socketUtils.c
	gcc -o sinkServer event.c socketUtils.c sinkServer.c

sinkClient: sinkClient.c socketUtils.c
	gcc -o sinkClient socketUtils.c sinkClient.c

clean:
	rm -f sinkServer sinkClient
