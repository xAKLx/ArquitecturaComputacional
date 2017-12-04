#ifndef SOCKET_UTILS
#define SOCKET_UTILS
#define PORT 8889

#include <stdlib.h>
#include <stdio.h>
#include <sys/socket.h>
#include <string.h>
#include<unistd.h>
#include<arpa/inet.h>

void createServerSocket(struct sockaddr_in * server, unsigned long serverAddress);
#endif
