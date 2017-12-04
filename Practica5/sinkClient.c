#include<stdlib.h>
#include<stdio.h> //printf
#include<string.h>    //strlen
#include<sys/socket.h>    //socket
#include<arpa/inet.h> //inet_addr
#include"socketUtils.h"
#include<signal.h>
#include"sinkClient.h"

int sock;

void onClose(int sig){ // can be called asynchronously
  closeConnection(sock);
  signal(SIGINT, SIG_DFL);
  kill(getpid(), SIGINT);
}

int main(int argc , char *argv[])
{

    sock = socket(AF_INET , SOCK_STREAM , 0);
    if (sock == -1)
    {
        printf("Could not create socket");
        return 1;
    }

    if( 0 == initSession(argv[2], sock, argv[1]))
    {
        printf("Could not connect to server");
        return 1;
    }
    pid_t  pid = fork();

    if(-1 == pid) {
        printf("Could not create process.\n");
        closeConnection(sock);
        return 1;
    }
    else if(0 == pid) {
      keepAlive(sock);
    }
    else {
      signal(SIGINT, onClose);
      messageSenderPrompt(sock);
    }
    return 0;
}

char * initIdMessage(char method, char * data)
{
    short dataLength = (short)strlen(data);
    short length = dataLength + 4;

    char *message = calloc(length, sizeof(char));
    memset(message, 0, length);

    message[0] = method;
    memcpy(message + 1, &length, sizeof(short));
    strcpy(message + 2, data);

    return message;
}

int initSession(char *id, int socket, char *ip)
{
    struct sockaddr_in server;
    createServerSocket(&server, inet_addr(ip));
    char server_reply[3];

    if (connect(socket , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
      puts("1");
        return 0;
    }

    char *message1 = initIdMessage('I', id);

    if( send(socket , message1 , strlen(message1) , 0) < 0
        || recv(socket , server_reply , 3 , 0) < 0)
    {
      puts("2");
        free(message1);
        return 0;
    }

    free(message1);
    puts(server_reply);
    return server_reply[0] == 'O' && server_reply[1] == 'K';
}

void keepAlive(int sock)
{
    return;
}

void messageSenderPrompt(int sock)
{
    short length;
    char *message;
    char data[1000];
    char reply[3];

    while(1)
    {
        fgets(data, 1000, stdin);
        message = initIdMessage('M', data);

        if( send(sock , message , strlen(message) , 0) < 0 )
        {
            puts("Send failed");
        }

        if( recv(sock , reply , 2 , 0) < 0 || 0 != strcmp("OK", reply) )
        {
            puts("Reply failed");
        }

        memset(reply, 0, 3);
        free(message);
    }
}

void closeConnection(int sock)
{
    if( send(sock , "C" , 1 , 0) < 0 )
    {
        puts("Failed to send close message");
    }

    close(sock);
}
