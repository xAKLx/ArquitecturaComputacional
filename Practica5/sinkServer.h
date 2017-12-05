#ifndef SINK_SERVER_H
#define SINK_SERVER_H

void startMenu(EventBuffer * eventBuffer);
void viewEvents(EventBuffer * eventBuffer);
void viewEventsSignalHandler(int sig);
void viewEventsQuantity();
void removeEventsFromQueue();

void handleClientsConnection(int sock, EventBuffer * eventBuffer);
void handleClient(int client_sock, EventBuffer * eventBuffer);

#endif
