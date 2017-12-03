/*
    C ECHO client example using sockets
*/
#include<stdlib.h>
#include<stdio.h> //printf
#include<string.h>    //strlen
#include<sys/socket.h>    //socket
#include<arpa/inet.h> //inet_addr
 
int main(int argc , char *argv[])
{
    int sock;
    struct sockaddr_in server;
    char message[1000] , server_reply[2000];
     
    //Create socket
    sock = socket(AF_INET , SOCK_STREAM , 0);
    if (sock == -1)
    {
        printf("Could not create socket");
    }
    puts("Socket created");
     
    server.sin_addr.s_addr = inet_addr("127.0.0.1");
    server.sin_family = AF_INET;
    server.sin_port = htons( 8889 );
 
    //Connect to remote server
    if (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        perror("connect failed. Error");
        return 1;
    }
     
    puts("Connected\n");
    
    char *id = "ident";
    
    printf("%d", initSession(id, sock));
     
    //keep communicating with server
    while(1)
    {
        printf("Enter message : ");
        scanf("%s" , message);
         
        //Send some data
        if( send(sock , message , strlen(message) , 0) < 0)
        {
            puts("Send failed");
            return 1;
        }
         
        //Receive a reply from the server
        if( recv(sock , server_reply , 2000 , 0) < 0)
        {
            puts("recv failed");
            break;
        }
         
        puts("Server reply :");
        puts(server_reply);
    }
     
    close(sock);
    return 0;
}

int initSession(char *id, int socket)
{
    short length = (short)strlen(id);
    char *message1 = calloc(3 + length, sizeof(char));
    message1[0] = 'I';
    char server_reply[2];
    
    memcpy(message1+1, &length, sizeof(short));
    strcpy(message1+2, id);
    
    if( send(socket , message1 , 3 + length , 0) < 0)
    {
        return 0;
    }
     
    //Receive a reply from the server
    if( recv(socket , server_reply , 2000 , 0) < 0)
    {
        return 0;
    }
     
    return server_reply[0] == 'O' && server_reply[1] == 'K';
}