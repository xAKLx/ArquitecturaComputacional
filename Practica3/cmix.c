#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "func.h"

int main(int argc, char** argv)
{
  int c;
  int bOption;
  char *option = NULL;

  while((c = getopt (argc, argv, "o:")) != -1)
    switch(c)
    {
      case 'o':
      option = optarg;
      break;
      
      case 'b':
      bOption = atoi(optarg);
      break;
    }

  if (strcmp(option, "switch") == 0)
  {
    
    unsigned toWork;
    int byte1 = atoi(argv[optind]);
    int byte2 = atoi(argv[optind+1]);
    sscanf(argv[optind+2], "%u", &toWork);
    switchBytes(toWork, byte1, byte2);
  
  }
  if (strcmp(option, "higher") == 0)
  {
    unsigned len = argc - optind;
    unsigned * numbers = (unsigned*)malloc(len * sizeof(unsigned));
    int i;
    
    for(i = 0; i < len; i++)
    {
      numbers[i] = atoi(argv[optind + i]);
    }
    
    printHigher(numbers, len);
    
    free(numbers);
  }
  else if(strcmp(option, "count") == 0)
  {
    unsigned toCount;

    sscanf(argv[optind], "%u", &toCount);
    countOnes(toCount);

  }
  else if(strcmp(option, "l2u") == 0)
  {
    lowerToUpper(argv[optind]);
  }
}