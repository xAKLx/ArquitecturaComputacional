#include "socketUtils.h"

void createServerSocket(struct sockaddr_in * server, unsigned long serverAddress)
{

  server->sin_addr.s_addr = serverAddress;
  server->sin_family = AF_INET;
  server->sin_port = htons( PORT );
}
