#include "event.h"
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void initEvent(Event * event, char * eventData)
{
    short length;
    event->type = eventData[0];
    switch (event->type) {
      case 'I':
        length = *((short *)(eventData+1));
        event->id = (char*)calloc(length + 1, sizeof(char*));

        memset(event->id, 0, length + 1);
        strcpy(event->id, eventData + 2);
      break;

      case 'M':
        event->length = *((short *)(eventData+1));
        event->message = (char*) calloc(length + 1, sizeof(char*));

        memset(event->message, 0, length + 1);
        strcpy(event->message, eventData + 2);
      break;

      case 'K':
        event->keepAliveNumber = *((int *)(eventData+1));
      break;

    }
}

void printEvent(Event event)
{
    printf("%s", event.id);
    switch (event.type) {
      case 'I':
        puts(" [Conectado]");
      break;

      case 'M':
        printf(" [Mensaje] - %s\n", event.message);
      break;

      case 'K':
        printf(" [Keep Alive] - %u\n", event.keepAliveNumber);
      break;

      case 'C':
        puts(" [Cerrado]");
      break;
    }
}
