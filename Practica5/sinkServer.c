#include <stdlib.h>
#include <stdio.h>
#include <sys/socket.h>
#include <string.h>
#include<unistd.h>
#include<arpa/inet.h>
#include "socketUtils.h"
#include "event.h"
#include "sinkServer.h"
#include<pthread.h>
#include<signal.h>

EventBuffer * eventBuffer;
int socket_desc;
pthread_t tid[2];

void* doSomeThing(void *arg)
{
    unsigned long i = 0;
    pthread_t id = pthread_self();
/*
    if(pthread_equal(id,tid[0]))
    {
        startMenu(eventBuffer);
    }
    else
    {
        handleClientsConnection(socket_desc, eventBuffer);
    }*/

    handleClientsConnection(socket_desc, eventBuffer);

    for(i=0; i<(0xFFFFFFFF);i++);

    return NULL;
}

int main(int argc, int argv)
{
    int client_sock , c , read_size;
    struct sockaddr_in server;
    createServerSocket(&server, INADDR_ANY);
    char client_message[2000];

    //Create socket
    socket_desc = socket(AF_INET , SOCK_STREAM , 0);
    if (socket_desc == -1)
    {
        printf("Could not create socket");
    }
    puts("Socket created");

    //Bind
    if( bind(socket_desc,(struct sockaddr *)&server , sizeof(server)) < 0)
    {
        //print the error message
        perror("bind failed. Error");
        return 1;
    }
    puts("bind done");

    //Listen
    listen(socket_desc , 3);
    eventBuffer = calloc(1, sizeof(EventBuffer));
    initEventBuffer(eventBuffer);

    int err;
    int i = 0;
    /*
    while(i < 2)
    {
        err = pthread_create(&(tid[i]), NULL, &doSomeThing, NULL);
    }*/

    pthread_create(&(tid[i]), NULL, &doSomeThing, NULL);

    startMenu(eventBuffer);
    while(1);

    return 0;
}

void* handleClientThread(void *arg)
{
    handleClient(*(int *)arg, eventBuffer);
}

void handleClientsConnection(int sock, EventBuffer * eventBuffer)
{
    int client_sock;
    int *tmpSock;
    struct sockaddr_in client;
    int c = sizeof(struct sockaddr_in);
    pthread_t threadId;
    int val;


    while(1) {
        client_sock = accept(sock, (struct sockaddr *)&client, (socklen_t*)&c);
        if (client_sock < 0)
        {
            puts("accept failed");
        }

        tmpSock = (int *) calloc(1, sizeof(int));
        *tmpSock = client_sock;

        //handleClient(client_sock, eventBuffer);
        pthread_create(&(threadId), NULL, &handleClientThread, tmpSock);
    }
}

void handleClient(int client_sock, EventBuffer * eventBuffer)
{
    int read_size, endWhile = 0, keepAliveResponse;
    Event *event;
    char *id;
    //Receive a message from client
    char * client_message = (char *) calloc(1000, sizeof(char));
    memset(client_message, 0, 1000);
    while( (read_size = recv(client_sock , client_message , 1000 , 0)) > 0 )
    {
        event = calloc(1, sizeof(Event));
        initEvent(event, client_message);

        switch(event->type) {
            case 'I':
              id = (char *) calloc(strlen(event->id) +1, sizeof(char));
              strcpy(id, event->id);
              write(client_sock , "OK" , 2);
            break;

            case 'M':
              write(client_sock , "OK" , 2);
            break;

            case 'K':
              keepAliveResponse = ~event->keepAliveNumber;
              write(client_sock , (char *) &keepAliveResponse, 4);
            break;
        }

        if(event->type != 'I')
        {
          event->id = id;
        }

        insertEvent(eventBuffer, event);
        if(event->type == 'C')
          break;
        memset(client_message, 0, 1000);
    }

    if(read_size == 0)
    {
        puts("Client disconnected");
        fflush(stdout);
    }
    else if(read_size == -1)
    {
        perror("recv failed");
    }
}

void startMenu(EventBuffer * eventBuffer)
{
    signal(SIGINT, SIG_DFL);
    int option;
    while(1) {

        puts("\nBienvenido a Message Sink\n");
        puts("1. Ver eventos ");
        puts("2. Ver cantidad de eventos en cola ");
        puts("3. Borrar cola de eventos\n");
        puts("Introduzca una opcion: ");
        fscanf(stdin, "%d", &option);

        switch(option)
        {
            case 1:
              viewEvents(eventBuffer);
            break;

            case 2:
              viewEventsQuantity();
            break;

            case 3:
              removeEventsFromQueue();
            break;

        }
    }


    viewEvents(eventBuffer);
}

void viewEvents(EventBuffer * eventBuffer)
{
    signal(SIGINT, viewEventsSignalHandler);
    Event * event;
    while(1)
    {
        event = pokeEvent(eventBuffer);
        printEvent(*event);
    }
}

void viewEventsSignalHandler(int sig)
{
    startMenu(eventBuffer);
}

void viewEventsQuantity()
{
    int i;
    sem_getvalue(&eventBuffer->items, &i);
    fprintf(stdout, "Eventos en cola : %d", i);
}

void removeEventsFromQueue()
{
    int i;
    sem_getvalue(&eventBuffer->items, &i);

    while(eventBuffer->first != NULL) {
      pokeEvent(eventBuffer);
    }
    fprintf(stdout, "Eventos borrados : %d", i);
}
