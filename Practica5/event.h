#ifndef EVENTS_H
#define EVENTS_H

typedef struct event {
  char * id;
  char type;
  short length;
  char * message;
  unsigned int keepAliveNumber;
} Event;

void initEvent(Event * event, char * eventData);
void printEvent(Event event);

#endif
