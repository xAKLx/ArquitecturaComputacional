#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "main.h"

int main(int argc, char** argv)
{
  int c;
  int value;
  char hexstring[11];
  char *option = NULL;
  int bOption = 0;

  int i;
  int j;
  int k;
  for(k=0; k< 0; k++)
  {
    for(i=0; i < 8; i++)
    {
      printf(" + ((bytes[%d] & 0b", k);
      for(j=0; j<i; j++)
        printf("0");
      printf("1");
      for(j=i+1; j< 8; j++)
        printf("0");
      printf(")>>%d)", 8-i-1);
    }
  }

  puts("hi");

  while((c = getopt (argc, argv, "o:b:")) != -1)
    switch(c)
    {
      case 'o':
      option = optarg;
      break;

      case 'b':
      bOption = atoi(optarg);
      break;
    }

  if(strcmp(option, "print") == 0)
  {
    sprintf(hexstring, "%s%s%s%s", argv[optind], argv[optind+1] + 2, argv[optind+2] + 2, argv[optind+3] + 2);
    sscanf(hexstring, "%x", &value);

    printf("%u %d\n", value, value);

  }
  else if (strcmp(option, "switch") == 0)
  {
    char *bytes;
    unsigned toWork;
    int byte1 = atoi(argv[optind]);
    int byte2 = atoi(argv[optind+1]);

    sscanf(argv[optind+2], "%u", &toWork);
    bytes = (char*) &toWork;

    char temp = bytes[byte1];
    bytes[byte1] = bytes[byte2];
    bytes[byte2] = temp;
    printf("%u\n", toWork);
  }
  else if(strcmp(option, "count") == 0)
  {
    unsigned toCount;
    char * bytes;
    int count;

    sscanf(argv[optind], "%u", &toCount);
    bytes = (char*) &toCount;

    count =   + ((bytes[0] & 0b10000000)>>7) + ((bytes[0] & 0b01000000)>>6) + ((bytes[0] & 0b00100000)>>5) + ((bytes[0] & 0b00010000)>>4) + ((bytes[0] & 0b00001000)>>3) + ((bytes[0] & 0b00000100)>>2) + ((bytes[0] & 0b00000010)>>1) + ((bytes[0] & 0b00000001)>>0) + ((bytes[1] & 0b10000000)>>7) + ((bytes[1] & 0b01000000)>>6) + ((bytes[1] & 0b00100000)>>5) + ((bytes[1] & 0b00010000)>>4) + ((bytes[1] & 0b00001000)>>3) + ((bytes[1]& 0b00000100)>>2) + ((bytes[1] & 0b00000010)>>1) + ((bytes[1] & 0b00000001)>>0) + ((bytes[2] & 0b10000000)>>7) + ((bytes[2] & 0b01000000)>>6) + ((bytes[2] & 0b00100000)>>5) + ((bytes[2] & 0b00010000)>>4) + ((bytes[2] & 0b00001000)>>3) + ((bytes[2] & 0b00000100)>>2) + ((bytes[2] & 0b00000010)>>1) + ((bytes[2] & 0b00000001)>>0) + ((bytes[3] & 0b10000000)>>7) + ((bytes[3] & 0b01000000)>>6) + ((bytes[3] & 0b00100000)>>5) + ((bytes[3] & 0b00010000)>>4) + ((bytes[3] & 0b00001000)>>3) + ((bytes[3] & 0b00000100)>>2) + ((bytes[3] & 0b00000010)>>1) + ((bytes[3] & 0b00000001)>>0);
    printf("%d\n", count);

  }
  else if(strcmp(option, "turnoff") == 0)
  {
    unsigned number;
    sscanf(argv[optind], "%u", &number);

    printf("%d\n", number & (~(0b00000001 << bOption)));
  }
  else if(strcmp(option, "turnon") == 0)
  {
    unsigned number;
    sscanf(argv[optind], "%u", &number);

    printf("%d\n", number | (0b00000001 << bOption));
  }
  else if(strcmp(option, "div16") == 0) 
  {
    long int value = atol(argv[optind]);
    printf("\n%ld", div16(value));
  }

}

long div16(long value) //2.42
{
  char signByte = *((char*)&value);
  char signBit = (signByte  & 0b10000000) >> 7;  
  return value + ( signBit * 0b00001111 ) >> 4;
}