#include <stdlib.h>
#include <stdio.h>
#include <sys/socket.h>
#include <string.h>
#include<unistd.h>
#include<arpa/inet.h>
#include "socketUtils.h"
#include "event.h"

int main(int argc, int argv)
{
    int socket_desc , client_sock , c , read_size;
    struct sockaddr_in client;
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

    while(1) {
        //Accept and incoming connection
        puts("Waiting for incoming connections...");
        c = sizeof(struct sockaddr_in);

        //accept connection from an incoming client
        client_sock = accept(socket_desc, (struct sockaddr *)&client, (socklen_t*)&c);
        if (client_sock < 0)
        {
            perror("accept failed");
            return 1;
        }
        puts("Connection accepted");

        int pid = fork();

        if(pid != 0)
            continue;

        Event event;
        char *id;
        //Receive a message from client
        while( (read_size = recv(client_sock , client_message , 2000 , 0)) > 0 )
        {
            //Send the message back to client
            write(client_sock , "OK" , strlen(client_message));
            //puts(client_message);

            initEvent(&event, client_message);
            if(event.type == 'I') {
              id = event.id;
            }
            else
            {
              event.id = id;
            }
            printEvent(event);
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
        break;
    }

    return 0;
}
