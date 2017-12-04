#ifndef SINK_CLIENT_H
#define SINK_CLIENT_H

int initSession(char *id, int socket, char *ip);

void messageSenderPrompt(int sock);

void keepAlive(int sock);

void closeConnection(int sock);

#endif
