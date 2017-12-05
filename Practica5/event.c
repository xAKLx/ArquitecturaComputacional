#include "event.h"
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <semaphore.h>
#include <sysexits.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <unistd.h>

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
        event->keepAliveNumber = *(unsigned int *)(eventData + 1);
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
        printf(" [Mensaje] - %s", event.message);
      break;

      case 'K':
        printf(" [Keep Alive] - %u\n", event.keepAliveNumber);
      break;

      case 'C':
        puts(" [Cerrado]");
      break;
    }
}

void destroyEvent(Event * event)
{
    free(event->id);

    if(event->type == 'M')
      free(event->message);

    free(event);
}

void initEventNode(EventNode * node, Event * event)
{
    node->next = NULL;
    node->event = event;
}

void destroyEventNode(EventNode * node)
{
    free(node);
}


void initEventBuffer(EventBuffer *eventBuffer)
{
    eventBuffer->first = NULL;
    eventBuffer->last = NULL;
    sem_init(&eventBuffer->mutex, 0, 1);
    sem_init(&eventBuffer->items, 0, 0);
}

void destroyEventBuffer(EventBuffer * eventBuffer)
{
    EventNode * node;
    while(eventBuffer->first != NULL)
    {
        node = eventBuffer->first;
        eventBuffer->first = node->next;
        destroyEventNode(node);
    }

    free(eventBuffer);
}

void insertEvent(EventBuffer * eventBuffer, Event * event)
{
    EventNode * node;
    sem_wait(&eventBuffer->mutex);
    node = (EventNode *) calloc(1, sizeof(EventNode));
    initEventNode(node, event);

    if(eventBuffer->last != NULL) {
      eventBuffer->last->next = node;
      eventBuffer->last = node;
    }
    else
    {
      eventBuffer->last = node;
      eventBuffer->first = node;
    }

    sem_post(&eventBuffer->items);
    sem_post(&eventBuffer->mutex);

    int val;
    sem_getvalue(&eventBuffer->items, &val);
}

Event * pokeEvent(EventBuffer *eventBuffer)
{
    Event * event;
    EventNode * node;
    sem_wait(&eventBuffer->items);
    sem_wait(&eventBuffer->mutex);

    node = eventBuffer->first;
    event = node->event;
    node->event = NULL;

    eventBuffer->first = node->next;
    if(node == eventBuffer->last) {
      eventBuffer->last = NULL;
    }

    destroyEventNode(node);
    sem_post(&eventBuffer->mutex);
    
    return event;
}
