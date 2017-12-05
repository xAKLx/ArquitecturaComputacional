#ifndef EVENTS_H
#define EVENTS_H


#include <semaphore.h>

typedef struct event {
  char * id;
  char type;
  short length;
  char * message;
  unsigned int keepAliveNumber;
} Event;

typedef struct _EventNode{
  Event * event;
  struct _EventNode * next;
} EventNode;

typedef struct {
  EventNode * first;
  EventNode * last;
  sem_t mutex;
  sem_t items;
} EventBuffer;

void initEvent(Event * event, char * eventData);
void printEvent(Event event);
void destroyEvent(Event * event);

void initEventNode(EventNode * node, Event * event);
void destroyEventNode(EventNode * node);

void initEventBuffer(EventBuffer * eventBuffer);
void destroyEventBuffer(EventBuffer * eventBuffer);
void insertEvent(EventBuffer * eventBuffer, Event * event);
Event * pokeEvent(EventBuffer *eventBuffer);

#endif
